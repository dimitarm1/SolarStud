"""One-off-but-repeatable import from the old Delphi/Paradox program's own
database export (a small SQL-subset dump it writes via its own modified
export feature - CREATE TABLE/INSERT INTO statements, Windows-1251
encoded, Delphi/Paradox types like AUTOINC/CURRENCY/MEMO that don't exist
in SQLite).

This is a REPLACE, not a merge: by the studio's own choice (there is no
reliable way to tell "old real data" apart from "new test data" without
human judgment, and merging would just produce duplicates), importing
wipes products/cards/chip_cards/sales_log and overwrites a few bed/studio
settings fields, then rebuilds them from the export. It never touches
beds.controller_address or beds.picture_path (old hardware addresses use a
different numbering scheme - old address 16 would be silently
reinterpreted as this app's "demo bed" marker - and old picture paths are
dead Windows paths), and it never touches anything about sessions/users
beyond the staff login list itself.

Only the four tables this app has an actual destination for are imported:
STAFF LOGINS (personal), BEDS (SOLARIUM: name/model/price/prep/cool only),
PRODUCTS (STOKI type 'S'), CLIENTS (KLIENTI -> chip_cards registry, plus a
virtual card for anyone with a positive balance), SALES HISTORY
(PLASHTANIA -> sales_log, best-effort - see _map_plashtania_row), and the
STUDIO IDENTITY (INTERNET -> chip_studio_name/number/psc). Tables with no
equivalent concept in this app at all (happyhour, messages, KARTIALL,
FIRMI, PLANNER, PARAMS, CHIPKARTI, TABLICA_CENI's tiered per-minute price
table) are read but intentionally ignored."""

import re
from datetime import datetime

from werkzeug.security import generate_password_hash

import db
import models

ENCODING = "cp1251"


class LegacyImportError(Exception):
    """Raised when the uploaded file isn't a recognizable export - mirrors
    sales.PaymentError/chipcard.ChipCardError."""


# --- parsing ----------------------------------------------------------------

_INSERT_RE = re.compile(
    r"INSERT\s+INTO\s+(\w+)\s*\(([^)]*)\)\s*VALUES\s*\((.*)\)\s*;?\s*$",
    re.IGNORECASE,
)


def _split_values(s):
    """Split one VALUES(...) tuple's insides on top-level commas, respecting
    '...' string literals (with '' as an escaped quote, standard SQL)."""
    tokens, buf, in_str, i, n = [], [], False, 0, len(s)
    while i < n:
        c = s[i]
        if in_str:
            if c == "'" and i + 1 < n and s[i + 1] == "'":
                buf.append("'")
                i += 2
                continue
            if c == "'":
                in_str = False
            buf.append(c)
            i += 1
            continue
        if c == "'":
            in_str = True
            buf.append(c)
            i += 1
            continue
        if c == ",":
            tokens.append("".join(buf).strip())
            buf = []
            i += 1
            continue
        buf.append(c)
        i += 1
    if buf or tokens:
        tokens.append("".join(buf).strip())
    return tokens


def _parse_value(tok):
    t = tok.strip()
    upper = t.upper()
    if upper == "NULL":
        return None
    if upper == "TRUE":
        return True
    if upper == "FALSE":
        return False
    if t.startswith("'") and t.endswith("'"):
        return t[1:-1].replace("''", "'")
    try:
        return int(t)
    except ValueError:
        pass
    try:
        return float(t)
    except ValueError:
        return t


def parse_export(text):
    """Returns {TABLE_NAME_UPPER: [row_dict, ...]} from every INSERT INTO
    statement found - one per line in every export seen so far, but the
    regex doesn't require that. Malformed lines are skipped rather than
    aborting the whole import (a single bad row from a hand-edited export
    shouldn't block everything else)."""
    tables = {}
    for line in text.splitlines():
        line = line.strip()
        if not line or not line.upper().startswith("INSERT INTO"):
            continue
        m = _INSERT_RE.match(line)
        if not m:
            continue
        table, cols_raw, vals_raw = m.group(1).upper(), m.group(2), m.group(3)
        cols = [c.strip() for c in cols_raw.split(",")]
        raw_vals = _split_values(vals_raw)
        if len(raw_vals) != len(cols):
            continue
        row = dict(zip(cols, (_parse_value(v) for v in raw_vals)))
        tables.setdefault(table, []).append(row)
    return tables


