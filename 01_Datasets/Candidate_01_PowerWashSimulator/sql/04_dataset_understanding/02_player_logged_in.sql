-- ============================================================
-- TABLE: player_logged_in
-- PURPOSE: Dataset Understanding
-- ============================================================

-- ============================================================
-- SECTION 1 : TABLE OVERVIEW
-- ============================================================

-- Total Rows
SELECT COUNT(*) AS total_rows
FROM player_logged_in;

-- Total Columns
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'player_logged_in';

-- Preview Data
SELECT *
FROM player_logged_in
LIMIT 10;

-- ============================================================
-- SECTION 2 : SCHEMA UNDERSTANDING
-- ============================================================

SELECT
    ordinal_position,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'player_logged_in'
ORDER BY ordinal_position;

-- ============================================================
-- SECTION 3 : DATA QUALITY
-- ============================================================

-- Missing PID
SELECT COUNT(*) AS missing_pid
FROM player_logged_in
WHERE pid IS NULL;

-- Missing Event Name
SELECT COUNT(*) AS missing_eventname
FROM player_logged_in
WHERE "EventName" IS NULL;

-- Missing Time
SELECT COUNT(*) AS missing_time
FROM player_logged_in
WHERE "Time" IS NULL;

-- Missing UTC Time
SELECT COUNT(*) AS missing_time_utc
FROM player_logged_in
WHERE "Time_utc" IS NULL;

-- ============================================================
-- SECTION 4 : DUPLICATE ANALYSIS
-- ============================================================

-- Duplicate Player IDs (expected)
SELECT
    COUNT(*) total_rows,
    COUNT(DISTINCT pid) unique_players
FROM player_logged_in;

-- Exact Duplicate Events
SELECT
    pid,
    "Time",
    COUNT(*)
FROM player_logged_in
GROUP BY
    pid,
    "Time"
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

SELECT
    COUNT(*) total_rows,
    COUNT(DISTINCT "EventName") unique_event_names
FROM player_logged_in;

-- ============================================================
-- SECTION 5 : TIMELINE UNDERSTANDING
-- ============================================================

SELECT
    MIN("Time") AS first_login,
    MAX("Time") AS last_login
FROM player_logged_in;


-- ============================================================
-- SECTION 6 : LOGIN EVENTS PER PLAYER
-- ============================================================

SELECT
    pid,
    COUNT(*) AS login_count
FROM player_logged_in
GROUP BY pid
ORDER BY login_count DESC
LIMIT 20;

-- ============================================================
-- SECTION 7 : LOGIN DISTRIBUTION
-- ============================================================

SELECT
    MIN(login_count),
    MAX(login_count),
    AVG(login_count)
FROM
(
    SELECT
        pid,
        COUNT(*) AS login_count
    FROM player_logged_in
    GROUP BY pid
) t;

-- ============================================================
-- SECTION 8 : RETURNING PLAYERS
-- ============================================================

SELECT
    CASE
        WHEN login_count = 1 THEN 'Single Login'
        ELSE 'Returned'
    END AS player_type,
    COUNT(*) AS players
FROM
(
    SELECT
        pid,
        COUNT(*) AS login_count
    FROM player_logged_in
    GROUP BY pid
) t
GROUP BY player_type;

-- ============================================================
-- SECTION 9 : DAILY LOGIN VOLUME
-- ============================================================

SELECT
    DATE("Time") AS login_date,
    COUNT(*) AS login_events
FROM player_logged_in
GROUP BY login_date
ORDER BY login_date;