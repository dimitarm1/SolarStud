"""User accounts, login verification, and the admin_required route guard.

As long as there is no active admin account, the whole app behaves exactly
as it did before this module existed (no login prompt, full access for
everyone) - see any_active_admin_exists(), used by app.py's before_request
hook. This is deliberately keyed on "an admin exists", not "the table is
non-empty": an admin is what can actually fix things (create more
accounts, promote someone), so a studio that somehow ended up with real
user accounts but zero admins (e.g. the very first account was created as
a plain operator before this safeguard existed) self-heals back to the
no-login state on the next restart, rather than staying locked out of its
own account management."""

from datetime import datetime
from functools import wraps

from flask import abort, g
from werkzeug.security import check_password_hash, generate_password_hash

import db

ROLES = ("admin", "user")


class AuthError(Exception):
    """Raised for account-management domain failures (bad role, duplicate
    username, last-admin guard) - mirrors sales.PaymentError."""


def any_active_admin_exists():
    conn = db.get_connection()
    try:
        row = conn.execute("SELECT 1 FROM users WHERE role = 'admin' AND active = 1 LIMIT 1").fetchone()
        return row is not None
    finally:
        conn.close()


def list_users():
    conn = db.get_connection()
    try:
        return conn.execute("SELECT * FROM users ORDER BY username").fetchall()
    finally:
        conn.close()


def get_user(user_id):
    conn = db.get_connection()
    try:
        return conn.execute("SELECT * FROM users WHERE id = ?", (user_id,)).fetchone()
    finally:
        conn.close()


def _active_admin_count(conn, exclude_user_id=None):
    row = conn.execute(
        "SELECT COUNT(*) AS n FROM users WHERE role = 'admin' AND active = 1 AND id != ?",
        (exclude_user_id or -1,),
    ).fetchone()
    return row["n"]


def create_user(username, password, role):
    username = (username or "").strip()
    if not username:
        raise AuthError("Въведете потребителско име.")
    if role not in ROLES:
        raise AuthError("Невалидна роля.")
    if not password:
        raise AuthError("Въведете парола.")
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            existing = conn.execute(
                "SELECT 1 FROM users WHERE username = ?", (username,)
            ).fetchone()
            if existing is not None:
                raise AuthError(f"Потребител с име „{username}“ вече съществува.")
            # As long as no active admin exists yet, /users is reachable
            # with no role check at all (see any_active_admin_exists), so
            # nothing else would stop someone from registering this
            # account as a plain user - which would then be unable to
            # ever reach /users again once the login gate turns on. Force
            # admin here too, so creating an account is itself enough to
            # leave the studio with at least one admin.
            effective_role = "admin" if _active_admin_count(conn) == 0 else role
            conn.execute(
                "INSERT INTO users (username, password_hash, role, active, created_at) "
                "VALUES (?, ?, ?, 1, ?)",
                (
                    username, generate_password_hash(password), effective_role,
                    datetime.now().isoformat(timespec="seconds"),
                ),
            )
    finally:
        conn.close()


def update_user(user_id, username=None, role=None, new_password=None, active=None):
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            user = conn.execute("SELECT * FROM users WHERE id = ?", (user_id,)).fetchone()
            if user is None:
                raise AuthError("Потребителят не съществува.")

            next_role = user["role"] if role is None else role
            if next_role not in ROLES:
                raise AuthError("Невалидна роля.")
            next_active = user["active"] if active is None else (1 if active else 0)

            demoting_or_disabling_admin = (
                user["role"] == "admin" and user["active"]
                and (next_role != "admin" or not next_active)
            )
            if demoting_or_disabling_admin and _active_admin_count(conn, exclude_user_id=user_id) == 0:
                raise AuthError("Не може да премахнете последния администратор.")

            # Bootstrap/self-heal: if there is currently no active admin
            # anywhere (e.g. the very first account ended up as a plain
            # user - see create_user's identical guard), saving any edit
            # to an account guarantees it becomes the admin, the same way
            # creating a fresh account does - so fixing this never depends
            # on someone remembering to tick "Administrator" by hand.
            if _active_admin_count(conn) == 0:
                next_role, next_active = "admin", 1

            next_username = user["username"] if username is None else username.strip()
            if not next_username:
                raise AuthError("Потребителското име не може да е празно.")
            if next_username != user["username"]:
                clash = conn.execute(
                    "SELECT 1 FROM users WHERE username = ? AND id != ?", (next_username, user_id)
                ).fetchone()
                if clash is not None:
                    raise AuthError(f"Потребител с име „{next_username}“ вече съществува.")

            if new_password:
                conn.execute(
                    "UPDATE users SET username = ?, role = ?, active = ?, password_hash = ? WHERE id = ?",
                    (next_username, next_role, next_active, generate_password_hash(new_password), user_id),
                )
            else:
                conn.execute(
                    "UPDATE users SET username = ?, role = ?, active = ? WHERE id = ?",
                    (next_username, next_role, next_active, user_id),
                )
    finally:
        conn.close()


def delete_user(user_id):
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            user = conn.execute("SELECT * FROM users WHERE id = ?", (user_id,)).fetchone()
            if user is None:
                raise AuthError("Потребителят не съществува.")
            if user["role"] == "admin" and user["active"] and _active_admin_count(conn, exclude_user_id=user_id) == 0:
                raise AuthError("Не може да изтриете последния администратор.")
            conn.execute("DELETE FROM users WHERE id = ?", (user_id,))
    finally:
        conn.close()


def verify_login(username, password):
    """Returns the matching active user row, or None for a bad username,
    bad password, or inactive account - deliberately no distinction
    between those, to avoid leaking which usernames exist."""
    username = (username or "").strip()
    conn = db.get_connection()
    try:
        user = conn.execute(
            "SELECT * FROM users WHERE username = ? AND active = 1", (username,)
        ).fetchone()
    finally:
        conn.close()
    if user is None or not check_password_hash(user["password_hash"], password or ""):
        return None
    return user


def admin_required(view):
    """Route decorator: blocks non-admins. g.current_user is None in the
    no-active-admin bypass state, which counts as admin (see any_active_admin_exists)."""
    @wraps(view)
    def wrapped(*args, **kwargs):
        user = getattr(g, "current_user", None)
        if user is not None and user["role"] != "admin":
            abort(403)
        return view(*args, **kwargs)
    return wrapped
