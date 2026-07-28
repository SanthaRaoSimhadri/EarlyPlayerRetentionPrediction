/*
===========================================================
File: 05_player_journey.sql

Project:
Early Player Retention Prediction using the
PowerWash Simulator Longitudinal Dataset

Purpose:
Create the observation window for each player and prepare
24-hour gameplay datasets for feature engineering.

Observation Window:
First 24 hours after each player's first login.

Output:
player_observation_window
*_24h filtered tables/views

Author:
Santha Rao Simhadri

===========================================================
*/

-- ===========================================================
-- STEP 1: Create Player Observation Window
-- ===========================================================

DROP TABLE IF EXISTS player_observation_window;

CREATE TABLE player_observation_window AS
SELECT
    pid,
    first_login,
    first_login AS observation_start,
    first_login + INTERVAL '24 hours' AS observation_end
FROM demographics;

-- ===========================================================
-- STEP 2: Validate Observation Window
-- ===========================================================

SELECT *
FROM player_observation_window
LIMIT 10;

-- VALIDATION ---

SELECT COUNT(*) AS total_players
FROM player_observation_window;

SELECT COUNT(*)
FROM demographics;

--- DUPLICATE ROW CHECK ---
SELECT
    pid,
    COUNT(*)
FROM player_observation_window
GROUP BY pid
HAVING COUNT(*) > 1;

-- ===========================================================
-- STEP 3: Filter Player Login Events (First 24 Hours)
-- ===========================================================

DROP TABLE IF EXISTS player_logged_in_24h;

CREATE TABLE player_logged_in_24h AS
SELECT
    p.*
FROM player_logged_in p
INNER JOIN player_observation_window w
    ON p.pid = w.pid
WHERE
    p."Time" >= w.observation_start
    AND p."Time" < w.observation_end;

--- VALIDATION ---

SELECT COUNT(*)
FROM player_logged_in_24h;

SELECT COUNT(DISTINCT pid)
FROM player_logged_in_24h;

--- BOUNDARY CHECK ---
SELECT *
FROM player_logged_in_24h l
JOIN player_observation_window w
    ON l.pid = w.pid
WHERE
    l."Time" < w.observation_start
    OR l."Time" >= w.observation_end;


-- ===========================================================
-- STEP 4: Filter Job Started Events (First 24 Hours)
-- ===========================================================

DROP TABLE IF EXISTS job_started_24h;

CREATE TABLE job_started_24h AS
SELECT
    p.*
FROM job_started p
INNER JOIN player_observation_window w
    ON p.pid = w.pid
WHERE
    p."Time" >= w.observation_start
    AND p."Time" < w.observation_end;

-- ===========================================================
-- STEP 5: Filter Job Completed Events (First 24 Hours)
-- ===========================================================

DROP TABLE IF EXISTS job_completed_24h;

CREATE TABLE job_completed_24h AS
SELECT
    p.*
FROM job_completed p
INNER JOIN player_observation_window w
    ON p.pid = w.pid
WHERE
    p."Time" >= w.observation_start
    AND p."Time" < w.observation_end;

-- ===========================================================
-- STEP 6: Filter Task Completed Events (First 24 Hours)
-- ===========================================================

DROP TABLE IF EXISTS task_completed_24h;

CREATE TABLE task_completed_24h AS
SELECT
    p.*
FROM task_completed p
INNER JOIN player_observation_window w
    ON p.pid = w.pid
WHERE
    p."Time" >= w.observation_start
    AND p."Time" < w.observation_end;

-- ===========================================================
-- STEP 7: Filter Subtask Completed Events (First 24 Hours)
-- ===========================================================

DROP TABLE IF EXISTS subtask_completed_24h;

CREATE TABLE subtask_completed_24h AS
SELECT
    p.*
FROM subtask_completed p
INNER JOIN player_observation_window w
    ON p.pid = w.pid
WHERE
    p."Time" >= w.observation_start
    AND p."Time" < w.observation_end;

-- ===========================================================
-- STEP 8: Filter Item Purchased Events (First 24 Hours)
-- ===========================================================

DROP TABLE IF EXISTS item_purchased_24h;

CREATE TABLE item_purchased_24h AS
SELECT
    p.*
FROM item_purchased p
INNER JOIN player_observation_window w
    ON p.pid = w.pid
WHERE
    p."Time" >= w.observation_start
    AND p."Time" < w.observation_end;


-- ===========================================================
-- STEP 9: Filter Job Exited Events (First 24 Hours)
-- ===========================================================

DROP TABLE IF EXISTS job_exited_24h;

CREATE TABLE job_exited_24h AS
SELECT
    p.*
FROM job_exited p
INNER JOIN player_observation_window w
    ON p.pid = w.pid
WHERE
    p."Time" >= w.observation_start
    AND p."Time" < w.observation_end;

-- ===========================================================
-- STEP 10: Filter Exited Game Events (First 24 Hours)
-- ===========================================================

DROP TABLE IF EXISTS exited_game_24h;

CREATE TABLE exited_game_24h AS
SELECT
    p.*
FROM exited_game p
INNER JOIN player_observation_window w
    ON p.pid = w.pid
WHERE
    p."Time" >= w.observation_start
    AND p."Time" < w.observation_end;

-- ===========================================================
-- STEP 11: Filter Game Saved Events (First 24 Hours)
-- ===========================================================

DROP TABLE IF EXISTS game_saved_24h;

CREATE TABLE game_saved_24h AS
SELECT
    p.*
FROM game_saved p
INNER JOIN player_observation_window w
    ON p.pid = w.pid
WHERE
    p."Time" >= w.observation_start
    AND p."Time" < w.observation_end;

-- ===========================================================
-- STEP 12: Filter Updated Current State Events (First 24 Hours)
-- ===========================================================

DROP TABLE IF EXISTS update_current_state_24h;

CREATE TABLE update_current_state_24h AS
SELECT
    p.*
FROM update_current_state p
INNER JOIN player_observation_window w
    ON p.pid = w.pid
WHERE
    p."Time" >= w.observation_start
    AND p."Time" < w.observation_end;


-- ===========================================================
-- VALIDATION
-- ===========================================================

SELECT 'player_logged_in_24h' AS table_name,
       COUNT(*) AS events,
       COUNT(DISTINCT pid) AS players
FROM player_logged_in_24h

UNION ALL

SELECT 'job_started_24h',
       COUNT(*),
       COUNT(DISTINCT pid)
FROM job_started_24h

UNION ALL

SELECT 'job_completed_24h',
       COUNT(*),
       COUNT(DISTINCT pid)
FROM job_completed_24h

UNION ALL

SELECT 'task_completed_24h',
       COUNT(*),
       COUNT(DISTINCT pid)
FROM task_completed_24h

UNION ALL

SELECT 'subtask_completed_24h',
       COUNT(*),
       COUNT(DISTINCT pid)
FROM subtask_completed_24h

UNION ALL

SELECT 'item_purchased_24h',
       COUNT(*),
       COUNT(DISTINCT pid)
FROM item_purchased_24h

UNION ALL

SELECT 'job_exited_24h',
       COUNT(*),
       COUNT(DISTINCT pid)
FROM job_exited_24h

UNION ALL

SELECT 'exited_game_24h',
       COUNT(*),
       COUNT(DISTINCT pid)
FROM exited_game_24h

UNION ALL

SELECT 'game_saved_24h',
       COUNT(*),
       COUNT(DISTINCT pid)
FROM game_saved_24h

UNION ALL

SELECT 'update_current_state_24h',
       COUNT(*),
       COUNT(DISTINCT pid)
FROM update_current_state_24h

;
