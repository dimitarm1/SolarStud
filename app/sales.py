"""Domain queries for bed/recharge pricing, loyalty cards, cosmetics stock,
and the daily sales log."""

from datetime import datetime

import chipcard
import db


class PaymentError(Exception):
    """Raised for sales/POS domain failures (invalid or depleted card,
    insufficient stock, ...) - mirrors controller_link.ControllerLinkError."""


# --- internal helpers ----------------------------------------------------

def _bed_rate_for_option(conn, recharge_option_id, bed_id, fallback):
    if recharge_option_id is None:
        return fallback
    row = conn.execute(
        "SELECT price_per_min FROM recharge_option_bed_prices "
        "WHERE recharge_option_id = ? AND bed_id = ?",
        (recharge_option_id, bed_id),
    ).fetchone()
    return row["price_per_min"] if row is not None else fallback


def _card_lots_fifo(conn, card_id):
    return conn.execute(
        "SELECT * FROM card_lots WHERE card_id = ? AND remaining_amount > 0 ORDER BY id",
        (card_id,),
    ).fetchall()


def _card_balance(conn, card_id):
    row = conn.execute(
        "SELECT COALESCE(SUM(remaining_amount), 0) AS balance FROM card_lots WHERE card_id = ?",
        (card_id,),
    ).fetchone()
    return row["balance"]


def _require_active_card(conn, card_id):
    card = conn.execute("SELECT * FROM cards WHERE id = ?", (card_id,)).fetchone()
    if card is None:
        raise PaymentError("Картата не съществува.")
    if card["status"] != "active":
        raise PaymentError("Картата е върната и не може да се използва за плащане.")
    return card


def record_sale(conn, kind, description, cash_amount=0, card_amount=0, virtual_amount=None,
                  qty=None, bed_id=None, card_id=None, product_id=None, session_id=None,
                  recharge_option_id=None):
    conn.execute(
        "INSERT INTO sales_log (created_at, kind, description, cash_amount, card_amount, "
        "virtual_amount, qty, bed_id, card_id, product_id, session_id, recharge_option_id) "
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        (
            datetime.now().isoformat(timespec="seconds"), kind, description,
            round(cash_amount, 2), round(card_amount, 2), virtual_amount, qty,
            bed_id, card_id, product_id, session_id, recharge_option_id,
        ),
    )


# --- session payment: money -> minutes FIFO allocation --------------------

def _allocate_card_payment(lots, total_min, requested_amount, flat_price_per_min, option_rates):
    """lots: oldest-first rows with "id", "remaining_amount", "recharge_option_id".
    option_rates: {recharge_option_id: price_per_min} already resolved for the
    bed this session is on.

    Walks lots oldest-first, converting as much of `requested_amount` as each
    lot can supply into minutes of this session covered, at that lot's own
    rate (falling back to flat_price_per_min when the lot's option has no
    override for this bed) - capped so the total never buys more than
    total_min. Pure/no DB access, so it's trivially testable in isolation;
    both the real deduction and the read-only quote call it.

    Returns (allocations=[(lot_id, amount_to_subtract), ...], card_amount,
    cash_amount) where cash_amount covers whatever minutes weren't bought.
    """
    allocations = []
    card_amount = 0.0
    minutes_left = total_min
    budget_left = max(0.0, requested_amount)

    for lot in lots:
        if budget_left <= 0 or minutes_left <= 0:
            break
        rate = option_rates.get(lot["recharge_option_id"], flat_price_per_min)
        if rate <= 0:
            # A free bed/option combination - the lot covers the rest of the
            # session for no money rather than dividing by zero.
            take = 0.0
            minutes_from_lot = minutes_left
        else:
            max_money_for_remaining = minutes_left * rate
            take = round(min(lot["remaining_amount"], budget_left, max_money_for_remaining), 2)
            minutes_from_lot = take / rate

        if take > 0:
            allocations.append((lot["id"], take))
        card_amount += take
        budget_left -= take
        minutes_left -= minutes_from_lot

    cash_amount = round(max(0.0, minutes_left) * flat_price_per_min, 2)
    return allocations, round(card_amount, 2), cash_amount


