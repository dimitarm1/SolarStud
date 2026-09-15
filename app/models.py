"""Domain queries for beds, studio settings, and tanning sessions."""

from datetime import datetime

import db

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
        return _serialize(bed, _current_session(conn, bed_id))
    finally:
        conn.close()


def _strip_wrapping_quotes(text):
    if len(text) >= 2 and text[0] == text[-1] and text[0] in ("'", '"'):
        return text[1:-1].strip()
    return text


def update_bed_settings(bed_id, number, model, prep_min, cool_min, picture_path):
    prep_min = max(MIN_PREP_MINUTES, min(MAX_PREP_MINUTES, int(prep_min)))
    cool_min = max(MIN_COOL_MINUTES, min(MAX_COOL_MINUTES, int(cool_min)))
    # Pasting a path from a terminal or file manager often brings along
    # wrapping quotes (e.g. '/path/with spaces/file.jpg') - strip those
    # rather than storing a path that will never match a real file.
    picture_path = _strip_wrapping_quotes((picture_path or "").strip())
    number = (number or "").strip()
    model = (model or "").strip()

    conn = db.get_connection()
    try:
        with db.transaction(conn):
            bed = conn.execute("SELECT number, model FROM beds WHERE id = ?", (bed_id,)).fetchone()
            if bed is None:
                raise ValueError(f"Unknown bed id {bed_id}")
            conn.execute(
                "UPDATE beds SET number = ?, model = ?, prep_min = ?, cool_min = ?, "
                "picture_path = ? WHERE id = ?",
                (
                    number or bed["number"],
                    model or bed["model"],
                    prep_min,
                    cool_min,
                    picture_path,
                    bed_id,
                ),
            )
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


# --- sessions ------------------------------------------------------------

def start_session(bed_id, total_min=DEFAULT_SESSION_MINUTES):
    total_min = max(MIN_SESSION_MINUTES, min(MAX_SESSION_MINUTES, int(total_min)))
    conn = db.get_connection()
    try:
        _reap_finished_sessions(conn, bed_id)
        with db.transaction(conn):
            bed = conn.execute(
                "SELECT id, prep_min, cool_min FROM beds WHERE id = ?", (bed_id,)
            ).fetchone()
            if bed is None:
                raise ValueError(f"Unknown bed id {bed_id}")
            if _current_session(conn, bed_id) is not None:
                return  # a session is already running, nothing to do
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
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            conn.execute(
                "UPDATE sessions SET status = 'stopped', ended_at = ? "
                "WHERE bed_id = ? AND status = 'running'",
                (datetime.now().isoformat(timespec="seconds"), bed_id),
            )
    finally:
        conn.close()