# --- field helpers -----------------------------------------------------------

def _text(v):
    return (str(v).strip() if v is not None else "")


def _num(v, default=0.0):
    if v is None:
        return default
    try:
        return float(v)
    except (TypeError, ValueError):
        return default


def _clamp(v, lo, hi):
    return max(lo, min(hi, v))


# --- per-table import steps ---------------------------------------------

def _import_users(conn, personal_rows):
    """Replaces the users table with the old program's staff list - but
    whoever was the database's first admin before this import keeps
    existing afterward, with their existing password untouched, so the
    person running the import (or anyone else relying on that account)
    is never locked out of their own, already-running installation by an
    import that replaces everything else. "First" = earliest-created
    active admin; if the imported list happens to reuse that exact
    username, the imported row is left alone rather than duplicated."""
    preserved_admin = conn.execute(
        "SELECT * FROM users WHERE role = 'admin' AND active = 1 ORDER BY id LIMIT 1"
    ).fetchone()

    seen = {}
    for row in personal_rows:
        name = _text(row.get("IME"))
        password = _text(row.get("PAROLA"))
        if not name or not password:
            continue
        seen[name] = password  # last occurrence in the file wins

    conn.execute("DELETE FROM users")
    now = datetime.now().isoformat(timespec="seconds")
    for name, password in seen.items():
        conn.execute(
            "INSERT INTO users (username, password_hash, role, active, created_at) "
            "VALUES (?, ?, 'admin', 1, ?)",
            (name, generate_password_hash(password), now),
        )

    preserved = False
    if preserved_admin is not None and preserved_admin["username"] not in seen:
        conn.execute(
            "INSERT INTO users (username, password_hash, role, active, created_at) "
            "VALUES (?, ?, 'admin', 1, ?)",
            (preserved_admin["username"], preserved_admin["password_hash"], now),
        )
        preserved = True

    return len(seen) + (1 if preserved else 0), preserved_admin["username"] if preserved else None


def _import_beds(conn, solarium_rows):
    existing_ids = {r["id"] for r in conn.execute("SELECT id FROM beds")}
    updated = 0
    for row in solarium_rows:
        bed_id = row.get("SOLARIUM")
        if bed_id not in existing_ids:
            continue
        number = _text(row.get("OPISANIE1")) or f"No {bed_id}"
        model = _text(row.get("OPISANIE2")) or ""
        price_per_min = max(0.0, _num(row.get("CENA")))
        prep_min = int(_clamp(_num(row.get("PREDVVREME")), models.MIN_PREP_MINUTES, models.MAX_PREP_MINUTES))
        cool_min = int(_clamp(_num(row.get("OHLAZDANE")), models.MIN_COOL_MINUTES, models.MAX_COOL_MINUTES))
        conn.execute(
            "UPDATE beds SET number = ?, model = ?, price_per_min = ?, prep_min = ?, cool_min = ? "
            "WHERE id = ?",
            (number, model, price_per_min, prep_min, cool_min, bed_id),
        )
        updated += 1
    return updated


def _build_stoki_lookup(stoki_rows):
    """{STOKAKOD: {"name", "price"}} for every STOKI row, not just real
    products - _classify_stoki_name below needs the name of *every* code
    a PLASHTANIA row might reference, including the marker SKUs."""
    lookup = {}
    for row in stoki_rows:
        code = row.get("STOKAKOD")
        if code is None:
            continue
        lookup[code] = {"name": _text(row.get("STOKAIME")), "price": _num(row.get("STOKACENA"))}
    return lookup


def _classify_stoki_name(name):
    """The old program reuses the generic STOKI "products" table for a
    handful of non-product marker SKUs, told apart only by name (their
    STOKATIP doesn't distinguish them - confirmed against a real export,
    where a chip top-up and a barcode-card recharge are both 'K').
    Resolved here once so both the sales_log mapping and the card_lots
    reconstruction below classify a code the same way:

    - "Нова Чип Карта..." -> a chip card top-up/payment tag, not a
      barcode-card recharge.
    - "Карта ... евро" (or any other "Карта..." that isn't the chip
      variant) -> an actual barcode-card recharge package - this is what
      _build_card_lots uses to reconstruct real recharge history.
    - "Депозит" -> a deposit charge.
    - "Изтриване на клиент" -> a client-deletion marker, not a
      transaction at all (already filtered out upstream by its own
      zero-amount rows in practice, but named here for clarity).
    - anything else -> not a marker; a real retail product, or unknown."""
    name = (name or "").strip()
    if not name:
        return None
    if name.startswith("Нова Чип Карта"):
        return "chip"
    if name.startswith("Карта"):
        return "card_recharge"
    if name == "Депозит":
        return "deposit"
    if name == "Изтриване на клиент":
        return "client_deleted"
    return None


