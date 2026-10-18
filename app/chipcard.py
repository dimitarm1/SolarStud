"""SLE4442 chip-card integration via an ACS ACR38/ACR30-class PC/SC reader.

Ported from the original Delphi program (SolarStud/SLE4442.pas,
SolarStud/ACSModule.pas) so that physical cards already issued by it keep
working unchanged here: the on-card byte layout, the "select card type"
vendor handshake, and the pseudo-APDU command set (class FF: B0=read,
D0=write, 20=verify PSC, D2=change PSC) are all reproduced field-for-field.

Unlike this app's own virtual cards (tracked in the database as FIFO
lots), a chip card's balance lives only on the card itself - read fresh
and written back on every transaction, exactly how the old program
worked, so a single physical card stays usable in either program.
"""

import time

# pyscard needs its native PCSC bindings built against the local system
# (on Linux, the libpcsclite-dev headers - see requirements.txt). Rather
# than making the whole app fail to start on a machine where that hasn't
# been set up yet (or where there's simply no card reader at all), the
# import failure is deferred to the point something actually tries to
# talk to a reader, where it surfaces as a normal ChipCardError.
try:
    from smartcard.scard import (
        SCARD_CTL_CODE,
        SCARD_PCI_T0,
        SCARD_PCI_T1,
        SCARD_PROTOCOL_T0,
        SCARD_PROTOCOL_T1,
        SCARD_S_SUCCESS,
        SCARD_SCOPE_USER,
        SCARD_SHARE_DIRECT,
        SCARD_SHARE_SHARED,
        SCARD_UNPOWER_CARD,
        SCardConnect,
        SCardControl,
        SCardDisconnect,
        SCardEstablishContext,
        SCardGetErrorMessage,
        SCardListReaders,
        SCardReleaseContext,
        SCardTransmit,
    )
    _IMPORT_ERROR = None
except ImportError as exc:
    _IMPORT_ERROR = exc


class ChipCardError(Exception):
    """Raised for chip-card read/write failures - mirrors
    controller_link.ControllerLinkError."""


# --- on-card field layout (SolarStud/SLE4442.pas: SLE4442ReadCardInfo /
# SLE4442WriteCardInfo) - addresses and lengths into the chip's 256-byte
# main memory. Keep these exact: changing them would make cards written
# by this app unreadable by the old one, or vice versa.
STUDIO_NAME_ADDR, STUDIO_NAME_LEN = 0x80, 15
CLIENT_NAME_ADDR, CLIENT_NAME_LEN = 0x90, 31
BALANCE_ADDR = 0xB0          # 3 bytes, big-endian, value = leva * 100
CLIENT_NUMBER_ADDR = 0xF6    # 3 bytes, big-endian, 0xFFFFFF = unset
STUDIO_NUMBER_ADDR = 0xF9    # 1 byte
PSC_COPY_ADDR = 0xFA         # 3 bytes - app-level mirror of the security code
CARD_NUMBER_ADDR = 0xFD      # 3 bytes, big-endian, 0xFFFFFF = unset

UNSET_UINT24 = [0xFF, 0xFF, 0xFF]
DEFAULT_PSC = bytes([0xFF, 0xFF, 0xFF])  # the project's "unlocked/default" PSC

# SLE4442's error counter is a 3-bit pattern (all bits set = all 3 tries
# available), returned by this reader as SW2 of a VERIFY response, and
# also readable directly via the FF B1 counter command (see read_card's
# err_counter/ok fields). A correct PSC resets it back to this value.
PSC_TRIES_FULL = 0x07

# ACS vendor IOCTL (ACSModule.pas: IOCTL_SMARTCARD_SET_CARD_TYPE, "for
# ACR30/38") and the card-type code for SLE4432/SLE4442 memory cards -
# both specific to that reader family, needed because a synchronous
# memory card isn't a standard ISO 7816 card the reader handles natively.
_IOCTL_SET_CARD_TYPE = SCARD_CTL_CODE(2060) if _IMPORT_ERROR is None else None
_CARD_TYPE_SLE4442 = [0x12, 0x00, 0x00, 0x00]
_SELECT_SLE4442_APDU = [0xFF, 0xA4, 0x00, 0x00, 0x01, 0x06]