def _resolve_session_payment(conn, bed_id, total_min, card_id, requested_card_amount):
    bed = conn.execute("SELECT price_per_min FROM beds WHERE id = ?", (bed_id,)).fetchone()
    if bed is None:
        raise ValueError(f"Unknown bed id {bed_id}")
    flat_price = bed["price_per_min"]

    requested_card_amount = max(0.0, float(requested_card_amount or 0))
    if not card_id or requested_card_amount <= 0:
        return [], 0.0, round(total_min * flat_price, 2)

    _require_active_card(conn, card_id)
    lots = _card_lots_fifo(conn, card_id)
    option_ids = {lot["recharge_option_id"] for lot in lots if lot["recharge_option_id"] is not None}
    option_rates = {oid: _bed_rate_for_option(conn, oid, bed_id, flat_price) for oid in option_ids}
    return _allocate_card_payment(lots, total_min, requested_card_amount, flat_price, option_rates)


def quote_session_payment(bed_id, total_min, card_id=None, requested_card_amount=0):
    """Read-only preview of what a session would cost - used for a live
    cash-due readout as staff adjusts the duration/card-amount fields, and
    to show what a selected card would have left (in money, and converted
    to minutes at this bed) once this session's card portion is deducted.
    With requested_card_amount at its default of 0, "after" is simply the
    card's current state, which is what a freshly-selected card should show
    before staff have touched the amount slider at all."""
    conn = db.get_connection()
    try:
        allocations, card_amount, cash_amount = _resolve_session_payment(
            conn, bed_id, total_min, card_id, requested_card_amount
        )
        result = {"card_amount": card_amount, "cash_amount": cash_amount}
        if card_id:
            bed = conn.execute("SELECT price_per_min FROM beds WHERE id = ?", (bed_id,)).fetchone()
            flat_price = bed["price_per_min"] if bed is not None else 0
            alloc_map = dict(allocations)
            remaining_balance = 0.0
            remaining_minutes = 0.0
            for lot in _card_lots_fifo(conn, card_id):
                remaining = lot["remaining_amount"] - alloc_map.get(lot["id"], 0.0)
                remaining_balance += remaining
                # A lot with no rate for this bed (flat price unconfigured,
                # falls back to 0) can't be expressed in minutes - simplest
                # to just omit its contribution than claim "infinite".
                rate = _bed_rate_for_option(conn, lot["recharge_option_id"], bed_id, flat_price)
                if rate > 0:
                    remaining_minutes += remaining / rate
            result["card_balance_after"] = round(remaining_balance, 2)
            result["card_minutes_after"] = round(remaining_minutes, 1)
        return result
    finally:
        conn.close()


def consume_card_lots_for_minutes(conn, bed_id, total_min, card_id, requested_card_amount):
    """Resolve AND apply a session's payment. Must be called from inside a
    transaction the caller already opened (see models.start_session_with_payment)
    so the lot deduction and the session INSERT commit or roll back together.
    Returns (card_amount, cash_amount) actually charged."""
    allocations, card_amount, cash_amount = _resolve_session_payment(
        conn, bed_id, total_min, card_id, requested_card_amount
    )
    for lot_id, amount in allocations:
        conn.execute(
            "UPDATE card_lots SET remaining_amount = remaining_amount - ? WHERE id = ?",
            (amount, lot_id),
        )
    return card_amount, cash_amount


def _deduct_card_money_fifo(conn, card_id, amount):
    """Plain 1:1 money deduction across a card's lots, FIFO - used for
    cosmetics sales, which have no bed and therefore no per-bed rate to
    convert through (unlike session payments above)."""
    _require_active_card(conn, card_id)
    budget = max(0.0, float(amount))
    deducted = 0.0
    for lot in _card_lots_fifo(conn, card_id):
        if budget <= 0:
            break
        take = round(min(lot["remaining_amount"], budget), 2)
        if take <= 0:
            continue
        conn.execute(
            "UPDATE card_lots SET remaining_amount = remaining_amount - ? WHERE id = ?",
            (take, lot["id"]),
        )
        budget -= take
        deducted += take
    return round(deducted, 2)


# --- recharge options ------------------------------------------------------

