ALTER TABLE beds ADD COLUMN controller_address INTEGER
    CHECK (controller_address IS NULL OR controller_address BETWEEN 0 AND 14);

ALTER TABLE settings ADD COLUMN serial_port TEXT NOT NULL DEFAULT '/dev/ttyUSB0';