def _import_products(conn, stoki_rows):
    conn.execute("DELETE FROM products")
    now = datetime.now().isoformat(timespec="seconds")
    count = 0
    for row in stoki_rows:
        if _text(row.get("STOKATIP")) != "S":
            continue
        name = _text(row.get("STOKAIME"))
        price = max(0.0, _num(row.get("STOKACENA")))
        stock = max(0, int(_num(row.get("STOKANASKLAD"))))
        if not name or (price == 0 and stock == 0):
            continue  # unused placeholder slot in the old catalog, not a real product
        conn.execute(
            "INSERT INTO products (name, sale_price, stock_qty, active, created_at) "
            "VALUES (?, ?, ?, 1, ?)",
            (name, price, stock, now),
        )
        count += 1
    return count


def _import_clients(conn, klienti_rows, plashtania_rows, stoki_lookup):
    """KLIENTI is the old program's one unified client registry - most
    entries are also chip-card holders (see KARTICHIP.KLIENTNOMER), but
    this app keeps chip cards and virtual cards as two separate,
    independent mechanisms (chipcard.py's balance is never DB-cached), so
    every client becomes a chip_cards registry row (identity only), and
    anyone with a positive old BALANS *also* gets a brand new virtual
    card carrying that balance as real, spendable credit - the one piece
    of this import that represents actual money owed to a real customer,
    so it's not just dropped. Where exactly that balance came from (which
    recharge package, bought when) is reconstructed from PLASHTANIA by
    _build_card_lots rather than dumped in as one anonymous lump.

    The virtual card's own id is set explicitly to the old client number
    (NOMER) instead of letting SQLite autoincrement it - cards.id is
    already what's shown everywhere as the account's "№..." (see
    card_detail.html, cards.html), so reusing the same number staff
    already know from the old program *is* that number, not a second
    number living alongside it. replace_card/update_card_details are
    unaffected either way - they only ever change card_number (the
    physical barcode) or deposit/contact fields, never the id a card's
    balance and history (card_lots.card_id, sales_log.card_id) are keyed
    on, so losing a barcode and getting a new one still preserves the
    same id, same balance, same history, same as for any other card.
    The one real cost: SQLite's AUTOINCREMENT then continues issuing new
    ids above whatever the highest imported client number was, so a
    genuinely new client signed up after this import gets a big, legacy-
    looking number too, not a small one - cosmetic, but real; nothing
    else depends on these ids being small or sequential.

    A negative NOMER is the old program's own soft-delete marker, not a
    real client: it's -YYMMDD, the date the client was deleted (confirmed
    against a real export - e.g. -261112 is a client deleted on
    2026-11-12), with the row otherwise left in place carrying whatever
    stale balance it had at that moment. The same person is often also
    re-registered under a real, positive client number with the same
    name - importing the negative row too would resurrect a deleted
    account as a second, duplicate active card alongside the real one,
    each with its own (now meaningless) balance."""
    conn.execute("DELETE FROM chip_cards")
    conn.execute("DELETE FROM cards")  # card_lots cascades

    by_client_number = {}
    for row in klienti_rows:
        client_number = row.get("NOMER")
        if client_number is None or client_number < 0:
            continue
        by_client_number[client_number] = row  # last occurrence wins

    # Every barcode-card recharge event, grouped by client and dated -
    # OTCHIPKARTA is the client's number regardless of which payment
    # mechanism a transaction actually used (confirmed against a real
    # export: it's set the same way on "Карта NN евро" recharge rows as
    # on chip-card ones), so it's the right join key here too.
    recharges_by_client = {}
    for row in plashtania_rows:
        client_number = row.get("OTCHIPKARTA")
        amount = row.get("SUMABROI")
        stoka = row.get("STOKA")
        if client_number is None or amount is None or _num(amount) <= 0 or stoka is None:
            continue
        info = stoki_lookup.get(stoka)
        if info is None or _classify_stoki_name(info["name"]) != "card_recharge":
            continue
        date = _text(row.get("DATA"))
        time_part = _text(row.get("CHAS")) or "00:00:00"
        recharges_by_client.setdefault(client_number, []).append({
            "created_at": f"{date}T{time_part}" if date else "",
            "amount": round(_num(amount), 2),
            "option_name": info["name"],
        })
    for recharges in recharges_by_client.values():
        recharges.sort(key=lambda r: r["created_at"])

    now = datetime.now().isoformat(timespec="seconds")
    recharge_option_cache = {}
    chip_count = 0
    card_count = 0
    option_count = 0
    card_ids_created = set()
    for client_number, row in by_client_number.items():
        name = _text(row.get("IME"))
        phone = _text(row.get("TELEFON"))
        conn.execute(
            "INSERT INTO chip_cards (client_number, name, phone, deposit_amount, status, created_at) "
            "VALUES (?, ?, ?, 0, 'active', ?)",
            (client_number, name, phone, now),
        )
        chip_count += 1

        balance = _num(row.get("BALANS"), default=0.0)
        if balance <= 0:
            continue
        conn.execute(
            "INSERT INTO cards (id, deposit_amount, status, created_at, name, phone) "
            "VALUES (?, 0, 'active', ?, ?, ?)",
            (client_number, now, name, phone),
        )
        card_count += 1
        card_ids_created.add(client_number)
        option_count += _build_card_lots(
            conn, client_number, balance, recharges_by_client.get(client_number, []),
            recharge_option_cache, now,
        )
    return chip_count, card_count, option_count, card_ids_created