# --- byte <-> value helpers ------------------------------------------------

def _uint24_be(value):
    value = max(0, min(0xFFFFFF, int(value)))
    return [(value >> 16) & 0xFF, (value >> 8) & 0xFF, value & 0xFF]


def _bytes_to_uint24(data):
    return (data[0] << 16) | (data[1] << 8) | data[2]


def _decode_text(data_bytes):
    """Cards store names in the Bulgarian Windows-1251 codepage (how the
    old Delphi program's ANSI `string` encoded Cyrillic text) and null-
    terminate within the fixed-width field - matches `Pos(#0, Data) - 1`
    in SLE4442ReadCardInfo exactly, including its quirk that a field
    with no null byte at all (fully packed) reads as empty rather than
    as the full text."""
    try:
        null_pos = data_bytes.index(0)
    except ValueError:
        return ""
    return bytes(data_bytes[:null_pos]).decode("cp1251", errors="replace")


def _encode_text(text, length):
    raw = (text or "").encode("cp1251", errors="replace")[:length]
    return list(raw) + [0x00] * (length - len(raw))


# --- reader discovery --------------------------------------------------

def list_readers():
    """Names of connected PC/SC readers, for the Studio settings picker.
    Best-effort: any PCSC-layer hiccup (service not running, no driver on
    this machine, pyscard itself not installed, ...) just means an empty
    list rather than a crash, since this only ever feeds a dropdown."""
    if _IMPORT_ERROR is not None:
        return []
    try:
        hresult, hcontext = SCardEstablishContext(SCARD_SCOPE_USER)
        if hresult != SCARD_S_SUCCESS:
            return []
        try:
            hresult, names = SCardListReaders(hcontext, [])
            return list(names) if hresult == SCARD_S_SUCCESS else []
        finally:
            SCardReleaseContext(hcontext)
    except Exception:
        return []


def _check(hresult, action):
    if hresult != SCARD_S_SUCCESS:
        raise ChipCardError(f"Грешка при {action}: {SCardGetErrorMessage(hresult)}")


