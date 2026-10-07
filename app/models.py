"""Domain queries for beds, studio settings, and tanning sessions."""

import time
from datetime import datetime, timedelta

import controller_link
import db

# Addresses 0-14 are real physical bus addresses (see controller_link /
# protocol.md; 15 is reserved - the firmware logs it differently
# internally). 16-21 are app-only "demo" addresses: never sent over the
# wire, just a marker meaning "simulate this bed, no real hardware". Six is
# plenty - nobody needs more than a handful of demo beds in practice.
MIN_CONTROLLER_ADDRESS = controller_link.MIN_ADDRESS
MAX_REAL_CONTROLLER_ADDRESS = controller_link.MAX_ADDRESS
MIN_DEMO_CONTROLLER_ADDRESS = 16
MAX_CONTROLLER_ADDRESS = 21

MIN_SESSION_MINUTES = 1
MAX_SESSION_MINUTES = 35
DEFAULT_SESSION_MINUTES = 12

MIN_PREP_MINUTES = 0
MAX_PREP_MINUTES = 9

MIN_COOL_MINUTES = 0
MAX_COOL_MINUTES = 5

MIN_BEDS = 2
MAX_BEDS = 8
DEFAULT_BEDS = 4

STAGE_ORDER = ("prep", "active", "cooling")


# --- internal helpers --------------------------------------------------

def _stage_and_remaining(session_row):
    """Return (stage, remaining_min) for a running session, or (None, 0)
    once prep + active + cooling have all elapsed."""
    started_at = datetime.fromisoformat(session_row["started_at"])
    elapsed_min = (datetime.now() - started_at).total_seconds() / 60

    for stage, duration in (
        ("prep", session_row["prep_min"]),
        ("active", session_row["total_min"]),
        ("cooling", session_row["cool_min"]),
    ):
        if elapsed_min < duration:
            return stage, max(0, round(duration - elapsed_min))
        elapsed_min -= duration

    return None, 0


def _reap_finished_sessions(conn, bed_id=None):
    """Mark running sessions whose stages have fully elapsed as completed."""
    query = "SELECT * FROM sessions WHERE status = 'running'"
    params = ()
    if bed_id is not None:
        query += " AND bed_id = ?"
        params = (bed_id,)
    rows = conn.execute(query, params).fetchall()
    finished_ids = [row["id"] for row in rows if _stage_and_remaining(row)[0] is None]
    if finished_ids:
        with db.transaction(conn):
            now = datetime.now().isoformat(timespec="seconds")
            conn.executemany(
                "UPDATE sessions SET status = 'completed', ended_at = ? WHERE id = ?",
                [(now, fid) for fid in finished_ids],
            )


def _current_session(conn, bed_id):
    return conn.execute(
        "SELECT * FROM sessions WHERE bed_id = ? AND status = 'running' "
        "ORDER BY started_at DESC LIMIT 1",
        (bed_id,),
    ).fetchone()


# The controllers have their own physical buttons - a session can be set,
# started, or stopped directly on the unit with no PC involved at all. For a
# real (non-demo) bed, the DB's own session timer can silently go stale the
# moment someone does that, so before trusting it for display we check it
# against what the hardware actually reports right now and correct it if
# they've drifted apart.
_LIVE_STAGE_MAP = {"free": None, "waiting": "prep", "working": "active", "cooling": "cooling"}
RECONCILE_DRIFT_TOLERANCE_MIN = 2
# Backstop for a just-created/just-changed session: controller_link's
# COMMIT_SETTLE_SECONDS already waits for a Set-Time commit to actually land
# before set_time() returns, which is the real fix for a disagreeing read
# arriving before the commit has taken effect - this is a generous extra
# margin against any other transient misread (e.g. a dropped RF packet)
# nuking a session moments after it legitimately started.
RECONCILE_GRACE_PERIOD_SECONDS = 2.0