def list_recharge_options(include_inactive=False):
    conn = db.get_connection()
    try:
        query = "SELECT * FROM recharge_options"
        if not include_inactive:
            query += " WHERE active = 1"
        query += " ORDER BY sort_order, id"
        return conn.execute(query).fetchall()
    finally:
        conn.close()


def get_recharge_option(option_id):
    conn = db.get_connection()
    try:
        return conn.execute("SELECT * FROM recharge_options WHERE id = ?", (option_id,)).fetchone()
    finally:
        conn.close()


def create_recharge_option(name, virtual_amount, cash_price):
    name = (name or "").strip()
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            max_sort = conn.execute(
                "SELECT COALESCE(MAX(sort_order), 0) AS m FROM recharge_options"
            ).fetchone()["m"]
            conn.execute(
                "INSERT INTO recharge_options (name, virtual_amount, cash_price, sort_order, created_at) "
                "VALUES (?, ?, ?, ?, ?)",
                (
                    name, max(0.01, float(virtual_amount)), max(0.0, float(cash_price)),
                    max_sort + 1, datetime.now().isoformat(timespec="seconds"),
                ),
            )
    finally:
        conn.close()


def update_recharge_option(option_id, name, virtual_amount, cash_price):
    name = (name or "").strip()
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            conn.execute(
                "UPDATE recharge_options SET name = ?, virtual_amount = ?, cash_price = ? WHERE id = ?",
                (name, max(0.01, float(virtual_amount)), max(0.0, float(cash_price)), option_id),
            )
    finally:
        conn.close()


def set_recharge_option_active(option_id, active):
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            conn.execute(
                "UPDATE recharge_options SET active = ? WHERE id = ?",
                (1 if active else 0, option_id),
            )
    finally:
        conn.close()


def list_recharge_option_bed_prices(option_id):
    conn = db.get_connection()
    try:
        rows = conn.execute(
            "SELECT bed_id, price_per_min FROM recharge_option_bed_prices WHERE recharge_option_id = ?",
            (option_id,),
        ).fetchall()
        return {row["bed_id"]: row["price_per_min"] for row in rows}
    finally:
        conn.close()


def set_recharge_option_bed_prices(option_id, bed_prices):
    """bed_prices: {bed_id: price_per_min_or_None}. A None value clears the
    override for that bed, falling back to the bed's own flat price."""
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            for bed_id, price in bed_prices.items():
                if price is None:
                    conn.execute(
                        "DELETE FROM recharge_option_bed_prices "
                        "WHERE recharge_option_id = ? AND bed_id = ?",
                        (option_id, bed_id),
                    )
                else:
                    conn.execute(
                        "INSERT INTO recharge_option_bed_prices (recharge_option_id, bed_id, price_per_min) "
                        "VALUES (?, ?, ?) "
                        "ON CONFLICT (recharge_option_id, bed_id) "
                        "DO UPDATE SET price_per_min = excluded.price_per_min",
                        (option_id, bed_id, max(0.0, float(price))),
                    )
    finally:
        conn.close()


# --- cards & lots ------------------------------------------------------

def list_cards(status=None, search=None, limit=None):
    """search matches a substring of the card number, phone, or name - with
    a studio's card list easily running into the hundreds or thousands,
    this is how staff find one instead of scrolling (or, for the session
    payment picker, typing-to-search instead of facing one giant dropdown).
    limit caps the result count (newest first) regardless of whether a
    search was given, so even a broad query can't return an unbounded list."""
    conn = db.get_connection()
    try:
        sql = (
            "SELECT c.*, COALESCE(SUM(l.remaining_amount), 0) AS balance "
            "FROM cards c LEFT JOIN card_lots l ON l.card_id = c.id"
        )
        conditions = []
        params = []
        if status is not None:
            conditions.append("c.status = ?")
            params.append(status)
        search = (search or "").strip()
        if search:
            conditions.append("(c.card_number LIKE ? OR c.phone LIKE ? OR c.name LIKE ?)")
            like = f"%{search}%"
            params.extend([like, like, like])
        if conditions:
            sql += " WHERE " + " AND ".join(conditions)
        sql += " GROUP BY c.id ORDER BY c.id DESC"
        if limit:
            sql += " LIMIT ?"
            params.append(int(limit))
        return conn.execute(sql, params).fetchall()
    finally:
        conn.close()