class _Session:
    """One open reader connection, carrying the handles every low-level
    SCard* call needs. Used as a context manager so the card is always
    disconnected and the context released, even if a command fails
    partway through."""

    def __init__(self, reader_name):
        self.reader_name = reader_name
        self.hcontext = None
        self.hcard = None
        self.protocol = None

    def __enter__(self):
        if _IMPORT_ERROR is not None:
            raise ChipCardError(
                "Библиотеката за чип карти (pyscard) не е инсталирана - "
                f"вижте requirements.txt. ({_IMPORT_ERROR})"
            )
        hresult, self.hcontext = SCardEstablishContext(SCARD_SCOPE_USER)
        _check(hresult, "свързване с четеца")

        hresult, names = SCardListReaders(self.hcontext, [])
        _check(hresult, "изброяване на четци")
        if not names:
            raise ChipCardError("Не е открит четец за чип карти.")
        name = self.reader_name or names[0]
        if name not in names:
            raise ChipCardError(f'Четецът "{name}" не е открит.')

        # The direct-connect / vendor "set card type" IOCTL / reconnect
        # dance below is an ACS-specific extension (SLE4442.pas:
        # SLE4442Init) that only ACS's own PC/SC driver implements. A
        # reader exposed through the generic CCID driver (as is typical
        # on Linux, and also common with OMNIKEY/ICC-branded readers on
        # Windows) reports that in its name and doesn't support this
        # IOCTL at all - sending it anyway fails with "feature not
        # supported", so skip straight to a normal shared connection,
        # exactly as the old program did for such readers.
        name_upper = name.upper()
        needs_card_type_select = not any(
            token in name_upper for token in ("CCID", "OMNIKEY", "ICC")
        )

        if needs_card_type_select:
            # 1. Direct connection, so the reader's vendor control channel
            #    is open even before any card protocol has been negotiated.
            hresult, self.hcard, _proto = SCardConnect(
                self.hcontext, name, SCARD_SHARE_DIRECT, 0
            )
            if hresult != SCARD_S_SUCCESS:
                raise ChipCardError("Поставете карта в четеца.")

            # 2. Tell the reader's firmware to treat the card as an
            #    SLE4442 memory card (ACR30/38-specific).
            hresult, _resp = SCardControl(
                self.hcard, _IOCTL_SET_CARD_TYPE, _CARD_TYPE_SLE4442
            )
            _check(hresult, "задаване на типа на картата")

            # 3. Reconnect in shared mode, as the pseudo-APDU layer expects.
            hresult = SCardDisconnect(self.hcard, SCARD_UNPOWER_CARD)
            _check(hresult, "пресвързване с четеца")

        hresult, self.hcard, self.protocol = SCardConnect(
            self.hcontext, name, SCARD_SHARE_SHARED,
            SCARD_PROTOCOL_T0 | SCARD_PROTOCOL_T1,
        )
        if hresult != SCARD_S_SUCCESS:
            raise ChipCardError("Поставете карта в четеца.")

        # 4. Select the SLE4432/4442 card type for the pseudo-APDU layer.
        self.transmit(_SELECT_SLE4442_APDU, "разпознаване на картата като SLE4442")
        return self

    def __exit__(self, exc_type, exc, tb):
        if self.hcard is not None:
            SCardDisconnect(self.hcard, SCARD_UNPOWER_CARD)
        if self.hcontext is not None:
            SCardReleaseContext(self.hcontext)
        return False

    def _pci(self):
        return SCARD_PCI_T0 if self.protocol == SCARD_PROTOCOL_T0 else SCARD_PCI_T1

    def transmit(self, apdu, action):
        hresult, response = SCardTransmit(self.hcard, self._pci(), apdu)
        _check(hresult, action)
        if len(response) < 2 or tuple(response[-2:]) != (0x90, 0x00):
            sw = "".join(f"{b:02X}" for b in response[-2:]) if len(response) >= 2 else "?"
            raise ChipCardError(f"Неуспешно {action} (SW={sw}).")
        return response[:-2]

    def read_field(self, addr, length):
        return self.transmit([0xFF, 0xB0, 0x00, addr, length], f"четене на адрес {addr:02X}")

    def write_field(self, addr, data_bytes):
        # Hard safety floor: writing below 0x80 has permanently bricked
        # real SLE4442 cards (reader reports "Card absent or mute" ever
        # after - see blank_card's docstring). Every legitimate field
        # this app or the old Delphi program ever writes lives at 0x80
        # or above, so this can never be a legitimate call.
        if addr < 0x80 or addr + len(data_bytes) > 0x100:
            raise ChipCardError(
                f"Опасен запис отказан (адрес {addr:02X}, {len(data_bytes)} байта) - "
                "извън позволения диапазон 0x80-0xFF."
            )
        apdu = [0xFF, 0xD0, 0x00, addr, len(data_bytes)] + list(data_bytes)
        self.transmit(apdu, f"запис на адрес {addr:02X}")

    def verify_psc(self, psc):
        # Unlike every other command here, a VERIFY's response doesn't
        # follow the flat "90 00 = ok" convention: SW1=90 means the card
        # answered either way, but SW2 carries the PSC try-counter that
        # results from this attempt (see PSC_TRIES_FULL) - 07 means the
        # code was correct and the counter reset to all 3 tries; any
        # other value under SW1=90 means it was wrong and a try was just
        # spent, which must stop immediately rather than let a caller
        # plough on into a write that would fail anyway while risking
        # the card's last attempts.
        apdu = [0xFF, 0x20, 0x00, 0x00, 0x03] + list(psc)
        hresult, response = SCardTransmit(self.hcard, self._pci(), apdu)
        _check(hresult, "въвеждане на защитния код (PSC)")
        if len(response) < 2:
            raise ChipCardError("Неуспешно въвеждане на защитния код (PSC) (няма отговор).")
        sw1, sw2 = response[-2], response[-1]
        if sw1 != 0x90:
            raise ChipCardError(
                f"Неуспешно въвеждане на защитния код (PSC) (SW={sw1:02X}{sw2:02X})."
            )
        if sw2 != PSC_TRIES_FULL:
            raise ChipCardError(
                f"Грешен защитен код (PSC) - броячът за опити вече не е пълен "
                f"(SW2={sw2:02X}). НЕ пробвайте отново необмислено - картата може "
                "да се заключи трайно след изчерпване на опитите."
            )

    def change_psc(self, new_psc):
        apdu = [0xFF, 0xD2, 0x00, 0x01, 0x03] + list(new_psc)
        self.transmit(apdu, "смяна на защитния код (PSC)")


