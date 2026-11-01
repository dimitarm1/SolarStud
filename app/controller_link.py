"""Serial link to the STM32 tanning-bed controllers.

Implements the request/reply half of protocol.md (Status query only, for
now) over a real RS-232/HC-12 serial connection. See protocol.md for the
on-wire format this encodes/decodes.

Timing notes (measured against a live controller on an HC-12 wireless link):
the round trip for a Status query was a consistent ~200 ms, clearly more
than the ~8.3 ms/byte the raw 1200-baud link would suggest - the HC-12
module pair adds its own fixed packetization delay. DEFAULT_REPLY_TIMEOUT
is set with headroom above that. Also, on open, DTR and RTS must be driven
low and given a brief moment to settle before the first byte is sent -
otherwise replies are consistently corrupted (observed on a USB-serial
adapter whose DTR/RTS lines are tied into the dongle's own HC-12 module).
"""

import threading
import time

import serial

MIN_ADDRESS = 0
MAX_ADDRESS = 14  # address 15 behaves differently internally in the firmware - see protocol.md §7

BAUD_RATE = 1200
CMD_STATUS = 0
CMD_START = 1  # not used - see protocol.md §4.2, it's firmware-marked test-only
CMD_SET_PRE_TIME = 2
CMD_SET_COOL_TIME = 3
CMD_SET_MAIN_TIME = 5

STATUS_NAMES = {0: "free", 1: "working", 2: "cooling", 3: "waiting"}

DEFAULT_REPLY_TIMEOUT = 0.45  # seconds; measured round trip is ~0.2s, this gives it headroom
OPEN_SETTLE_SECONDS = 0.2
# The final echo byte of a Set-Time handshake (see set_time_on) is a
# fire-and-forget write - ser.write() returns once the byte is queued
# locally, not once the controller has actually received and processed it
# over the RF link's own one-way transmission delay. Without this, a status
# query issued immediately after set_time() returns (e.g. the page reload
# right after Start) can catch the controller before it's finished
# committing and read its old, stale status - which a status-reconciling
# caller would (reasonably) read as "nothing is running" and undo what was
# just started. Sized with headroom above the ~200ms round trip measured
# for a Status command (this is only a one-way send, but we don't have a
# precise one-way-only measurement, so it's safer to assume parity).
COMMIT_SETTLE_SECONDS = 0.3
SCAN_RETRIES = 2  # total attempts per address when scanning, to ride out a dropped RF packet

_lock = threading.Lock()


class ControllerLinkError(Exception):
    """The serial port could not be opened or used."""


class SetTimeError(ControllerLinkError):
    """The Set-Time handshake didn't complete - no/garbled checksum reply,
    or the controller's checksum didn't match what we computed locally."""


def _command_byte(address, command):
    return 0x80 | ((address & 0x0F) << 3) | (command & 0x07)


