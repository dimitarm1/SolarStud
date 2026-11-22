-- User accounts for login/access control (auth.py). No seed rows: an
-- empty table means "no one has registered yet", which auth.py treats as
-- everyone being an admin (today's no-login behavior) - see
-- auth.any_users_exist().

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('admin', 'user')),
    active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL
);