def _started_at_for(stage, remaining_min, prep_min, total_min, cool_min, now):
    """Inverse of _stage_and_remaining: the started_at that would make a
    session's elapsed-time computation land exactly on (stage, remaining)."""
    if stage == "prep":
        elapsed = max(0, prep_min - remaining_min)
    elif stage == "active":
        elapsed = prep_min + max(0, total_min - remaining_min)
    else:  # cooling
        elapsed = prep_min + total_min + max(0, cool_min - remaining_min)
    return now - timedelta(minutes=elapsed)


def _reconcile_with_hardware(conn, bed_row, live):
    """Bring a real bed's DB session state back in sync with what the
    controller just reported, if they've drifted apart. A no-op when the
    hardware couldn't be reached this round (`live` is None) - we just fall
    back to whatever the DB last knew rather than erroring the whole page."""
    if live is None:
        return
    live_stage = _LIVE_STAGE_MAP.get(live["status"])
    session = _current_session(conn, bed_row["id"])
    db_stage, db_remaining = (None, 0)
    if session is not None:
        db_stage, db_remaining = _stage_and_remaining(session)
        session_age = (datetime.now() - datetime.fromisoformat(session["started_at"])).total_seconds()
        if session_age < RECONCILE_GRACE_PERIOD_SECONDS:
            return

    if db_stage == live_stage and abs(db_remaining - live["remaining_min"]) <= RECONCILE_DRIFT_TOLERANCE_MIN:
        return  # close enough - don't rewrite on every poll over tiny clock drift

    with db.transaction(conn):
        now = datetime.now()
        if session is not None:
            conn.execute(
                "UPDATE sessions SET status = 'stopped', ended_at = ? WHERE id = ?",
                (now.isoformat(timespec="seconds"), session["id"]),
            )
        if live_stage is not None:
            remaining = live["remaining_min"]
            # The controller may have been started locally using its own
            # stored prep/cool presets, which can differ from this bed's
            # configured values here - clamp so the reported remaining time
            # always fits inside the phase we're about to record, or the
            # elapsed-time math below would place it past the end of that
            # phase entirely.
            prep_min = max(bed_row["prep_min"], remaining) if live_stage == "prep" else bed_row["prep_min"]
            cool_min = max(bed_row["cool_min"], remaining) if live_stage == "cooling" else bed_row["cool_min"]
            # The active-phase duration is only ever learned by observing it
            # directly - while still in prep we don't know it yet, so assume
            # the app's own default until a later poll catches it in "active"
            # and can read the real figure off the remaining-time itself.
            total_min = remaining if live_stage == "active" else DEFAULT_SESSION_MINUTES
            started_at = _started_at_for(live_stage, remaining, prep_min, total_min, cool_min, now)
            conn.execute(
                "INSERT INTO sessions (bed_id, started_at, total_min, prep_min, cool_min, status) "
                "VALUES (?, ?, ?, ?, ?, 'running')",
                (bed_row["id"], started_at.isoformat(timespec="seconds"), total_min, prep_min, cool_min),
            )


# The client can poll for status as often as it likes (see index.html's
# fast in-place refresh) without that translating into hammering the shared
# half-duplex serial bus: actual hardware queries are rate-limited here,
# independent of request frequency, so a burst of requests (multiple tabs,
# a bed-detail view open alongside the main screen, ...) just reuses
# whatever the most recent real check found.
#
# The gap is adaptive rather than a flat guess: it's derived from how long
# the last real poll actually took (query_many shares one connection across
# every real bed, so that's ~200ms settle once per batch, not per bed, plus
# ~200ms round trip per bed - measured against real hardware, see
# controller_link.py). A one- or two-bed studio ends up polling roughly
# twice a second; a fuller one backs off automatically rather than letting
# polls pile up on the shared bus.
_last_hw_poll_monotonic = 0.0
_last_hw_poll_duration = 0.0
HW_POLL_MIN_GAP_SECONDS = 0.5  # floor, so even one fast-responding bed doesn't get hit back-to-back
HW_POLL_SAFETY_FACTOR = 1.5  # headroom above the last measured poll duration


