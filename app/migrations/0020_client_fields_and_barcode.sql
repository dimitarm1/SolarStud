-- Cosmetics barcode (scan-to-add at checkout - app.py/main.js initPosBasket).
ALTER TABLE products ADD COLUMN barcode TEXT;
CREATE UNIQUE INDEX idx_products_barcode ON products(barcode)
    WHERE barcode IS NOT NULL AND barcode <> '';

-- Client note/email/birthdate for both parallel card mechanisms (sales.py:
-- update_card_details / update_chip_card_details). birthdate is 'MM-DD' or
-- 'YYYY-MM-DD' free text, NULL/'' meaning unset - never validated beyond
-- that, since a client's exact birth year is often not something staff
-- actually ask for.
ALTER TABLE cards ADD COLUMN note TEXT NOT NULL DEFAULT '';
ALTER TABLE cards ADD COLUMN email TEXT NOT NULL DEFAULT '';
ALTER TABLE cards ADD COLUMN birthdate TEXT NOT NULL DEFAULT '';

ALTER TABLE chip_cards ADD COLUMN note TEXT NOT NULL DEFAULT '';
ALTER TABLE chip_cards ADD COLUMN email TEXT NOT NULL DEFAULT '';
ALTER TABLE chip_cards ADD COLUMN birthdate TEXT NOT NULL DEFAULT '';
