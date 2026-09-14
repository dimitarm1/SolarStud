CREATE TABLE beds (
    id INTEGER PRIMARY KEY,
    number TEXT NOT NULL,
    model TEXT NOT NULL,
    kind TEXT NOT NULL CHECK (kind IN ('lie', 'stand')),
    sort_order INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE sessions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    bed_id INTEGER NOT NULL REFERENCES beds(id) ON DELETE CASCADE,
    started_at TEXT NOT NULL,
    ended_at TEXT,
    total_min INTEGER NOT NULL,
    status TEXT NOT NULL DEFAULT 'running' CHECK (status IN ('running', 'stopped', 'completed'))
);

CREATE INDEX idx_sessions_bed_id ON sessions(bed_id);
CREATE INDEX idx_sessions_status ON sessions(status);

INSERT INTO beds (id, number, model, kind, sort_order) VALUES
    (1, 'No 1', 'Esprit 770', 'lie', 1),
    (2, 'No 2', 'Megasun T230', 'lie', 2),
    (3, 'No 3', 'Megasun P9S', 'lie', 3),
    (4, 'No 4', 'MS Pure 5', 'stand', 4);