def _reconcile_real_beds(conn, bed_rows):
    """Query live status for every real bed in one shared connection and
    reconcile each against the DB. Best-effort: if the port is unconfigured
    or unreachable, or hardware was already checked too recently, every
    real bed just falls back to its last-known DB state for this round."""
    global _last_hw_poll_monotonic, _last_hw_poll_duration
    real_beds = [b for b in bed_rows if not is_demo_address(b["controller_address"])]
    if not real_beds:
        return
    now = time.monotonic()
    required_gap = max(HW_POLL_MIN_GAP_SECONDS, _last_hw_poll_duration * HW_POLL_SAFETY_FACTOR)
    if now - _last_hw_poll_monotonic < required_gap:
        return
    port = get_serial_port()
    if not port:
        return
    _last_hw_poll_monotonic = now
    try:
        live_results = controller_link.query_many(
            port, [b["controller_address"] for b in real_beds]
        )
    except controller_link.ControllerLinkError:
        return
    finally:
        _last_hw_poll_duration = time.monotonic() - now
    for bed in real_beds:
        _reconcile_with_hardware(conn, bed, live_results.get(bed["controller_address"]))


def _picture_src(bed_id, picture_path):
    path = (picture_path or "").strip()
    if not path:
        return ""
    if path.startswith(("http://", "https://", "/static/")):
        return path
    # A local filesystem path: browsers block file:// subresource loads from
    # an http(s) page, so route it through our own server instead, which can
    # read the file directly (see the /bed/<id>/photo view in app.py).
    return f"/bed/{bed_id}/photo"


def _serialize(bed_row, session_row):
    bed = dict(bed_row)
    bed["picture_src"] = _picture_src(bed_row["id"], bed_row["picture_path"])
    bed["is_demo"] = is_demo_address(bed_row["controller_address"])
    if session_row is not None:
        stage, remaining_min = _stage_and_remaining(session_row)
        bed["status"] = "running"
        bed["stage"] = stage
        bed["remaining_min"] = remaining_min
        bed["prep_min_session"] = session_row["prep_min"]
        bed["active_min_session"] = session_row["total_min"]
        bed["cool_min_session"] = session_row["cool_min"]
    else:
        bed["status"] = "idle"
    return bed


# --- beds ----------------------------------------------------------------

def list_beds():
    conn = db.get_connection()
    try:
        _reap_finished_sessions(conn)
        beds = conn.execute("SELECT * FROM beds ORDER BY sort_order").fetchall()
        _reconcile_real_beds(conn, beds)
        return [_serialize(bed, _current_session(conn, bed["id"])) for bed in beds]
    finally:
        conn.close()


def get_bed(bed_id):
    conn = db.get_connection()
    try:
        _reap_finished_sessions(conn, bed_id)
        bed = conn.execute("SELECT * FROM beds WHERE id = ?", (bed_id,)).fetchone()
        if bed is None:
            return None
        _reconcile_real_beds(conn, [bed])
        return _serialize(bed, _current_session(conn, bed_id))
    finally:
        conn.close()


def _strip_wrapping_quotes(text):
    if len(text) >= 2 and text[0] == text[-1] and text[0] in ("'", '"'):
        return text[1:-1].strip()
    return text


def _clamp_controller_address(value):
    value = int(value)
    if value < MIN_CONTROLLER_ADDRESS:
        return MIN_CONTROLLER_ADDRESS
    if value > MAX_CONTROLLER_ADDRESS:
        return MAX_CONTROLLER_ADDRESS
    if MAX_REAL_CONTROLLER_ADDRESS < value < MIN_DEMO_CONTROLLER_ADDRESS:
        # Address 15 is reserved and not a valid choice either side of the
        # gap - fall back to the nearest real address rather than erroring.
        return MAX_REAL_CONTROLLER_ADDRESS
    return value


def is_demo_address(controller_address):
    """True if this address means 'simulate, no real hardware' - i.e. it's
    unset, or in the 16-32 demo range. False only for a real 0-14 address."""
    return controller_address is None or controller_address >= MIN_DEMO_CONTROLLER_ADDRESS


