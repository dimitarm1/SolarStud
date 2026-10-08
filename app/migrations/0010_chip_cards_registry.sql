-- A chip card's balance lives on the physical card itself (see
-- chipcard.py), never in this database. This table is just a lightweight
-- registry so staff can find a chip card by name/phone, so a new card
-- gets a client/card number that doesn't collide with one already
-- issued, and so a deposit can be tracked for later return - mirroring
-- what the `cards`/`card_lots` tables do for virtual cards, minus any
-- balance column.
CREATE TABLE chip_cards (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_number INTEGER NOT NULL UNIQUE,
    card_number INTEGER,
    name TEXT NOT NULL DEFAULT '',
    phone TEXT NOT NULL DEFAULT '',
    deposit_amount REAL NOT NULL DEFAULT 0 CHECK (deposit_amount >= 0),
    status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'returned')),
    created_at TEXT NOT NULL,
    returned_at TEXT
);

CREATE INDEX idx_chip_cards_status ON chip_cards(status);
CREATE INDEX idx_chip_cards_name ON chip_cards(name);
