ALTER TABLE beds ADD COLUMN price_per_min REAL NOT NULL DEFAULT 0 CHECK (price_per_min >= 0);

ALTER TABLE sessions ADD COLUMN cash_amount REAL NOT NULL DEFAULT 0 CHECK (cash_amount >= 0);
ALTER TABLE sessions ADD COLUMN card_amount REAL NOT NULL DEFAULT 0 CHECK (card_amount >= 0);
ALTER TABLE sessions ADD COLUMN card_id INTEGER REFERENCES cards(id) ON DELETE SET NULL;

CREATE TABLE recharge_options (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    virtual_amount REAL NOT NULL CHECK (virtual_amount > 0),
    cash_price REAL NOT NULL CHECK (cash_price >= 0),
    active INTEGER NOT NULL DEFAULT 1 CHECK (active IN (0, 1)),
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at TEXT NOT NULL
);

CREATE INDEX idx_recharge_options_active ON recharge_options(active, sort_order);

-- No row for a (recharge_option_id, bed_id) pair means "use beds.price_per_min".
CREATE TABLE recharge_option_bed_prices (
    recharge_option_id INTEGER NOT NULL REFERENCES recharge_options(id) ON DELETE CASCADE,
    bed_id INTEGER NOT NULL REFERENCES beds(id) ON DELETE CASCADE,
    price_per_min REAL NOT NULL CHECK (price_per_min >= 0),
    PRIMARY KEY (recharge_option_id, bed_id)
);

CREATE TABLE cards (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    card_number TEXT,
    deposit_amount REAL NOT NULL DEFAULT 0 CHECK (deposit_amount >= 0),
    status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'returned')),
    created_at TEXT NOT NULL,
    returned_at TEXT
);

CREATE UNIQUE INDEX idx_cards_card_number ON cards(card_number)
    WHERE card_number IS NOT NULL AND card_number <> '';
CREATE INDEX idx_cards_status ON cards(status);

-- virtual_amount/cash_price are snapshotted from the recharge_option at
-- creation time, so later edits to options never rewrite history.
CREATE TABLE card_lots (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    card_id INTEGER NOT NULL REFERENCES cards(id) ON DELETE CASCADE,
    recharge_option_id INTEGER REFERENCES recharge_options(id) ON DELETE SET NULL,
    virtual_amount REAL NOT NULL CHECK (virtual_amount > 0),
    remaining_amount REAL NOT NULL CHECK (remaining_amount >= 0),
    cash_price REAL NOT NULL CHECK (cash_price >= 0),
    created_at TEXT NOT NULL
);

-- FIFO order within a card = ascending id.
CREATE INDEX idx_card_lots_card_id ON card_lots(card_id, id);

CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    sale_price REAL NOT NULL CHECK (sale_price >= 0),
    stock_qty INTEGER NOT NULL DEFAULT 0 CHECK (stock_qty >= 0),
    active INTEGER NOT NULL DEFAULT 1 CHECK (active IN (0, 1)),
    created_at TEXT NOT NULL
);

CREATE INDEX idx_products_active ON products(active);

-- One append-only row per monetary event. cash_amount/card_amount are
-- positive when money comes IN, negative for card_deposit_refund /
-- card_balance_forfeit (money or value going back out / written off).
CREATE TABLE sales_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT NOT NULL,
    kind TEXT NOT NULL CHECK (kind IN (
        'session_payment', 'product_sale', 'card_recharge',
        'card_deposit_charge', 'card_deposit_refund', 'card_balance_forfeit'
    )),
    description TEXT NOT NULL,
    cash_amount REAL NOT NULL DEFAULT 0,
    card_amount REAL NOT NULL DEFAULT 0,
    virtual_amount REAL,
    qty INTEGER,
    bed_id INTEGER REFERENCES beds(id) ON DELETE SET NULL,
    card_id INTEGER REFERENCES cards(id) ON DELETE SET NULL,
    product_id INTEGER REFERENCES products(id) ON DELETE SET NULL,
    session_id INTEGER REFERENCES sessions(id) ON DELETE SET NULL,
    recharge_option_id INTEGER REFERENCES recharge_options(id) ON DELETE SET NULL
);

CREATE INDEX idx_sales_log_created_at ON sales_log(created_at);
CREATE INDEX idx_sales_log_kind ON sales_log(kind);
