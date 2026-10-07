# Tanning Bed Controller Serial Protocol

This document describes the serial protocol spoken by the STM32-based tanning
bed controllers (the hardware that drives each physical bed: lamps, fan,
7-segment display, local buttons). It was reverse-engineered directly from
the controller firmware source, specifically `HAL_UART_RxCpltCallback()` and
its supporting code, in:

```text
/media/devop/DATA/stm_projects/workspace_nov_kontroler/nov_kontroler/Core/Src/main.c
```

Line references below (e.g. `main.c:1038`) point at that file as it stood
when this document was written; re-check them if the firmware changes.

This is a from-source reconstruction, not a spec the firmware author wrote
down — where the code's behavior is surprising or looks unintentional, it is
called out explicitly in [Known firmware quirks](#7-known-firmware-quirks)
rather than silently "corrected" here.

## 1. Physical layer

- **Baud rate:** 1200
- **Framing:** 8 data bits, no parity, 1 stop bit (8N1)
- **Duplex:** half-duplex, shared bus — every controller sees every byte
- **Byte time:** 10 bits / 1200 baud ≈ **8.3 ms per byte**

Each controller has two UART peripherals wired to the *same* protocol
decoder and the same receive state (`main.c:85-86`, `main.c:283-284`,
`main.c:1038`):

| Peripheral | Physical link | Notes |
|---|---|---|
| `USART1` | Wireless, via an HC-12 433 MHz module | Also used in a separate AT-command mode to configure the HC-12's channel/power (`HC12_SetParams()`, `main.c:184`) — that's module provisioning, not this data protocol. |
| `USART2` | Wired | Direct link, same byte-level protocol as above. |

Because both peripherals share one global decoder state (`data`, `rx_state`,
etc.), a single controller is not designed to hold two independent
conversations (wired + wireless) at once — in practice a given controller is
reached over one link or the other.

**Bus topology:** this is a multi-drop bus. Every controller has a 4-bit
address (0–15, see [§3](#3-frame-format)) set locally via the panel's service
menu (`mode_set_address`, `main.c:1387`) — **there is no command in this
protocol to set or read a controller's address remotely.** The host must
know each controller's configured address out of band.

## 2. Transaction model

The host is always the initiator; controllers never speak first. Every
transaction starts with a single **command byte** (bit 7 set) addressed to
one controller. Controllers that are *not* addressed reset their own
in-progress receive state and otherwise ignore the byte (`main.c:1050-1059`)
— so the host must complete (or time out) one controller's transaction
before starting another's; transactions to different addresses are not
safely interleavable.

Two things happen fully inside the UART receive interrupt, with no separate
transmit call: the Status reply, and the checksum echo for a time-set
sequence. Both write straight to `huart->Instance->TDR` as soon as the
triggering byte is decoded (`main.c:1070`, `main.c:1119`). The host should be
ready to read that reply byte immediately after sending the byte that
triggers it — there's no delimiter, length prefix, or distinct "response
frame"; it's just the next byte on the wire.

**Sequence timeout:** receiving any command byte addressed to a controller
arms a 1500 ms watchdog (`Gv_UART_Timeout`, `main.c:1061`). If a
multi-byte time-set sequence (§5) isn't completed within that window, the
controller abandons it — `rx_state` resets and the partially-received
pre/main/cool values are discarded (`main.c:1161-1167`). A host implementation
should budget well under 1.5 s for a full time-set exchange and be prepared
to retry the whole sequence from the beginning (Set Pre-time) on timeout —
there's no way to resume mid-sequence.

## 3. Frame format

A command byte is one byte, built as:

```text
bit:    7      6 5 4 3        2 1 0
field:  1   |  ADDRESS[3:0] | COMMAND[2:0]
```

```c
command_byte = 0x80 | ((address & 0x0F) << 3) | (command & 0x07)
```

- Bit 7 = 1 marks this byte as a command/address byte (`main.c:1046`).
- Bits 6–3 = target controller address, 0–15 (`main.c:1047`).
- Bits 2–0 = command code, 0–7 (`main.c:1062` onward).

A byte with **bit 7 clear** is never a new command — it's a *payload* byte,
interpreted according to whatever multi-byte sequence the controller
currently has armed (`main.c:1092`, `rx_state`). This means every payload
and checksum byte the host sends must have bit 7 clear, i.e. be in the range
`0x00`–`0x7F`. See [§6](#6-encoding-limits-bit-7-collisions) for where this
bites.

## 4. Commands

| Code | Name | Direction | Payload | Behavior |
|---|---|---|---|---|
| 0 | Status | host → controller | none | Controller replies immediately with 1 status byte (§4.1). |
| 1 | Start | host → controller | none | See [§4.2](#42-command-1-start--not-recommended) — not the general start mechanism. |
| 2 | Set Pre-time | host → controller | 1 byte, raw binary | Arms the time-set sequence (§5). |
| 3 | Set Cool-time | host → controller | 1 byte, raw binary | Final step of the sequence; triggers the checksum reply (§5). |
| 4 | — | — | — | Not handled by the firmware; ignored if sent. |
| 5 | Set Main-time | host → controller | 1 byte, BCD | Middle step of the sequence (§5). |
| 6 | — | — | — | Not handled by the firmware; ignored if sent. |
| 7 | — | — | — | Not handled by the firmware; ignored if sent. |

### 4.1 Command 0: Status

Request: a single command byte with `command = 0`, no payload.

Reply: the controller writes one byte back immediately (`main.c:1062-1071`):

```c
uint16_t time = curr_time / 60;
if (curr_time) time += 1;        // always +1 while any time is running — see §6
reply_byte = (curr_status << 6) | to_bcd(time);
```

- `curr_time` is whichever of pre/main/cool time is currently active, in
  **seconds**.
- `to_bcd(time)` packs `time` (0–99 decimal) as two BCD nibbles into one
  byte — see [§6](#6-encoding-limits-bit-7-collisions) for its caveat.
- `curr_status` (2 bits, occupying bits 7–6 of the reply):

  | Value | Name | Meaning |
  |---|---|---|
  | 0 | `STATUS_FREE` | Idle |
  | 1 | `STATUS_WORKING` | Active tanning phase |
  | 2 | `STATUS_COOLING` | Cooling phase |
  | 3 | `STATUS_WAITING` | Preparation phase |

**Worked example:** controller in `STATUS_WAITING` (3) with 119 seconds of
pre-time left: `time = 119/60 + 1 = 2`, `to_bcd(2) = 0x02`, reply =
`(3 << 6) | 0x02` = **`0xC2`**.

### 4.2 Command 1: "Start" — not recommended

```c
else if ((data & 0x07) == 1) //Command 1 - Start
{
    if (main_time <= 2) {   // Only use for test purposes
        pre_time = 0;
        update_status();
    }
}
```

(`main.c:1072-1078`)

This only has any effect when `main_time` is already ≤ 2 **seconds** —
essentially never, in normal operation, since `main_time` is set in whole
minutes (multiples of 60). The firmware's own comment marks it test-only.
**Do not use this as the general start mechanism** — use the time-set
sequence below for both starting and stopping, exactly as the controller's
own local Start button does (`main.c:1287-1298`).

## 5. Setting the time — the real Start/Stop mechanism

There is no dedicated "stop" command either. Starting and stopping are both
done by sending a full **pre-time / main-time / cool-time** triple — to
start, with real (non-zero) values; to stop, with all zeros. This matches
exactly how the controller's own firmware treats a fresh time as the trigger
to (re)enter `STATUS_WAITING` → `STATUS_WORKING` → `STATUS_COOLING`, or
`STATUS_FREE` when everything is zero (`update_status()`, `main.c:1578-1595`).

This is also the **only command with a checksum** (`main.c:1095-1120`), which
is why it's preferred for start/stop even when a plain Start existed.

The sequence is six bytes out, one byte in, then one byte out again — **in
this exact order**, each step strictly depending on the one before it:

| # | Direction | Byte | Meaning |
|---|---|---|---|
| 1 | host → ctrl | `0x80 \| (addr<<3) \| 2` | Set Pre-time command |
| 2 | host → ctrl | `pre_time` (raw binary, minutes) | Pre-time payload |
| 3 | host → ctrl | `0x80 \| (addr<<3) \| 5` | Set Main-time command |
| 4 | host → ctrl | `to_bcd(main_time)` (BCD, minutes) | Main-time payload |
| 5 | host → ctrl | `0x80 \| (addr<<3) \| 3` | Set Cool-time command |
| 6 | host → ctrl | `cool_time` (raw binary, minutes) | Cool-time payload — **triggers step 7** |
| 7 | ctrl → host | `checksum` | Controller replies immediately with the checksum it computed |
| 8 | host → ctrl | `checksum` | Host echoes the same byte back to confirm |

Only after step 8, **if the echoed byte matches**, does the controller
commit the values (`main.c:1097-1103`):

```c
pre_time  = pre_time_sent * 60;
main_time = main_time_sent * 60;
cool_time = cool_time_sent * 60;
update_status();
```

If the echo doesn't match, nothing is committed and the sequence resets
silently — there is no explicit error/NACK byte, and no acknowledgment byte
for a *successful* commit either. The host's only way to confirm the new
state took effect is a subsequent Status query (§4.1).

**Encoding note:** `pre_time` and `cool_time` are sent as **raw binary**
minute counts (`pre_time_sent = data;`, `cool_time_sent = data;`); only
`main_time` is **BCD-encoded** (`main_time_sent = FromBCD(data);`). This
asymmetry is exactly as implemented — not a typo in this document.

### Checksum formula

Computed by the controller the instant the cool-time payload (step 6)
arrives, using whatever `main_time` was set in step 4 of *this* sequence
(`main.c:1094`, `main.c:1117`):

```c
checksum = (pre_time_sent + cool_time_sent - to_bcd(main_time_sent) - 5) & 0x7F
```

The `& 0x7F` mask is what guarantees the checksum byte always has bit 7
clear, so it can never be mistaken for a new command byte.

### Worked example — Start

Address 5, pre-time 2 min, main (active) time 12 min, cool-time 3 min:

| Step | Byte | Hex |
|---|---|---|
| 1 | Set Pre-time, addr 5 | `0xAA` |
| 2 | pre = 2 | `0x02` |
| 3 | Set Main-time, addr 5 | `0xAD` |
| 4 | main = 12 (BCD) | `0x12` |
| 5 | Set Cool-time, addr 5 | `0xAB` |
| 6 | cool = 3 | `0x03` |
| 7 | *(controller replies)* | `0x6E` |
| 8 | echo | `0x6E` |

`checksum = (2 + 3 - 0x12 - 5) & 0x7F = (-18) & 0x7F = 0x6E` (110 decimal).

### Worked example — Stop

Same controller, all zeros:

| Step | Byte | Hex |
|---|---|---|
| 1 | Set Pre-time, addr 5 | `0xAA` |
| 2 | pre = 0 | `0x00` |
| 3 | Set Main-time, addr 5 | `0xAD` |
| 4 | main = 0 (BCD) | `0x00` |
| 5 | Set Cool-time, addr 5 | `0xAB` |
| 6 | cool = 0 | `0x00` |
| 7 | *(controller replies)* | `0x7B` |
| 8 | echo | `0x7B` |

`checksum = (0 + 0 - 0 - 5) & 0x7F = (-5) & 0x7F = 0x7B` (123 decimal).

## 6. Encoding limits: bit-7 collisions

Because any byte with bit 7 set is treated as a brand-new command/address
byte (§3), every value the host sends mid-sequence must stay under `0x80`:

- **`pre_time` / `cool_time` (raw binary):** safe for 0–127 minutes — no
  realistic session needs more than that.
- **`main_time` (BCD):** `to_bcd(value) = ones | (tens << 4)`. For `value`
  80–99, the tens nibble is 8 or 9, which sets bit 7 of the encoded byte
  (`to_bcd(80) = 0x80`, `to_bcd(99) = 0x99`). **A BCD-encoded main-time of 80
  minutes or more will be misread as a command byte and will break the
  sequence.** The effective ceiling for `main_time` over this protocol is
  **79 minutes**, not 99. (The Flask app's own 1–35 minute session cap is
  comfortably inside this, so this hasn't been an issue in practice — it's
  documented here because it's a hard protocol limit, not a product choice.)
- **The checksum** is explicitly masked (`& 0x7F`) by the firmware, so it's
  always safe.

## 7. Known firmware quirks

These are things observed directly in the source that a host implementation
should be aware of. They are not "fixed" here — this document describes the
firmware as it is.

- **`ToBCD()` has no `return` statement** (`main.c:1217-1225`):

  ```c
  int ToBCD(unsigned value){
      int digits[4];
      int result;
      ...
      result = digits[0] | (digits[1]<<4) | (digits[2]<<8) | (digits[3]<<12);
      // no `return result;`
  }
  ```

  Reading the return value of a function that falls off the end without a
  `return` is undefined behavior in C. In practice, unoptimized ARM-GCC
  builds tend to leave `result` in the register the caller reads it from, so
  it *appears* to work — but this is compiler- and optimization-level
  dependent, not guaranteed. `to_bcd()` (shorthand used elsewhere in this
  document for the firmware's `ToBCD()`) feeds both the Status reply (§4.1)
  and the time-set checksum (§5), so if a future firmware rebuild changes
  this behavior, both would be affected. Worth flagging to whoever maintains
  the firmware, independent of this protocol document.

- **Status reply's status bits can alias with the time field.** The reply
  byte packs `curr_status` into bits 7–6 and `to_bcd(time)` into the
  remaining bits, with no shift to avoid overlap. For `time` ≥ 40
  (tens digit 4 or 5), `to_bcd(time)` sets bit 6 (`to_bcd(40) = 0x40`,
  `to_bcd(59) = 0x59`), colliding with `curr_status`'s own bit 6. A host
  reading a Status reply when ≥ 40 minutes remain on the active phase cannot
  fully trust bit 6 of `curr_status`. This doesn't come up with the current
  1–35 minute app-level session cap, but would if that cap were ever raised.

- **HC-12 AT-mode pin may not be restored after an RF channel change.**
  `HC12_SetParams()` (`main.c:184`) pulls `RF_Prog_Pin` low to enter AT
  command mode, and — based on the code as written — appears to drive it low
  again at the end rather than back high (the GPIO is initialized high, i.e.
  "transparent mode", at boot in `MX_GPIO_Init()`). If that reading is
  correct, changing the RF channel via the local service menu could leave
  the HC-12 stuck out of transparent (data) mode. This is inferred from
  reading the code, not from testing on hardware — worth verifying against a
  real unit before relying on it.

- **Controller address 15 is logged differently internally.** In
  `ProcessButtons()`, run-hour accumulation happens on `STATUS_WORKING` for
  every address *except* 15, and on `STATUS_COOLING` specifically *for*
  address 15 (`main.c:1512-1550`). This only affects the controller's
  internal EEPROM hour counter (not exposed over this protocol), but it's
  worth knowing if address 15 is ever assigned to a bed.

## 8. Integration notes for a PC-side client

- At 1200 baud, a byte takes ~8.3 ms to serialize; budget for ISR + turnaround
  latency on top of that when timing reply reads — a timeout in the tens of
  milliseconds per expected reply byte is a reasonable starting point, well
  under the controller's own 1500 ms sequence timeout.
- Treat the six-byte-out / one-byte-in / one-byte-out time-set exchange as a
  single atomic operation from the host's perspective: if any expected reply
  byte doesn't arrive, or the checksum doesn't match what was computed
  locally, abandon and retry the whole sequence from Set Pre-time — there is
  no partial-resume.
  Compute the expected checksum independently on the host side using the
  same formula (§5) so a mismatched echo from the controller can be detected
  without waiting on a second round-trip.
- Don't address a different controller until the current controller's
  transaction has completed or timed out (§2) — this is a shared bus with no
  per-controller session concept beyond that timeout.
- Controller addresses (0–15) are configured locally per device and are not
  discoverable or settable over this protocol; the mapping from a bed in the
  app to a physical controller address has to be maintained out of band
  (e.g. as part of each bed's configuration).