def get_card(card_id):
    conn = db.get_connection()
    try:
        card = conn.execute("SELECT * FROM cards WHERE id = ?", (card_id,)).fetchone()
        if card is None:
            return None
        card = dict(card)
        lots = conn.execute(
            "SELECT l.*, ro.name AS recharge_option_name "
            "FROM card_lots l LEFT JOIN recharge_options ro ON ro.id = l.recharge_option_id "
            "WHERE l.card_id = ? ORDER BY l.id",
            (card_id,),
        ).fetchall()
        card["lots"] = lots
        card["balance"] = sum(lot["remaining_amount"] for lot in lots)
        return card
    finally:
        conn.close()


def find_card_by_number(card_number):
    card_number = (card_number or "").strip()
    if not card_number:
        return None
    conn = db.get_connection()
    try:
        return conn.execute("SELECT * FROM cards WHERE card_number = ?", (card_number,)).fetchone()
    finally:
        conn.close()


def _check_card_number_unique(conn, card_number, exclude_card_id=None):
    if not card_number:
        return
    query = "SELECT id FROM cards WHERE card_number = ?"
    params = [card_number]
    if exclude_card_id is not None:
        query += " AND id != ?"
        params.append(exclude_card_id)
    existing = conn.execute(query, params).fetchone()
    if existing is not None:
        raise PaymentError(f"Вече има карта с номер \"{card_number}\" (№{existing['id']}).")


def _add_card_lot(conn, card_id, recharge_option_id):
    option = conn.execute(
        "SELECT * FROM recharge_options WHERE id = ? AND active = 1", (recharge_option_id,)
    ).fetchone()
    if option is None:
        raise PaymentError("Избраната опция за презареждане не съществува или е неактивна.")
    now = datetime.now().isoformat(timespec="seconds")
    conn.execute(
        "INSERT INTO card_lots (card_id, recharge_option_id, virtual_amount, remaining_amount, "
        "cash_price, created_at) VALUES (?, ?, ?, ?, ?, ?)",
        (card_id, recharge_option_id, option["virtual_amount"], option["virtual_amount"],
         option["cash_price"], now),
    )
    record_sale(
        conn, "card_recharge", f"Презареждане на карта №{card_id}: {option['name']}",
        cash_amount=option["cash_price"], virtual_amount=option["virtual_amount"],
        card_id=card_id, recharge_option_id=recharge_option_id,
    )


def issue_card(card_number, deposit_amount, first_recharge_option_id=None, name="", phone=""):
    card_number = (card_number or "").strip() or None
    deposit_amount = max(0.0, float(deposit_amount or 0))
    name = (name or "").strip()
    phone = (phone or "").strip()
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            _check_card_number_unique(conn, card_number)
            now = datetime.now().isoformat(timespec="seconds")
            cur = conn.execute(
                "INSERT INTO cards (card_number, deposit_amount, status, created_at, name, phone) "
                "VALUES (?, ?, 'active', ?, ?, ?)",
                (card_number, deposit_amount, now, name, phone),
            )
            card_id = cur.lastrowid
            if deposit_amount > 0:
                record_sale(
                    conn, "card_deposit_charge", f"Депозит за карта №{card_id}",
                    cash_amount=deposit_amount, card_id=card_id,
                )
            if first_recharge_option_id:
                _add_card_lot(conn, card_id, first_recharge_option_id)
        return card_id
    finally:
        conn.close()


def update_card_details(card_id, card_number, name, phone):
    card_number = (card_number or "").strip() or None
    name = (name or "").strip()
    phone = (phone or "").strip()
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            _check_card_number_unique(conn, card_number, exclude_card_id=card_id)
            conn.execute(
                "UPDATE cards SET card_number = ?, name = ?, phone = ? WHERE id = ?",
                (card_number, name, phone, card_id),
            )
    finally:
        conn.close()


def recharge_card(card_id, recharge_option_id):
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            _require_active_card(conn, card_id)
            _add_card_lot(conn, card_id, recharge_option_id)
    finally:
        conn.close()


