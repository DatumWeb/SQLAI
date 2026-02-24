-- Sample Data for BaliTricks Database

-- Insert Knives
INSERT INTO knife (name, brand, date_purchased, pivot_type, blade_length, weight, last_maintained_date, condition) VALUES
('Squid Trainer', 'Squid Industries', '2023-01-15', 'bearings', 4.2, 4.5, '2024-05-01', 'good'),
('BRS Replicant', 'BRS', '2023-03-20', 'bearings', 4.5, 4.8, '2024-04-15', 'good'),
('Kershaw Lucha', 'Kershaw', '2023-06-10', 'washer', 4.3, 5.2, '2024-05-10', 'new'),
('Glidr Arctic', 'Glidr', '2023-08-05', 'bearings', 4.0, 4.3, '2024-04-20', 'good'),
('BRS Alpha Beast', 'BRS', '2023-11-12', 'bearings', 4.6, 5.0, '2024-03-30', 'worn'),
('Squid Krake Raken', 'Squid Industries', '2024-01-08', 'bearings', 4.3, 4.6, '2024-05-05', 'good'),
('Maxace Serpent Striker', 'Maxace', '2023-09-25', 'bearings', 4.4, 4.9, '2024-04-10', 'good');

-- Insert Tricks
INSERT INTO trick (name, difficulty, category, description) VALUES
('Basic Open', 1, 'rollover', 'The fundamental opening move'),
('Y2K', 2, 'rollover', 'A basic rollover trick'),
('Zen Rollover', 2, 'rollover', 'Smooth rollover technique'),
('Behind the 8 Ball', 3, 'rollover', 'Advanced rollover variation'),
('Helix', 3, 'rollover', 'Complex rollover combo'),
('Aerial', 2, 'aerial', 'Basic aerial flip'),
('Ladder', 3, 'aerial', 'Multiple aerial flips in sequence'),
('Choker Fan', 4, 'aerial', 'Advanced aerial fanning technique'),
('Scissor', 3, 'combo', 'Combination of rollover and aerial'),
('Twirl', 2, 'transition', 'Smooth transition move'),
('Chaplin', 3, 'transition', 'Continuous spinning motion'),
('Index Rollover', 2, 'rollover', 'Rollover using index finger'),
('Thumb Rollover', 2, 'rollover', 'Rollover using thumb'),
('Fan', 3, 'aerial', 'Fanning motion with the knife'),
('Ice Pick Aerial', 3, 'aerial', 'Aerial from ice pick grip'),
('Shortstop', 4, 'combo', 'Complex combination trick'),
('Scissor to Aerial', 4, 'combo', 'Scissor followed by aerial'),
('Zen Rollover to Choker', 4, 'combo', 'Advanced combo move');

-- Insert Practice Sessions
INSERT INTO practice_session (session_date, duration_minutes, notes) VALUES
('2024-05-01', 45, 'Focused on rollovers'),
('2024-05-03', 60, 'Worked on aerials'),
('2024-05-05', 30, 'Quick session, practiced transitions'),
('2024-05-07', 90, 'Long session, worked on combos'),
('2024-05-09', 45, 'Practiced with Squid Trainer'),
('2024-05-11', 60, 'Focused on mastering Y2K'),
('2024-05-13', 75, 'Worked on Helix trick'),
('2024-05-15', 50, 'Practiced aerials'),
('2024-05-17', 40, 'Quick practice session'),
('2024-05-19', 90, 'Long session working on combos'),
('2024-05-21', 55, 'Focused on transitions'),
('2024-05-23', 45, 'Practiced with BRS Replicant');

