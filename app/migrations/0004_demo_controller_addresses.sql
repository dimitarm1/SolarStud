PRAGMA foreign_keys = OFF;

CREATE TABLE beds_new (
    id INTEGER PRIMARY KEY,
    number TEXT NOT NULL,
    model TEXT NOT NULL,
    kind TEXT NOT NULL CHECK (kind IN ('lie', 'stand')),
    sort_order INTEGER NOT NULL DEFAULT 0,
    prep_min INTEGER NOT NULL DEFAULT 0 CHECK (prep_min BETWEEN 0 AND 9),
    cool_min INTEGER NOT NULL DEFAULT 0 CHECK (cool_min BETWEEN 0 AND 5),
    picture_path TEXT NOT NULL DEFAULT '',
    controller_address INTEGER
        CHECK (controller_address IS NULL
               OR controller_address BETWEEN 0 AND 14
               OR controller_address BETWEEN 16 AND 32)
);

INSERT INTO beds_new (id, number, model, kind, sort_order, prep_min, cool_min, picture_path, controller_address)
SELECT id, number, model, kind, sort_order, prep_min, cool_min, picture_path, controller_address FROM beds;

DROP TABLE beds;

ALTER TABLE beds_new RENAME TO beds;

PRAGMA foreign_keys = ON;