def _build_card_lots(conn, card_id, balance, recharges, recharge_option_cache, now):
    """Rebuilds this client's card_lots to match their known, authoritative
    current balance (KLIENTI.BALANS, in `balance`) exactly, while keeping
    as much of their real recharge history as PLASHTANIA actually shows:

    - No recharge history found at all -> one generic, unlinked lot for
      the full balance - the old fallback behavior, still correct, just
      with no recharge_option behind it (this is what every client got
      before this function existed).
    - History found -> each past recharge becomes its own lot (the same
      option, amount, and real date it happened), then whatever's
      already been spent (total ever recharged, minus the current
      balance) is drawn down oldest-lot-first - the exact same FIFO rule
      this app already uses for a real session payment, so the
      reconstruction is consistent with how the balance will keep being
      drawn down from here on. If the recharges found don't add up to
      the current balance (history from outside this export's time
      window, say), one more generic lot covers the shortfall - the
      lots must always sum to exactly `balance`, never anything else.

    recharge_option_cache is shared across all clients in one import run,
    so the same "Карта 30 евро"-style package becomes one recharge_option
    row (reused if a matching one already exists), not a new one per
    client. Returns how many new recharge_options this call created."""
    if not recharges:
        conn.execute(
            "INSERT INTO card_lots (card_id, recharge_option_id, virtual_amount, "
            "remaining_amount, cash_price, created_at) VALUES (?, NULL, ?, ?, ?, ?)",
            (card_id, balance, balance, balance, now),
        )
        return 0

    options_created = 0
    total_recharged = sum(r["amount"] for r in recharges)
    to_consume = max(0.0, round(total_recharged - balance, 2))

    for r in recharges:
        key = (r["option_name"], r["amount"])
        option_id = recharge_option_cache.get(key)
        if option_id is None:
            existing = conn.execute(
                "SELECT id FROM recharge_options WHERE name = ? AND virtual_amount = ? AND cash_price = ?",
                (r["option_name"], r["amount"], r["amount"]),
            ).fetchone()
            if existing is not None:
                option_id = existing["id"]
            else:
                cur = conn.execute(
                    "INSERT INTO recharge_options (name, virtual_amount, cash_price, active, "
                    "sort_order, created_at) VALUES (?, ?, ?, 1, 0, ?)",
                    (r["option_name"], r["amount"], r["amount"], now),
                )
                option_id = cur.lastrowid
                options_created += 1
            recharge_option_cache[key] = option_id

        used = min(to_consume, r["amount"])
        remaining = round(r["amount"] - used, 2)
        to_consume = round(to_consume - used, 2)
        conn.execute(
            "INSERT INTO card_lots (card_id, recharge_option_id, virtual_amount, "
            "remaining_amount, cash_price, created_at) VALUES (?, ?, ?, ?, ?, ?)",
            (card_id, option_id, r["amount"], remaining, r["amount"], r["created_at"] or now),
        )

    shortfall = round(max(0.0, balance - total_recharged), 2)
    if shortfall > 0:
        conn.execute(
            "INSERT INTO card_lots (card_id, recharge_option_id, virtual_amount, "
            "remaining_amount, cash_price, created_at) VALUES (?, NULL, ?, ?, ?, ?)",
            (card_id, shortfall, shortfall, shortfall, now),
        )
    return options_created