# --- public API --------------------------------------------------------

def read_card(reader_name=None):
    """Read everything this app (and the old program) stores on a card.
    Raises ChipCardError if no reader/card is available or the card
    isn't recognized as an SLE4442."""
    with _Session(reader_name) as s:
        studio_name = _decode_text(s.read_field(STUDIO_NAME_ADDR, STUDIO_NAME_LEN))
        client_name = _decode_text(s.read_field(CLIENT_NAME_ADDR, CLIENT_NAME_LEN))

        balance_raw = _bytes_to_uint24(s.read_field(BALANCE_ADDR, 3))
        # Mirrors the Delphi `if Temp > 65535 then Temp := -1` cap exactly:
        # a balance above 655.35 leva reads as corrupt/unreadable, not a
        # real value, same as the old program treated it.
        balance = balance_raw / 100.0 if balance_raw <= 0xFFFF else None

        client_number = _bytes_to_uint24(s.read_field(CLIENT_NUMBER_ADDR, 3))
        if client_number == 0xFFFFFF:
            client_number = None

        studio_number = s.read_field(STUDIO_NUMBER_ADDR, 1)[0]
        psc = bytes(s.read_field(PSC_COPY_ADDR, 3))

        card_number = _bytes_to_uint24(s.read_field(CARD_NUMBER_ADDR, 3))
        if card_number == 0xFFFFFF:
            card_number = None

        counter = s.transmit([0xFF, 0xB1, 0x00, 0x00, 0x04], "четене на брояча за опити")
        err_counter = counter[0]

        return {
            "studio_name": studio_name,
            "client_name": client_name,
            "balance": balance,
            "client_number": client_number,
            "studio_number": studio_number,
            "psc": psc.hex().upper(),
            "card_number": card_number,
            "err_counter": err_counter,
            "ok": err_counter == PSC_TRIES_FULL,
        }


def _blank_bytes(length):
    """A freshly erased SLE4442 reads back as all-1 bits - this is that
    same state, for wiping a field back to it (as opposed to writing a
    real value through its normal encoding)."""
    return [0xFF] * length