def return_card(card_id, force_forfeit_balance=False):
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            card = _require_active_card(conn, card_id)
            balance = _card_balance(conn, card_id)
            if balance > 0 and not force_forfeit_balance:
                raise PaymentError(
                    f"Картата има оставащ баланс {balance:.2f} лв. Изразходвайте го или "
                    "отбележете анулиране на баланса, за да продължите с връщането."
                )
            now = datetime.now().isoformat(timespec="seconds")
            conn.execute(
                "UPDATE cards SET status = 'returned', returned_at = ? WHERE id = ?",
                (now, card_id),
            )
            if card["deposit_amount"] > 0:
                record_sale(
                    conn, "card_deposit_refund", f"Връщане на депозит за карта №{card_id}",
                    cash_amount=-card["deposit_amount"], card_id=card_id,
                )
            if balance > 0:
                conn.execute(
                    "UPDATE card_lots SET remaining_amount = 0 "
                    "WHERE card_id = ? AND remaining_amount > 0",
                    (card_id,),
                )
                record_sale(
                    conn, "card_balance_forfeit", f"Анулиран баланс при връщане на карта №{card_id}",
                    card_amount=-balance, card_id=card_id,
                )
    finally:
        conn.close()


# --- chip cards (SLE4442 hardware) -----------------------------------

# The old program stored each card's issuing location as a studio
# name/number (for a multi-location chain sharing card stock); this app
# is single-location, so these are fixed rather than a setting.
CHIP_STUDIO_NAME = "Solar Studio"
CHIP_STUDIO_NUMBER = 0


def list_chip_cards(search=None, limit=None):
    """search matches a substring of the client number, card number,
    phone, or name - same reasoning as list_cards. There is no balance
    column here: a chip card's money lives on the physical card, read
    fresh from the reader, never cached in this database."""
    conn = db.get_connection()
    try:
        sql = "SELECT * FROM chip_cards"
        conditions = []
        params = []
        search = (search or "").strip()
        if search:
            conditions.append(
                "(CAST(client_number AS TEXT) LIKE ? OR CAST(card_number AS TEXT) LIKE ? "
                "OR phone LIKE ? OR name LIKE ?)"
            )
            like = f"%{search}%"
            params.extend([like, like, like, like])
        if conditions:
            sql += " WHERE " + " AND ".join(conditions)
        sql += " ORDER BY id DESC"
        if limit:
            sql += " LIMIT ?"
            params.append(int(limit))
        return conn.execute(sql, params).fetchall()
    finally:
        conn.close()


def find_chip_card_by_client_number(client_number):
    if client_number is None:
        return None
    conn = db.get_connection()
    try:
        return conn.execute(
            "SELECT * FROM chip_cards WHERE client_number = ?", (client_number,)
        ).fetchone()
    finally:
        conn.close()