-- Insert Trick Progress (which tricks have been learned with which knives)
INSERT INTO trick_progress (knife_id, trick_id, date_first_learned, date_last_practiced, mastered, confidence_level) VALUES
(1, 1, '2023-02-01', '2024-05-19', 1, 10), -- Basic Open with Squid Trainer
(1, 2, '2023-02-15', '2024-05-19', 1, 9),  -- Y2K with Squid Trainer
(1, 3, '2023-03-10', '2024-05-17', 1, 8),  -- Zen Rollover
(1, 6, '2023-04-05', '2024-05-15', 1, 7),  -- Aerial
(1, 10, '2023-05-01', '2024-05-21', 1, 8), -- Twirl
(2, 1, '2023-04-01', '2024-05-19', 1, 10), -- Basic Open with BRS Replicant
(2, 2, '2023-04-10', '2024-05-19', 1, 9),  -- Y2K
(2, 4, '2023-06-15', '2024-05-13', 0, 6),  -- Behind the 8 Ball
(2, 7, '2023-07-20', '2024-05-15', 0, 5),  -- Ladder
(2, 11, '2023-08-10', '2024-05-21', 1, 7), -- Chaplin
(3, 1, '2023-07-01', '2024-05-19', 1, 9),  -- Basic Open with Kershaw Lucha
(3, 2, '2023-07-15', '2024-05-19', 1, 8),  -- Y2K
(3, 12, '2023-08-01', '2024-05-17', 1, 7), -- Index Rollover
(4, 1, '2023-09-01', '2024-05-19', 1, 10), -- Basic Open with Glidr Arctic
(4, 3, '2023-09-20', '2024-05-17', 1, 8),  -- Zen Rollover
(4, 6, '2023-10-05', '2024-05-15', 1, 7),  -- Aerial
(4, 14, '2023-11-10', '2024-05-15', 0, 6), -- Fan
(5, 1, '2023-12-01', '2024-05-19', 1, 9),  -- Basic Open with Alpha Beast
(5, 5, '2024-01-15', '2024-05-13', 0, 5),  -- Helix
(5, 9, '2024-02-01', '2024-05-07', 0, 4),  -- Scissor
(6, 1, '2024-01-15', '2024-05-19', 1, 10), -- Basic Open with Krake Raken
(6, 2, '2024-01-25', '2024-05-19', 1, 9),  -- Y2K
(6, 3, '2024-02-10', '2024-05-17', 1, 8),  -- Zen Rollover
(6, 6, '2024-02-20', '2024-05-15', 1, 7),  -- Aerial
(7, 1, '2023-10-01', '2024-05-19', 1, 9),  -- Basic Open with Maxace
(7, 4, '2023-11-15', '2024-05-13', 0, 6),  -- Behind the 8 Ball
(7, 7, '2023-12-01', '2024-05-15', 0, 5);  -- Ladder

-- Insert Session Tricks (which tricks were practiced in which sessions)
INSERT INTO session_tricks (session_id, trick_id, attempts, success_rate) VALUES
(1, 1, 50, 0.98),  -- Basic Open in session 1
(1, 2, 40, 0.90),  -- Y2K
(1, 3, 30, 0.85),  -- Zen Rollover
(2, 6, 60, 0.75),  -- Aerial in session 2
(2, 7, 45, 0.60),  -- Ladder
(2, 14, 35, 0.55), -- Fan
(3, 10, 50, 0.88), -- Twirl in session 3
(3, 11, 40, 0.80), -- Chaplin
(4, 9, 55, 0.65),  -- Scissor in session 4
(4, 15, 50, 0.70), -- Ice Pick Aerial
(4, 16, 40, 0.50), -- Shortstop
(5, 1, 60, 0.95),  -- Basic Open in session 5
(5, 2, 50, 0.92),  -- Y2K
(6, 2, 80, 0.88),  -- Y2K focused practice in session 6
(7, 5, 70, 0.55),  -- Helix in session 7
(7, 4, 60, 0.70),  -- Behind the 8 Ball
(8, 6, 65, 0.78),  -- Aerial in session 8
(8, 7, 55, 0.62),  -- Ladder
(8, 15, 45, 0.68), -- Ice Pick Aerial
(9, 1, 40, 0.97),  -- Basic Open in session 9
(9, 3, 35, 0.86),  -- Zen Rollover
(10, 9, 60, 0.68), -- Scissor in session 10
(10, 17, 50, 0.55), -- Scissor to Aerial
(10, 16, 45, 0.52), -- Shortstop
(11, 10, 55, 0.90), -- Twirl in session 11
(11, 11, 50, 0.82), -- Chaplin
(12, 1, 50, 0.96), -- Basic Open in session 12
(12, 2, 45, 0.91), -- Y2K
(12, 3, 40, 0.87); -- Zen Rollover

-- Insert Maintenance Events
INSERT INTO maintenance_event (knife_id, maintenance_date, maintenance_type, notes) VALUES
(1, '2024-05-01', 'cleaning', 'Cleaned pivot area and blade'),
(2, '2024-04-15', 'oiling', 'Applied pivot oil'),
(2, '2024-03-10', 'tuning', 'Adjusted pivot tension'),
(3, '2024-05-10', 'cleaning', 'First maintenance, cleaned thoroughly'),
(4, '2024-04-20', 'oiling', 'Routine pivot maintenance'),
(5, '2024-03-30', 'tuning', 'Tightened loose pivot'),
(5, '2024-02-15', 'cleaning', 'Deep clean due to wear'),
(6, '2024-05-05', 'oiling', 'Regular maintenance'),
(7, '2024-04-10', 'cleaning', 'Cleaned and oiled'),
(1, '2024-03-20', 'oiling', 'Routine pivot oil application'),
(2, '2024-02-05', 'cleaning', 'Full cleaning and inspection'),
(4, '2024-03-15', 'tuning', 'Adjusted handle play');
