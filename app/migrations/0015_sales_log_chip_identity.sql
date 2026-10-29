-- Lets a chip card's sales_log rows be found reliably for the print-history
-- feature. client_number alone isn't enough: each studio in a chain
-- allocates it independently (COALESCE(MAX(client_number),0)+1 scoped to
-- this studio's own chip_cards table - see sales.issue_chip_card), so two
-- different studios can easily issue a #5 to two different people. The
-- pair (chip_client_number, chip_studio_number) is what's actually stable
-- for one physical card's whole life - studio_number is stamped once at
-- issue and never rewritten by recharge/session-payment writes.
ALTER TABLE sales_log ADD COLUMN chip_client_number INTEGER;
ALTER TABLE sales_log ADD COLUMN chip_studio_number INTEGER;

CREATE INDEX idx_sales_log_chip_identity ON sales_log(chip_client_number, chip_studio_number);
