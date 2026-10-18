-- This studio's own identity for chip cards, written onto every card
-- issued here. A chain of studios shares the same card PSC, but each
-- location has its own number - used to flag in the daily protocol when
-- a card presented here was issued by a different studio in the chain.
ALTER TABLE settings ADD COLUMN chip_studio_name TEXT NOT NULL DEFAULT 'Solar Studio';
ALTER TABLE settings ADD COLUMN chip_studio_number INTEGER NOT NULL DEFAULT 0
    CHECK (chip_studio_number BETWEEN 0 AND 255);
