-- Deleting a barcode card (sales.delete_card) is recorded in the protocol as
-- its own sales_log kind, 'card_deleted'. Like 0014, widening the kind CHECK
-- means rebuilding the table - SQLite can't alter a CHECK constraint in place.

PRAGMA foreign_keys = OFF;

CREATE TABLE sales_log_new (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT NOT NULL,
    kind TEXT NOT NULL CHECK (kind IN (
        'session_payment', 'product_sale', 'service_sale', 'card_recharge',
        'card_deposit_charge', 'card_deposit_refund', 'card_balance_forfeit',
        'stock_adjustment', 'chip_card_cleared', 'card_deleted'
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
    recharge_option_id INTEGER REFERENCES recharge_options(id) ON DELETE SET NULL,
    chip_client_number INTEGER,
    chip_studio_number INTEGER
);

INSERT INTO sales_log_new (
    id, created_at, kind, description, cash_amount, card_amount, virtual_amount,
    qty, bed_id, card_id, product_id, service_id, session_id, recharge_option_id,
    chip_client_number, chip_studio_number
)
SELECT
    id, created_at, kind, description, cash_amount, card_amount, virtual_amount,
    qty, bed_id, card_id, product_id, service_id, session_id, recharge_option_id,
    chip_client_number, chip_studio_number
FROM sales_log;

DROP TABLE sales_log;

ALTER TABLE sales_log_new RENAME TO sales_log;

CREATE INDEX idx_sales_log_created_at ON sales_log(created_at);
CREATE INDEX idx_sales_log_kind ON sales_log(kind);
CREATE INDEX idx_sales_log_chip_identity ON sales_log(chip_client_number, chip_studio_number);

PRAGMA foreign_keys = ON;
