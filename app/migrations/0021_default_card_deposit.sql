-- A configurable default for the cash deposit charged when issuing or
-- replacing a barcode card (sales.issue_card/replace_card, cards.html,
-- card_detail.html) - previously always pre-filled as a flat 0, which
-- meant whatever the studio actually charges had to be re-typed by hand
-- on every single card issued.
ALTER TABLE settings ADD COLUMN default_card_deposit REAL NOT NULL DEFAULT 0
    CHECK (default_card_deposit >= 0);