def issue_chip_card(name, phone, deposit_amount, recharge_option_id=None, reader_name=None):
    """Write client identity (and an optional first recharge) onto a
    card that isn't registered yet. The database record is committed
    *before* the chip write: a card that exists in our records but
    failed to actually write is just a retry; real money landing on a
    card with no record anywhere that it was ever issued is much worse
    to untangle."""
    name = (name or "").strip()
    phone = (phone or "").strip()
    deposit_amount = max(0.0, float(deposit_amount or 0))

    card = chipcard.read_card(reader_name)
    if card["client_number"] is not None:
        raise PaymentError(
            f"Тази карта вече е издадена (клиент №{card['client_number']}). "
            "Използвайте презареждане вместо издаване."
        )

    conn = db.get_connection()
    try:
        option = None
        if recharge_option_id:
            option = conn.execute(
                "SELECT * FROM recharge_options WHERE id = ? AND active = 1", (recharge_option_id,)
            ).fetchone()
            if option is None:
                raise PaymentError("Избраната опция за презареждане не съществува или е неактивна.")
        balance = option["virtual_amount"] if option else 0.0

        with db.transaction(conn):
            row = conn.execute(
                "SELECT COALESCE(MAX(client_number), 0) + 1 AS n FROM chip_cards"
            ).fetchone()
            client_number = row["n"]

            now = datetime.now().isoformat(timespec="seconds")
            conn.execute(
                "INSERT INTO chip_cards (client_number, card_number, name, phone, "
                "deposit_amount, status, created_at) VALUES (?, ?, ?, ?, ?, 'active', ?)",
                (client_number, client_number, name, phone, deposit_amount, now),
            )
            if deposit_amount > 0:
                record_sale(
                    conn, "card_deposit_charge", f"Депозит за чип карта №{client_number}",
                    cash_amount=deposit_amount,
                )
            if option:
                record_sale(
                    conn, "card_recharge",
                    f"Презареждане на чип карта №{client_number}: {option['name']}",
                    cash_amount=option["cash_price"], virtual_amount=option["virtual_amount"],
                    recharge_option_id=option["id"],
                )
    finally:
        conn.close()

    try:
        chipcard.write_card(
            reader_name, psc=chipcard.DEFAULT_PSC,
            studio_name=CHIP_STUDIO_NAME, studio_number=CHIP_STUDIO_NUMBER,
            client_name=name, balance=balance,
            client_number=client_number, card_number=client_number,
        )
    except chipcard.ChipCardError as exc:
        raise PaymentError(
            f"Картата е регистрирана в системата (клиент №{client_number}), но записът на "
            f"чипа се провали: {exc}. Не вадете картата и опитайте презареждане, за да "
            "довършите записа."
        ) from exc

    return client_number


def recharge_chip_card(recharge_option_id, reader_name=None):
    """Add a recharge option's virtual amount to whatever's currently on
    the inserted card. The card's own balance is the source of truth -
    read fresh, added to, written back - so this is correct even if the
    card was last used (and its balance changed) by the old program."""
    card = chipcard.read_card(reader_name)
    if card["client_number"] is None:
        raise PaymentError('Картата не е издадена. Използвайте "Издай нова карта".')
    if card["balance"] is None:
        raise PaymentError("Балансът на картата не може да бъде прочетен (повредени данни).")

    conn = db.get_connection()
    try:
        option = conn.execute(
            "SELECT * FROM recharge_options WHERE id = ? AND active = 1", (recharge_option_id,)
        ).fetchone()
        if option is None:
            raise PaymentError("Избраната опция за презареждане не съществува или е неактивна.")
        new_balance = round(card["balance"] + option["virtual_amount"], 2)

        chip_card = conn.execute(
            "SELECT * FROM chip_cards WHERE client_number = ?", (card["client_number"],)
        ).fetchone()
        label = f"№{card['client_number']}"
        if chip_card and chip_card["name"]:
            label += f" ({chip_card['name']})"

        with db.transaction(conn):
            record_sale(
                conn, "card_recharge", f"Презареждане на чип карта {label}: {option['name']}",
                cash_amount=option["cash_price"], virtual_amount=option["virtual_amount"],
                recharge_option_id=option["id"],
            )
    finally:
        conn.close()

    try:
        chipcard.write_card(reader_name, psc=chipcard.DEFAULT_PSC, balance=new_balance)
    except chipcard.ChipCardError as exc:
        raise PaymentError(
            f"Презареждането е записано в дневника, но записът на чипа се провали: {exc}. "
            "Не вадете картата и опитайте отново, за да довършите записа."
        ) from exc

    return new_balance


def quote_chip_session(bed_id, total_min, requested_chip_amount, reader_name=None):
    """Read-only preview, same response shape as quote_session_payment
    but for a chip card - no write happens here."""
    conn = db.get_connection()
    try:
        bed = conn.execute("SELECT price_per_min FROM beds WHERE id = ?", (bed_id,)).fetchone()
        if bed is None:
            raise ValueError(f"Unknown bed id {bed_id}")
        flat_price = bed["price_per_min"]
    finally:
        conn.close()

    card = chipcard.read_card(reader_name)
    balance = card["balance"] or 0.0
    total_cost = round(total_min * flat_price, 2)
    requested_chip_amount = max(0.0, float(requested_chip_amount or 0))
    chip_amount = round(min(requested_chip_amount, balance, total_cost), 2)
    cash_amount = round(total_cost - chip_amount, 2)
    return {
        "card_amount": chip_amount,
        "cash_amount": cash_amount,
        "card_balance_after": round(balance - chip_amount, 2),
        "client_name": card["client_name"],
        "client_number": card["client_number"],
    }