def update_bed_settings(bed_id, number, model, prep_min, cool_min, picture_path,
                         controller_address=""):
    prep_min = max(MIN_PREP_MINUTES, min(MAX_PREP_MINUTES, int(prep_min)))
    cool_min = max(MIN_COOL_MINUTES, min(MAX_COOL_MINUTES, int(cool_min)))
    # Pasting a path from a terminal or file manager often brings along
    # wrapping quotes (e.g. '/path/with spaces/file.jpg') - strip those
    # rather than storing a path that will never match a real file.
    picture_path = _strip_wrapping_quotes((picture_path or "").strip())
    number = (number or "").strip()
    model = (model or "").strip()

    controller_address = str(controller_address).strip()
    controller_address = None if controller_address == "" else _clamp_controller_address(controller_address)

    conn = db.get_connection()
    try:
        with db.transaction(conn):
            bed = conn.execute("SELECT number, model FROM beds WHERE id = ?", (bed_id,)).fetchone()
            if bed is None:
                raise ValueError(f"Unknown bed id {bed_id}")
            conn.execute(
                "UPDATE beds SET number = ?, model = ?, prep_min = ?, cool_min = ?, "
                "picture_path = ?, controller_address = ? WHERE id = ?",
                (
                    number or bed["number"],
                    model or bed["model"],
                    prep_min,
                    cool_min,
                    picture_path,
                    controller_address,
                    bed_id,
                ),
            )
    finally:
        conn.close()


def list_controller_addresses_in_use(exclude_bed_id=None):
    """Return {address: bed_id} for every bed that already has a controller
    address assigned, optionally leaving one bed's own assignment out."""
    conn = db.get_connection()
    try:
        query = "SELECT id, controller_address FROM beds WHERE controller_address IS NOT NULL"
        params = ()
        if exclude_bed_id is not None:
            query += " AND id != ?"
            params = (exclude_bed_id,)
        rows = conn.execute(query, params).fetchall()
        return {row["controller_address"]: row["id"] for row in rows}
    finally:
        conn.close()


# --- studio settings ---------------------------------------------------

def get_bed_count():
    conn = db.get_connection()
    try:
        row = conn.execute("SELECT bed_count FROM settings WHERE id = 1").fetchone()
        return row["bed_count"] if row is not None else DEFAULT_BEDS
    finally:
        conn.close()


def set_bed_count(new_count):
    new_count = max(MIN_BEDS, min(MAX_BEDS, int(new_count)))
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            conn.execute("UPDATE settings SET bed_count = ? WHERE id = 1", (new_count,))
            existing_ids = {row["id"] for row in conn.execute("SELECT id FROM beds")}

            for bed_id in existing_ids:
                if bed_id > new_count:
                    conn.execute("DELETE FROM beds WHERE id = ?", (bed_id,))

            for bed_id in range(1, new_count + 1):
                if bed_id not in existing_ids:
                    conn.execute(
                        "INSERT INTO beds (id, number, model, kind, sort_order, "
                        "prep_min, cool_min, picture_path) "
                        "VALUES (?, ?, ?, 'lie', ?, 0, 0, '')",
                        (bed_id, f"No {bed_id}", "Unconfigured", bed_id),
                    )
    finally:
        conn.close()
    return new_count


def get_serial_port():
    conn = db.get_connection()
    try:
        row = conn.execute("SELECT serial_port FROM settings WHERE id = 1").fetchone()
        return row["serial_port"] if row is not None else ""
    finally:
        conn.close()


def set_serial_port(port):
    port = (port or "").strip()
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            conn.execute("UPDATE settings SET serial_port = ? WHERE id = 1", (port,))
    finally:
        conn.close()
    return port


# --- sessions ------------------------------------------------------------

def _require_serial_port():
    port = get_serial_port()
    if not port:
        raise controller_link.ControllerLinkError(
            "No serial port configured - set one on the Studio page."
        )
    return port


