-- Services (Услуги): a second sellable category alongside cosmetics, for
-- the other things beauty studios combined with tanning typically sell
-- (haircut, manicure/pedicure, facial/derma care, massage, waxing, ...).
-- No stock_qty - unlike products, a service isn't a physical item to run
-- out of.
CREATE TABLE services (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    sale_price REAL NOT NULL CHECK (sale_price >= 0),
    active INTEGER NOT NULL DEFAULT 1 CHECK (active IN (0, 1)),
    created_at TEXT NOT NULL
);
CREATE INDEX idx_services_active ON services(active);

PRAGMA foreign_keys = OFF;

CREATE TABLE sales_log_new (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT NOT NULL,
    kind TEXT NOT NULL CHECK (kind IN (
        'session_payment', 'product_sale', 'service_sale', 'card_recharge',
        'card_deposit_charge', 'card_deposit_refund', 'card_balance_forfeit',
        'stock_adjustment', 'chip_card_cleared'
    )),
    description TEXT NOT NULL,
    cash_amount REAL NOT NULL DEFAULT 0,
    card_amount REAL NOT NULL DEFAULT 0,
    virtual_amount REAL,
    qty INTEGER,
    bed_id INTEGER REFERENCES beds(id) ON DELETE SET NULL,
    card_id INTEGER REFERENCES cards(id) ON DELETE SET NULL,
    product_id INTEGER REFERENCES products(id) ON DELETE SET NULL,
    service_id INTEGER REFERENCES services(id) ON DELETE SET NULL,
    session_id INTEGER REFERENCES sessions(id) ON DELETE SET NULL,
    recharge_option_id INTEGER REFERENCES recharge_options(id) ON DELETE SET NULL
);

INSERT INTO sales_log_new (
    id, created_at, kind, description, cash_amount, card_amount, virtual_amount,
    qty, bed_id, card_id, product_id, session_id, recharge_option_id
)
SELECT
    id, created_at, kind, description, cash_amount, card_amount, virtual_amount,
    qty, bed_id, card_id, product_id, session_id, recharge_option_id
FROM sales_log;

DROP TABLE sales_log;

ALTER TABLE sales_log_new RENAME TO sales_log;

CREATE INDEX idx_sales_log_created_at ON sales_log(created_at);
CREATE INDEX idx_sales_log_kind ON sales_log(kind);

PRAGMA foreign_keys = ON;
