PRAGMA foreign_keys = OFF;

CREATE TABLE sales_log_new (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT NOT NULL,
    kind TEXT NOT NULL CHECK (kind IN (
        'session_payment', 'product_sale', 'card_recharge',
        'card_deposit_charge', 'card_deposit_refund', 'card_balance_forfeit',
        'stock_adjustment'
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

INSERT INTO sales_log_new SELECT * FROM sales_log;

DROP TABLE sales_log;

ALTER TABLE sales_log_new RENAME TO sales_log;

CREATE INDEX idx_sales_log_created_at ON sales_log(created_at);
CREATE INDEX idx_sales_log_kind ON sales_log(kind);

PRAGMA foreign_keys = ON;