def _map_plashtania_row(row, known_bed_ids, studio_number, stoki_lookup, card_ids_created):
    """Best-effort mapping, not a faithful one: PLASHTANIA's OTKARTA /
    KARTASUMA / STATUS columns mix card references and payment-split
    amounts in ways this import can't fully disambiguate without the old
    program's own source (which doesn't write these fields anywhere this
    project can see). To avoid recording a confidently wrong split, every
    imported row's whole amount lands in cash_amount and no card_id FK is
    guessed at beyond the one safe case below - better an approximate
    total than a specific-looking but possibly wrong attribution.
    kind/description for a marker SKU (see _classify_stoki_name) are
    resolved the same way _build_card_lots classifies barcode-card
    recharges, so the two stay consistent with each other.

    OTCHIPKARTA is different: it reliably holds the client number for
    whichever transaction used one, chip or barcode card alike (checked
    against a sample of the real export - every non-null value matches a
    real KLIENTI client number), so it's carried over as
    chip_client_number/chip_studio_number - this alone is what makes
    "find this client's history by number" (the chip-card print/history
    feature) keep working for pre-import transactions after the switch.
    Since this virtual card's own id *is* that same client number
    (_import_clients), the row's card_id can be set too, whenever
    card_ids_created confirms a card with that id actually exists (a
    plain FK, so an unmatched one would otherwise abort the whole
    import) - without this, a client's own "История" button
    (card_print -> card_history(card_id=...)) would always come back
    empty for every imported transaction, chip_client_number or not.

    Returns None for rows with no real money movement at all (pure
    scan/presence log lines, or a client-deletion marker). A session
    paid entirely from a card/chip balance has SUMABROI = 0 (no cash
    changed hands) and the real amount in KARTASUMA instead - checked
    against a real export, this is roughly a third of all session rows,
    so treating SUMABROI = 0 as "nothing happened" (the original,
    simpler version of this filter) silently dropped a third of every
    client's actual visit history. Both fields are added together for
    the "was anything real recorded here at all" check, and kept as
    separate cash_amount/card_amount below - the handful of rows that
    have both set (a split cash + balance payment) come out correctly
    split too, not just lumped into cash."""
    sumabroi = _num(row.get("SUMABROI"), 0.0)
    kartasuma = _num(row.get("KARTASUMA"), 0.0)
    if sumabroi == 0 and kartasuma == 0:
        return None

    date = _text(row.get("DATA"))
    time_part = _text(row.get("CHAS")) or "00:00:00"
    created_at = f"{date}T{time_part}" if date else datetime.now().isoformat(timespec="seconds")

    bed_id = row.get("SOLARIUM")
    stoka = row.get("STOKA")
    info = stoki_lookup.get(stoka) if stoka is not None else None
    marker = _classify_stoki_name(info["name"]) if info else None

    if bed_id is not None and bed_id in known_bed_ids:
        kind = "session_payment"
        description = f"Солариум {bed_id} (внос от стара програма)"
    elif marker == "card_recharge":
        kind = "card_recharge"
        description = f"Презареждане на баркод карта: {info['name']} (внос от стара програма)"
    elif marker == "chip":
        kind = "card_recharge"
        description = "Презареждане на чип карта (внос от стара програма)"
    elif marker == "deposit":
        kind = "card_deposit_charge"
        description = "Депозит (внос от стара програма)"
    elif marker == "client_deleted":
        return None
    elif stoka is not None and stoka < 0:
        # An unrecognized negative code - still clearly not a retail sale
        # (every negative STOKA seen so far is one marker type or another),
        # so it's kept as an approximate recharge rather than mislabeled
        # as a cosmetics sale.
        kind = "card_recharge"
        description = "Презареждане (внос от стара програма)"
    else:
        kind = "product_sale"
        description = "Продажба (внос от стара програма)"

    chip_client_number = row.get("OTCHIPKARTA")
    return {
        "created_at": created_at,
        "kind": kind,
        "description": description,
        "cash_amount": round(sumabroi, 2),
        "card_amount": round(kartasuma, 2),
        "bed_id": bed_id if kind == "session_payment" else None,
        "card_id": chip_client_number if chip_client_number in card_ids_created else None,
        "qty": row.get("BROI"),
        "chip_client_number": chip_client_number,
        "chip_studio_number": studio_number if chip_client_number is not None else None,
    }


