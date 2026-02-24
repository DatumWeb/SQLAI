-- =========================
-- KNIFE TABLE
-- =========================
CREATE TABLE knife (
    knife_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    date_purchased DATE,
    pivot_type VARCHAR(20), -- washer or bearings
    blade_length DOUBLE,
    weight DOUBLE,
    last_maintained_date DATE,
    condition VARCHAR(20) -- new, good, worn
);

-- =========================
-- TRICK TABLE
-- =========================
CREATE TABLE trick (
    trick_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) NOT NULL,
    difficulty INTEGER, -- 1-5 scale
    category VARCHAR(30), -- rollover, aerial, combo, transition
    description TEXT
);

-- =========================
-- PRACTICE SESSION TABLE
-- =========================
CREATE TABLE practice_session (
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    session_date DATE NOT NULL,
    duration_minutes INTEGER,
    notes TEXT
);

-- =========================
-- TRICK PROGRESS (MANY-TO-MANY)
-- =========================
CREATE TABLE trick_progress (
    knife_id INTEGER,
    trick_id INTEGER,
    date_first_learned DATE,
    date_last_practiced DATE,
    mastered BOOLEAN,
    confidence_level INTEGER, -- 1-10 scale
    PRIMARY KEY (knife_id, trick_id),
    FOREIGN KEY (knife_id) REFERENCES knife(knife_id),
    FOREIGN KEY (trick_id) REFERENCES trick(trick_id)
);

-- =========================
-- SESSION TRICKS (OPTIONAL BUT POWERFUL)
-- =========================
CREATE TABLE session_tricks (
    session_id INTEGER,
    trick_id INTEGER,
    attempts INTEGER,
    success_rate DOUBLE,
    PRIMARY KEY (session_id, trick_id),
    FOREIGN KEY (session_id) REFERENCES practice_session(session_id),
    FOREIGN KEY (trick_id) REFERENCES trick(trick_id)
);

-- =========================
-- MAINTENANCE EVENTS
-- =========================
CREATE TABLE maintenance_event (
    maintenance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    knife_id INTEGER,
    maintenance_date DATE,
    maintenance_type VARCHAR(30), -- cleaning, oiling, tuning
    notes TEXT,
    FOREIGN KEY (knife_id) REFERENCES knife(knife_id)
);