def start_session(bed_id, total_min=DEFAULT_SESSION_MINUTES):
    """Start a session. For a bed on a real controller address (0-14) this
    only commits once the controller has confirmed the Set-Time handshake
    (protocol.md §5) - if that fails, nothing is written and the exception
    propagates so the caller can surface it, rather than showing a session
    as running when the physical bed never got the command."""
    total_min = max(MIN_SESSION_MINUTES, min(MAX_SESSION_MINUTES, int(total_min)))
    conn = db.get_connection()
    try:
        _reap_finished_sessions(conn, bed_id)
        with db.transaction(conn):
            bed = conn.execute(
                "SELECT id, prep_min, cool_min, controller_address FROM beds WHERE id = ?",
                (bed_id,),
            ).fetchone()
            if bed is None:
                raise ValueError(f"Unknown bed id {bed_id}")
            if _current_session(conn, bed_id) is not None:
                return  # a session is already running, nothing to do

            if not is_demo_address(bed["controller_address"]):
                port = _require_serial_port()
                controller_link.set_time(
                    port, bed["controller_address"], bed["prep_min"], total_min, bed["cool_min"]
                )

            conn.execute(
                "INSERT INTO sessions (bed_id, started_at, total_min, prep_min, cool_min, status) "
                "VALUES (?, ?, ?, ?, ?, 'running')",
                (
                    bed_id,
                    datetime.now().isoformat(timespec="seconds"),
                    total_min,
                    bed["prep_min"],
                    bed["cool_min"],
                ),
            )
    finally:
        conn.close()


def stop_session(bed_id):
    """Stop a session. Symmetric with start_session: for a real controller,
    the DB is only updated once the all-zero Set-Time handshake is
    confirmed, so the UI never claims "stopped" while the physical bed
    might still be running."""
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            bed = conn.execute(
                "SELECT controller_address FROM beds WHERE id = ?", (bed_id,)
            ).fetchone()
            if bed is None:
                raise ValueError(f"Unknown bed id {bed_id}")

            if not is_demo_address(bed["controller_address"]):
                port = _require_serial_port()
                controller_link.set_time(port, bed["controller_address"], 0, 0, 0)

            conn.execute(
                "UPDATE sessions SET status = 'stopped', ended_at = ? "
                "WHERE bed_id = ? AND status = 'running'",
                (datetime.now().isoformat(timespec="seconds"), bed_id),
            )
    finally:
        conn.close()


def skip_prep(bed_id):
    """Skip the remaining preparation time and move straight into the active
    phase - this is what the controller's own physical Start button does
    locally while pre_time is still counting down (ProcessButtons() in the
    firmware just zeroes pre_time and re-evaluates status).

    For a real controller, that same effect is reproduced remotely by
    re-running the Set-Time handshake with pre=0 and the original
    main/cool values (the dedicated wire "Start" command only works in a
    firmware test-only edge case - see protocol.md §4.2 - so it can't be
    used for this in general). For a demo bed it's a pure DB update: the
    session's started_at is shifted back by its prep_min, which makes the
    elapsed-time stage calculation land exactly at the start of the active
    phase with the full main_min remaining.

    A no-op if the bed isn't currently in its preparation phase.
    """
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            bed = conn.execute(
                "SELECT controller_address FROM beds WHERE id = ?", (bed_id,)
            ).fetchone()
            if bed is None:
                raise ValueError(f"Unknown bed id {bed_id}")

            session = _current_session(conn, bed_id)
            if session is None:
                return
            stage, _ = _stage_and_remaining(session)
            if stage != "prep":
                return

            if not is_demo_address(bed["controller_address"]):
                port = _require_serial_port()
                controller_link.set_time(
                    port,
                    bed["controller_address"],
                    0,
                    session["total_min"],
                    session["cool_min"],
                )

            # Rewind started_at so elapsed time already equals prep_min
            # exactly - i.e. "preparation just finished", landing at the
            # very start of the active phase with the full main_min left.
            new_started_at = datetime.now() - timedelta(minutes=session["prep_min"])
            conn.execute(
                "UPDATE sessions SET started_at = ? WHERE id = ?",
                (new_started_at.isoformat(timespec="seconds"), session["id"]),
            )
    finally:
        conn.close()
