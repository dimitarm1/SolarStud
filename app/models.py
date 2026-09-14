"""Domain queries for beds and tanning sessions."""

from datetime import datetime

import db

MIN_SESSION_MINUTES = 1
MAX_SESSION_MINUTES = 35
DEFAULT_SESSION_MINUTES = 12


def _current_session(conn, bed_id):
    return conn.execute(
        "SELECT * FROM sessions WHERE bed_id = ? AND status = 'running' "
        "ORDER BY started_at DESC LIMIT 1",
        (bed_id,),
    ).fetchone()


def _serialize(bed_row, session_row):
    bed = dict(bed_row)
    if session_row is not None:
        started_at = datetime.fromisoformat(session_row["started_at"])
        elapsed_min = (datetime.now() - started_at).total_seconds() / 60
        remaining = max(0, session_row["total_min"] - elapsed_min)
        bed["status"] = "running"
        bed["total_min"] = session_row["total_min"]
        bed["remaining_min"] = int(round(remaining))
    else:
        bed["status"] = "idle"
    return bed


def list_beds():
    conn = db.get_connection()
    try:
        beds = conn.execute("SELECT * FROM beds ORDER BY sort_order").fetchall()
        return [_serialize(bed, _current_session(conn, bed["id"])) for bed in beds]
    finally:
        conn.close()


def get_bed(bed_id):
    conn = db.get_connection()
    try:
        bed = conn.execute("SELECT * FROM beds WHERE id = ?", (bed_id,)).fetchone()
        if bed is None:
            return None
        return _serialize(bed, _current_session(conn, bed_id))
    finally:
        conn.close()


def start_session(bed_id, total_min=DEFAULT_SESSION_MINUTES):
    total_min = max(MIN_SESSION_MINUTES, min(MAX_SESSION_MINUTES, int(total_min)))
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            bed = conn.execute("SELECT id FROM beds WHERE id = ?", (bed_id,)).fetchone()
            if bed is None:
                raise ValueError(f"Unknown bed id {bed_id}")
            if _current_session(conn, bed_id) is not None:
                return  # a session is already running, nothing to do
            conn.execute(
                "INSERT INTO sessions (bed_id, started_at, total_min, status) "
                "VALUES (?, ?, ?, 'running')",
                (bed_id, datetime.now().isoformat(timespec="seconds"), total_min),
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