def charge_chip_card_for_session(bed_id, total_min, requested_chip_amount, reader_name=None):
    """Read a chip card, work out how much of `requested_chip_amount` it
    can actually cover (capped by its balance and the session's total
    cost), write the reduced balance back to the card, and return the
    breakdown for the caller to log and start the session with.

    The chip write happens here, before any database write - the
    opposite order from issuing/recharging (which add value): deducting
    money risks giving the session away for free if the chip write
    happened *after* a database step that then failed."""
    conn = db.get_connection()
    try:
        bed = conn.execute("SELECT price_per_min FROM beds WHERE id = ?", (bed_id,)).fetchone()
        if bed is None:
            raise ValueError(f"Unknown bed id {bed_id}")
        flat_price = bed["price_per_min"]
    finally:
        conn.close()

    card = chipcard.read_card(reader_name)
    if card["client_number"] is None:
        raise PaymentError("Картата не е издадена.")
    if card["balance"] is None:
        raise PaymentError("Балансът на картата не може да бъде прочетен (повредени данни).")

    total_cost = round(total_min * flat_price, 2)
    requested_chip_amount = max(0.0, float(requested_chip_amount or 0))
    chip_amount = round(min(requested_chip_amount, card["balance"], total_cost), 2)
    cash_amount = round(total_cost - chip_amount, 2)
    new_balance = round(card["balance"] - chip_amount, 2)

    if chip_amount > 0:
        chipcard.write_card(reader_name, psc=chipcard.DEFAULT_PSC, balance=new_balance)

    return {
        "chip_amount": chip_amount,
        "cash_amount": cash_amount,
        "client_number": card["client_number"],
        "client_name": card["client_name"],
        "new_balance": new_balance,
    }


# --- cosmetics / products ------------------------------------------------

def list_products(include_inactive=False):
    conn = db.get_connection()
    try:
        query = "SELECT * FROM products"
        if not include_inactive:
            query += " WHERE active = 1"
        query += " ORDER BY name"
        return conn.execute(query).fetchall()
    finally:
        conn.close()


def get_product(product_id):
    conn = db.get_connection()
    try:
        return conn.execute("SELECT * FROM products WHERE id = ?", (product_id,)).fetchone()
    finally:
        conn.close()


def create_product(name, sale_price, initial_stock=0):
    name = (name or "").strip()
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            conn.execute(
                "INSERT INTO products (name, sale_price, stock_qty, created_at) VALUES (?, ?, ?, ?)",
                (
                    name, max(0.0, float(sale_price)), max(0, int(initial_stock)),
                    datetime.now().isoformat(timespec="seconds"),
                ),
            )
    finally:
        conn.close()


def update_product(product_id, name, sale_price):
    name = (name or "").strip()
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            conn.execute(
                "UPDATE products SET name = ?, sale_price = ? WHERE id = ?",
                (name, max(0.0, float(sale_price)), product_id),
            )
    finally:
        conn.close()


def set_product_active(product_id, active):
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            conn.execute("UPDATE products SET active = ? WHERE id = ?", (1 if active else 0, product_id))
    finally:
        conn.close()


def restock_product(product_id, add_qty):
    """Inventory replenishment (a new delivery arrived) - deliberately not
    written to sales_log, which is an income/outcome ledger, not a stock
    ledger, and a routine delivery needs no explanation. A downward
    correction is a different thing entirely - see adjust_stock."""
    add_qty = int(add_qty)
    if add_qty <= 0:
        return
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            conn.execute("UPDATE products SET stock_qty = stock_qty + ? WHERE id = ?", (add_qty, product_id))
    finally:
        conn.close()