def write_card(reader_name=None, psc=DEFAULT_PSC, new_psc=None, **fields):
    """Write any of studio_name, client_name, balance, client_number,
    studio_number, card_number onto the card. Fields left out of
    `fields` are untouched. `psc` is the card's *current* security code
    (default FFFFFF, the old program's convention for an unprogrammed
    card) - required to unlock writes, verified first.

    For studio_name/client_name/balance specifically, passing None
    (as opposed to leaving the field out, or passing "" / 0.0) wipes
    that field back to the chip's erased 0xFF state instead of encoding
    it as a real empty/zero value - used by sales.clear_chip_card to
    return a card to the same blank state a virgin SLE4442 ships in.
    client_number/card_number already use their own all-0xFF sentinel
    for "unset" (UNSET_UINT24) regardless of this, and studio_number's
    blank state is just the single byte 0xFF passed directly.

    If `new_psc` is given, the card's security code is changed to it as
    part of the same verified session - both the real hardware security
    memory (the actual lock) and the readable main-memory copy at
    PSC_COPY_ADDR that every write here (including this one, next time)
    relies on to find the right code again. The two are always written
    together so they can never drift apart from each other."""
    with _Session(reader_name) as s:
        s.verify_psc(psc)
        if "studio_name" in fields:
            value = fields["studio_name"]
            s.write_field(
                STUDIO_NAME_ADDR,
                _blank_bytes(STUDIO_NAME_LEN) if value is None else _encode_text(value, STUDIO_NAME_LEN),
            )
        if "client_name" in fields:
            value = fields["client_name"]
            s.write_field(
                CLIENT_NAME_ADDR,
                _blank_bytes(CLIENT_NAME_LEN) if value is None else _encode_text(value, CLIENT_NAME_LEN),
            )
        if "balance" in fields:
            value = fields["balance"]
            if value is None:
                s.write_field(BALANCE_ADDR, _blank_bytes(3))
            else:
                cents = round(max(0.0, float(value)) * 100)
                s.write_field(BALANCE_ADDR, _uint24_be(cents))
        if "client_number" in fields:
            value = fields["client_number"]
            s.write_field(CLIENT_NUMBER_ADDR, _uint24_be(value) if value is not None else UNSET_UINT24)
        if "studio_number" in fields:
            s.write_field(STUDIO_NUMBER_ADDR, [int(fields["studio_number"]) & 0xFF])
        if "card_number" in fields:
            value = fields["card_number"]
            s.write_field(CARD_NUMBER_ADDR, _uint24_be(value) if value is not None else UNSET_UINT24)
        if new_psc is not None:
            s.change_psc(new_psc)
            s.write_field(PSC_COPY_ADDR, list(new_psc))


def change_psc(reader_name, old_psc, new_psc):
    with _Session(reader_name) as s:
        s.verify_psc(old_psc)
        s.change_psc(new_psc)


_BLANK_CHUNK_LEN = 32  # 128 / 32 = 4 writes; well within any reader's per-APDU limit
_BLANK_RANGE_START = 0x80  # NEVER go below this - see blank_card's docstring
_BLANK_WRITE_DELAY_S = 0.3  # pause between page writes - see blank_card's docstring


def blank_card(reader_name=None, psc=DEFAULT_PSC, new_psc=DEFAULT_PSC):
    """Erase main memory from 0x80 up to (and including) 0xFF back to the
    chip's native erased state - the entire range this app (and the old
    Delphi program before it) ever reads or writes - rather than just
    the handful of named sub-fields within it, so a card comes back
    genuinely blank regardless of what any program ever wrote into any
    of those bytes. Also resets the PSC (the real hardware lock, plus
    its readable PSC_COPY_ADDR mirror) to new_psc, same as write_card's.

    NEVER extend this below 0x80: the old program's own ClearCard()
    never touches that region either, and an earlier version of this
    function that did write there left two real SLE4442 cards
    permanently unresponsive ("Card absent or mute" at the reader's
    power-up stage, on every card tried, every time) - whatever lives
    down there, writing to it breaks the card at a level this app
    cannot undo (SLE4442 has no master recovery). A deliberate pause
    between each page write, rather than firing them back-to-back, is
    the other change made after that incident."""
    chunk = [0xFF] * _BLANK_CHUNK_LEN
    with _Session(reader_name) as s:
        s.verify_psc(psc)
        for addr in range(_BLANK_RANGE_START, 0x100, _BLANK_CHUNK_LEN):
            s.write_field(addr, chunk)
            time.sleep(_BLANK_WRITE_DELAY_S)
        if new_psc is not None:
            s.change_psc(new_psc)
            s.write_field(PSC_COPY_ADDR, list(new_psc))