def _to_bcd(value):
    return (value % 10) | (((value // 10) % 10) << 4)


def _decode_status_reply(byte_value):
    status_bits = (byte_value >> 6) & 0x03
    bcd = byte_value & 0x3F
    minutes = (bcd & 0x0F) + ((bcd >> 4) * 10)
    return {
        "status": STATUS_NAMES.get(status_bits, "unknown"),
        "remaining_min": minutes,
    }


def _open_port(port, timeout):
    try:
        ser = serial.Serial()
        ser.port = port
        ser.baudrate = BAUD_RATE
        ser.bytesize = serial.EIGHTBITS
        ser.parity = serial.PARITY_NONE
        ser.stopbits = serial.STOPBITS_ONE
        ser.timeout = timeout
        ser.dsrdtr = False
        ser.rtscts = False
        ser.open()
        # Must be driven low (not just left at pyserial's default-high
        # state) and given a moment to settle, or replies come back
        # corrupted - see module docstring.
        ser.setDTR(False)
        ser.setRTS(False)
    except serial.SerialException as exc:
        raise ControllerLinkError(f"Неуспешно отваряне на серийния порт {port!r}: {exc}") from exc
    time.sleep(OPEN_SETTLE_SECONDS)
    return ser


def query_status_on(ser, address):
    """Send a Status query to one address on an already-open, settled port."""
    ser.reset_input_buffer()
    ser.write(bytes([_command_byte(address, CMD_STATUS)]))
    reply = ser.read(1)
    if len(reply) != 1:
        return None
    return _decode_status_reply(reply[0])


def query_status(port, address, timeout=DEFAULT_REPLY_TIMEOUT):
    """Open a connection, query one address, and close it again."""
    with _lock:
        ser = _open_port(port, timeout)
        try:
            return query_status_on(ser, address)
        finally:
            ser.close()


def query_many(port, addresses, timeout=DEFAULT_REPLY_TIMEOUT):
    """Query several addresses on one open connection - for status polling
    across multiple real beds, this avoids paying OPEN_SETTLE_SECONDS again
    for every single one. No retries (this is a routine poll, not a
    discovery scan): a miss just means that bed's status falls back to
    whatever the caller already knows.

    Returns {address: {"status", "remaining_min"} or None}.
    """
    with _lock:
        ser = _open_port(port, timeout)
        try:
            return {address: query_status_on(ser, address) for address in addresses}
        finally:
            ser.close()


def scan(port, addresses=None, timeout=DEFAULT_REPLY_TIMEOUT, retries=SCAN_RETRIES):
    """Poll each address in turn on one open connection.

    Returns a list of {"address", "status", "remaining_min"} dicts for every
    address that replied. Each address gets up to `retries` attempts before
    being counted as not present, since a dropped RF packet otherwise reads
    as "no controller here" even when one is.
    """
    if addresses is None:
        addresses = range(MIN_ADDRESS, MAX_ADDRESS + 1)
    found = []
    with _lock:
        ser = _open_port(port, timeout)
        try:
            for address in addresses:
                result = None
                for _attempt in range(retries):
                    result = query_status_on(ser, address)
                    if result is not None:
                        break
                if result is not None:
                    found.append({"address": address, **result})
        finally:
            ser.close()
    return found


SET_TIME_RETRIES = 10  # a dropped RF packet at the edge of range shouldn't fail a start/stop outright - see set_time_on


VERIFY_STATUS_RETRIES = 4  # status reads after a Set-Time, to ride out a dropped RF packet


def _set_time_attempt(ser, address, pre_min, main_min, cool_min):
    """One attempt at the checksummed Set-Time handshake (protocol.md §5).

    The checksum is sent straight after the cool-time byte, without waiting
    for the controller's own checksum reply first. Older controllers only
    accept the echo within a short window after the cool-time byte, and the
    ~240ms RF round trip misses it - the checksum reply arrives correct,
    but the echo is then silently ignored and nothing is committed
    (observed on addresses 1 and 11). The old Delphi program does the same
    for the RF link (SolarStud/main.pas: SendData, "Old controllers has
    small checksum receive timeout"); newer controllers accept it too.

    Since sending it blind means the checksum reply no longer confirms
    anything, the result is verified with a Status query instead. Raises
    SetTimeError if the controller never answered, or is not in the state
    the new times should have put it in.
    """
    pre_min = pre_min & 0x7F
    cool_min = cool_min & 0x7F
    main_bcd = _to_bcd(main_min) & 0x7F
    checksum = (pre_min + cool_min - main_bcd - 5) & 0x7F

    ser.reset_input_buffer()
    ser.write(bytes([
        _command_byte(address, CMD_SET_PRE_TIME), pre_min,
        _command_byte(address, CMD_SET_MAIN_TIME), main_bcd,
        _command_byte(address, CMD_SET_COOL_TIME), cool_min,
        checksum,
    ]))
    ser.read(1)  # the controller's own checksum reply - drained, not relied on
    time.sleep(COMMIT_SETTLE_SECONDS)

    status = None
    for _attempt in range(VERIFY_STATUS_RETRIES):
        status = query_status_on(ser, address)
        if status is not None:
            break
    if status is None:
        raise SetTimeError(f"Няма отговор от адрес {address} при проверка на състоянието")

    stopping = not (pre_min or main_bcd or cool_min)
    if (status["status"] == "free") != stopping:
        raise SetTimeError(
            f"Адрес {address} не прие новите времена "
            f"(състояние след командата: {status['status']})"
        )


def set_time_on(ser, address, pre_min, main_min, cool_min, retries=SET_TIME_RETRIES):
    """Run the checksummed Set-Time handshake on an already-open, settled
    port (protocol.md §5) - the real start/stop mechanism: non-zero values
    start a session, all zeros stop one.

    Retries the whole handshake from scratch (fresh reset_input_buffer,
    fresh write of all three values) up to `retries` times on a dropped or
    garbled reply before giving up - over the RF link a single missed
    packet at the edge of range otherwise reads as "the controller can't
    be reached" even when it's simply a one-off drop. The old Delphi
    program did the same for the same reason (SolarStud/main.pas:
    SendData's own retry loop around this exact handshake, also resending
    the full sequence from scratch on each attempt rather than trying to
    resume a partial one - a half-completed handshake isn't a state
    either side can safely continue from).

    Raises SetTimeError if every attempt fails - its message leads with
    the retry count (so staff reading it on screen know this isn't a
    single dropped packet - the system already tried repeatedly and the
    bed genuinely isn't answering) followed by the last attempt's own
    detail for diagnosis.
    """
    last_exc = None
    for _attempt in range(retries):
        try:
            _set_time_attempt(ser, address, pre_min, main_min, cool_min)
            return
        except SetTimeError as exc:
            last_exc = exc
    raise SetTimeError(
        f"Леглото на адрес {address} не отговори след {retries} опита. "
        f"Проверете дали е включено и в обхват. ({last_exc})"
    ) from last_exc


def set_time(port, address, pre_min, main_min, cool_min, timeout=DEFAULT_REPLY_TIMEOUT, retries=SET_TIME_RETRIES):
    """Open a connection, run the Set-Time handshake for one address, and
    close it again. Raises SetTimeError if every attempt fails - see
    set_time_on."""
    with _lock:
        ser = _open_port(port, timeout)
        try:
            set_time_on(ser, address, pre_min, main_min, cool_min, retries=retries)
        finally:
            ser.close()
