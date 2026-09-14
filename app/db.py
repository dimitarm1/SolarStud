"""SQLite access layer: connections, migrations, backups, and integrity checks."""

import shutil
import sqlite3
from contextlib import contextmanager
from datetime import datetime
from pathlib import Path

APP_DIR = Path(__file__).resolve().parent
DATA_DIR = APP_DIR.parent / "data"
BACKUP_DIR = DATA_DIR / "backups"
MIGRATIONS_DIR = APP_DIR / "migrations"
DB_PATH = DATA_DIR / "solar_studio.db"

DB_NAME = "solar_studio"
MAX_BACKUPS = 5


def _ensure_dirs():
    DATA_DIR.mkdir(parents=True, exist_ok=True)
    BACKUP_DIR.mkdir(parents=True, exist_ok=True)


def get_connection():
    """Open a new connection with the pragmas this app relies on.

    PRAGMA foreign_keys and journal_mode are connection-scoped in SQLite
    (journal_mode persists in the file after the first WAL switch, but
    foreign_keys must be re-enabled on every connection), so both are set
    here rather than once at setup time.
    """
    _ensure_dirs()
    conn = sqlite3.connect(DB_PATH, isolation_level=None)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA journal_mode = WAL")
    conn.execute("PRAGMA foreign_keys = ON")
    conn.execute("PRAGMA synchronous = NORMAL")
    return conn


@contextmanager
def transaction(conn):
    """Wrap one logical unit of work in a BEGIN IMMEDIATE / COMMIT or ROLLBACK."""
    conn.execute("BEGIN IMMEDIATE")
    try:
        yield conn
        conn.execute("COMMIT")
    except Exception:
        conn.execute("ROLLBACK")
        raise


# --- Migrations -----------------------------------------------------------

def _migration_files():
    return sorted(MIGRATIONS_DIR.glob("*.sql"))


def _split_statements(sql):
    return [stmt.strip() for stmt in sql.split(";") if stmt.strip()]


def run_migrations():
    """Apply any migration files not yet recorded, each as its own transaction."""
    conn = get_connection()
    try:
        conn.execute(
            """
            CREATE TABLE IF NOT EXISTS schema_migrations (
                version TEXT PRIMARY KEY,
                applied_at TEXT NOT NULL
            )
            """
        )
        applied = {
            row["version"]
            for row in conn.execute("SELECT version FROM schema_migrations")
        }
        for path in _migration_files():
            version = path.stem
            if version in applied:
                continue
            with transaction(conn):
                for statement in _split_statements(path.read_text()):
                    conn.execute(statement)
                conn.execute(
                    "INSERT INTO schema_migrations (version, applied_at) VALUES (?, ?)",
                    (version, datetime.now().isoformat(timespec="seconds")),
                )
    finally:
        conn.close()


# --- Backups ----------------------------------------------------------------

def create_backup():
    """Snapshot the live database (safe under WAL) and prune old backups."""
    _ensure_dirs()
    if not DB_PATH.exists():
        return None

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S_%f")
    backup_path = BACKUP_DIR / f"{DB_NAME}_{timestamp}.db"

    src = get_connection()
    try:
        dst = sqlite3.connect(backup_path)
        try:
            src.backup(dst)
        finally:
            dst.close()
    finally:
        src.close()

    _prune_backups()
    return backup_path


def _list_backups():
    return sorted(BACKUP_DIR.glob(f"{DB_NAME}_*.db"))


def _prune_backups(keep=MAX_BACKUPS):
    backups = _list_backups()
    excess = len(backups) - keep
    for path in backups[:max(excess, 0)]:
        path.unlink(missing_ok=True)


# --- Integrity checks & recovery --------------------------------------------

def integrity_check():
    """Return True if the database file is readable and passes PRAGMA integrity_check."""
    try:
        conn = sqlite3.connect(DB_PATH)
    except sqlite3.Error:
        return False
    try:
        rows = conn.execute("PRAGMA integrity_check").fetchall()
        return len(rows) == 1 and rows[0][0] == "ok"
    except sqlite3.DatabaseError:
        return False
    finally:
        conn.close()


def _remove_wal_sidecars():
    for suffix in ("-wal", "-shm"):
        sidecar = Path(f"{DB_PATH}{suffix}")
        if sidecar.exists():
            sidecar.unlink()


def restore_from_backup(backup_path):
    _remove_wal_sidecars()
    shutil.copy2(backup_path, DB_PATH)


def recover_from_corruption():
    """Try each backup, newest first, until one passes integrity_check.

    Returns the backup Path that was restored, or None if the database had
    to be quarantined and will be recreated fresh by the migrations.
    """
    for backup_path in reversed(_list_backups()):
        restore_from_backup(backup_path)
        if integrity_check():
            return backup_path

    # No usable backup exists: move the corrupted file aside instead of
    # deleting it, and let run_migrations() build a brand-new database.
    if DB_PATH.exists():
        quarantine = DB_PATH.with_name(
            f"{DB_PATH.stem}.corrupt_{datetime.now().strftime('%Y%m%d_%H%M%S')}{DB_PATH.suffix}"
        )
        DB_PATH.rename(quarantine)
    _remove_wal_sidecars()
    return None


# --- Startup ------------------------------------------------------------

def init_db():
    """Run once at application startup: verify integrity, recover if needed,
    apply pending migrations, then take a fresh backup."""
    _ensure_dirs()

    if DB_PATH.exists() and not integrity_check():
        recover_from_corruption()

    run_migrations()
    create_backup()
