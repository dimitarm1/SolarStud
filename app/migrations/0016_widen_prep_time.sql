-- Widens prep_min's CHECK bound to match models.MAX_PREP_MINUTES (raised
-- from 9 to 20) - the Python-side constant alone wasn't enough, since
-- SQLite enforces this independently at the table level and requires a
-- full rebuild to change a CHECK constraint (ALTER TABLE can't do it
-- in place). Full current beds schema carried forward unchanged
-- otherwise (0005_shrink_demo_addresses.sql's rebuild + 0006_sales_pos.sql's
-- later ALTER TABLE ADD COLUMN price_per_min).
PRAGMA foreign_keys = OFF;

CREATE TABLE beds_new (
    id INTEGER PRIMARY KEY,
    number TEXT NOT NULL,
    model TEXT NOT NULL,
    kind TEXT NOT NULL CHECK (kind IN ('lie', 'stand')),
    sort_order INTEGER NOT NULL DEFAULT 0,
    prep_min INTEGER NOT NULL DEFAULT 0 CHECK (prep_min BETWEEN 0 AND 20),
    cool_min INTEGER NOT NULL DEFAULT 0 CHECK (cool_min BETWEEN 0 AND 5),
    picture_path TEXT NOT NULL DEFAULT '',
    controller_address INTEGER
        CHECK (controller_address IS NULL
               OR controller_address BETWEEN 0 AND 14
               OR controller_address BETWEEN 16 AND 21),
    price_per_min REAL NOT NULL DEFAULT 0 CHECK (price_per_min >= 0)
);

INSERT INTO beds_new (id, number, model, kind, sort_order, prep_min, cool_min,
                       picture_path, controller_address, price_per_min)
SELECT id, number, model, kind, sort_order, prep_min, cool_min,
       picture_path, controller_address, price_per_min
FROM beds;

DROP TABLE beds;

ALTER TABLE beds_new RENAME TO beds;

PRAGMA foreign_keys = ON;