def adjust_stock(product_id, new_stock_qty, reason=""):
    """Correct a product's stock to a specific counted value - e.g. after a
    physical inventory finds less on the shelf than the system expects
    (shrinkage, breakage, a past counting error). Unlike restock_product
    this can move stock down as well as up, and unlike a routine delivery
    it's not self-explanatory, so it IS written to sales_log (as a
    zero-money entry carrying the before/after counts and whatever reason
    staff gave) so a manager reviewing the daily protocol can see exactly
    when and why a correction was made, not just that stock changed."""
    new_stock_qty = max(0, int(new_stock_qty))
    reason = (reason or "").strip()
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            product = conn.execute("SELECT * FROM products WHERE id = ?", (product_id,)).fetchone()
            if product is None:
                raise PaymentError("Продуктът не съществува.")
            old_qty = product["stock_qty"]
            delta = new_stock_qty - old_qty
            if delta == 0:
                return
            conn.execute("UPDATE products SET stock_qty = ? WHERE id = ?", (new_stock_qty, product_id))
            description = f"Корекция на наличност: {product['name']} {old_qty} → {new_stock_qty} бр."
            if reason:
                description += f" ({reason})"
            record_sale(conn, "stock_adjustment", description, qty=delta, product_id=product_id)
    finally:
        conn.close()


def sell_products(items, card_id=None, card_amount=0):
    """Check out a whole basket in one atomic transaction. items: iterable
    of (product_id, qty) pairs. Stock is validated for every line up front
    so a multi-item sale never partially applies; one combined sales_log
    line is recorded for the whole basket (its description already lists
    everything sold, and a row per item would clutter the daily protocol
    for what is, from the register's point of view, a single sale)."""
    conn = db.get_connection()
    try:
        with db.transaction(conn):
            lines = []
            total = 0.0
            total_qty = 0
            for product_id, qty in items:
                qty = int(qty)
                if qty <= 0:
                    continue
                product = conn.execute("SELECT * FROM products WHERE id = ?", (product_id,)).fetchone()
                if product is None:
                    raise PaymentError("Продуктът не съществува.")
                if product["stock_qty"] < qty:
                    raise PaymentError(
                        f"Няма достатъчно наличност от \"{product['name']}\" ({product['stock_qty']} бр.)."
                    )
                lines.append((product, qty))
                total += product["sale_price"] * qty
                total_qty += qty

            if not lines:
                raise PaymentError("Кошницата е празна.")

            total = round(total, 2)
            actual_card_amount = 0.0
            if card_id and card_amount and float(card_amount) > 0:
                actual_card_amount = _deduct_card_money_fifo(conn, card_id, min(float(card_amount), total))
            cash_amount = round(total - actual_card_amount, 2)

            for product, qty in lines:
                conn.execute(
                    "UPDATE products SET stock_qty = stock_qty - ? WHERE id = ?", (qty, product["id"])
                )

            description = ", ".join(f"{product['name']} x{qty}" for product, qty in lines)
            record_sale(
                conn, "product_sale", f"Продажба: {description}",
                cash_amount=cash_amount, card_amount=actual_card_amount,
                qty=total_qty, card_id=card_id,
            )
    finally:
        conn.close()


# --- sales log -------------------------------------------------------------

def list_sales_log(date=None, kind=None):
    date = date or datetime.now().strftime("%Y-%m-%d")
    conn = db.get_connection()
    try:
        query = "SELECT * FROM sales_log WHERE created_at LIKE ?"
        params = [f"{date}%"]
        if kind:
            query += " AND kind = ?"
            params.append(kind)
        query += " ORDER BY created_at"
        return conn.execute(query, params).fetchall()
    finally:
        conn.close()


def sales_log_summary(date=None):
    date = date or datetime.now().strftime("%Y-%m-%d")
    conn = db.get_connection()
    try:
        rows = conn.execute(
            "SELECT kind, COUNT(*) AS count, COALESCE(SUM(cash_amount), 0) AS cash_total, "
            "COALESCE(SUM(card_amount), 0) AS card_total, COALESCE(SUM(virtual_amount), 0) AS virtual_total "
            "FROM sales_log WHERE created_at LIKE ? GROUP BY kind",
            (f"{date}%",),
        ).fetchall()
        return {
            "by_kind": rows,
            "totals": {
                "cash_total": sum(r["cash_total"] for r in rows),
                "card_total": sum(r["card_total"] for r in rows),
                "virtual_total": sum(r["virtual_total"] for r in rows),
            },
        }
    finally:
        conn.close()