def _import_sales_log(conn, plashtania_rows, known_bed_ids, studio_number, stoki_lookup, card_ids_created):
    conn.execute("DELETE FROM sales_log")
    count = 0
    for row in plashtania_rows:
        mapped = _map_plashtania_row(row, known_bed_ids, studio_number, stoki_lookup, card_ids_created)
        if mapped is None:
            continue
        conn.execute(
            "INSERT INTO sales_log (created_at, kind, description, cash_amount, card_amount, "
            "qty, bed_id, card_id, chip_client_number, chip_studio_number) "
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            (
                mapped["created_at"], mapped["kind"], mapped["description"],
                mapped["cash_amount"], mapped["card_amount"], mapped["qty"], mapped["bed_id"],
                mapped["card_id"], mapped["chip_client_number"], mapped["chip_studio_number"],
            ),
        )
        count += 1
    return count


def _import_studio_identity(conn, internet_rows):
    """Returns (psc_set, studio_number) - studio_number is whatever ends
    up configured (freshly imported, or the already-existing setting if
    this export has no INTERNET row), since _import_sales_log needs it
    to stamp historical chip-card rows as belonging to this studio."""
    psc_set = False
    if internet_rows:
        row = internet_rows[0]
        name = _text(row.get("STUDIONAME")) or "Solar Studio"
        number = int(_clamp(_num(row.get("STUDIONOMER")), 0, 255))
        pin = _text(row.get("PIN"))
        conn.execute(
            "UPDATE settings SET chip_studio_name = ?, chip_studio_number = ? WHERE id = 1",
            (name, number),
        )
        cleaned_pin = "".join(ch for ch in pin.upper() if ch in "0123456789ABCDEF")
        if len(cleaned_pin) == 6:
            conn.execute("UPDATE settings SET chip_studio_psc = ? WHERE id = 1", (cleaned_pin,))
            psc_set = True

    current_number = conn.execute("SELECT chip_studio_number FROM settings WHERE id = 1").fetchone()
    return psc_set, (current_number["chip_studio_number"] if current_number is not None else 0)


# --- entry point -------------------------------------------------------

def import_legacy_database(raw_bytes):
    """Runs the whole replace as one transaction - either everything above
    lands together, or (on any unexpected error) none of it does, so a
    half-imported database is never left behind. Returns a dict of
    per-category counts for the confirmation banner."""
    try:
        text = raw_bytes.decode(ENCODING)
    except UnicodeDecodeError as exc:
        raise LegacyImportError(
            "Файлът не изглежда да е износ от старата програма (неочаквано кодиране)."
        ) from exc

    tables = parse_export(text)
    if not tables:
        raise LegacyImportError("Във файла не бяха открити редове за внасяне (INSERT INTO).")

    conn = db.get_connection()
    try:
        with db.transaction(conn):
            known_bed_ids = {r["id"] for r in conn.execute("SELECT id FROM beds")}
            stoki_lookup = _build_stoki_lookup(tables.get("STOKI", []))
            users_n, preserved_admin_username = _import_users(conn, tables.get("PERSONAL", []))
            beds_n = _import_beds(conn, tables.get("SOLARIUM", []))
            products_n = _import_products(conn, tables.get("STOKI", []))
            chip_n, cards_n, recharge_options_n, card_ids_created = _import_clients(
                conn, tables.get("KLIENTI", []), tables.get("PLASHTANIA", []), stoki_lookup
            )
            psc_set, studio_number = _import_studio_identity(conn, tables.get("INTERNET", []))
            sales_n = _import_sales_log(
                conn, tables.get("PLASHTANIA", []), known_bed_ids, studio_number, stoki_lookup,
                card_ids_created,
            )
    finally:
        conn.close()

    return {
        "users": users_n,
        "preserved_admin_username": preserved_admin_username,
        "beds": beds_n,
        "products": products_n,
        "chip_cards": chip_n,
        "cards": cards_n,
        "recharge_options": recharge_options_n,
        "sales_log": sales_n,
        "psc_set": psc_set,
    }
