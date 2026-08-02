/*
===========================================================
STEP 1: Create Base Player Features Table
===========================================================
*/

DROP TABLE IF EXISTS player_features;

CREATE TABLE player_features AS
SELECT
    pid,
    age,
    gender,
    country
FROM demographics;

--- VALIDATION ---
SELECT COUNT(*)
FROM player_features;

SELECT COUNT(*)
FROM demographics;

--- DUPLICATION CHECK ---
SELECT
    pid,
    COUNT(*)
FROM player_features
GROUP BY pid
HAVING COUNT(*) > 1;

--- PREVIEW ---
SELECT *
FROM player_features
LIMIT 10;


/*
===========================================================
STEP 2: Create Engagement Features
===========================================================
*/

DROP TABLE IF EXISTS engagement_features;

CREATE TABLE engagement_features AS
WITH login_gaps AS (
    SELECT
        pid,
        "Time",
        LAG("Time") OVER (
            PARTITION BY pid
            ORDER BY "Time"
        ) AS previous_login_time
    FROM player_logged_in_24h
)
SELECT
    lg.pid,

    COUNT(*) AS login_count_24h,

    GREATEST(COUNT(*) - 1, 0) AS repeat_login_count_24h,

    COUNT(DISTINCT DATE(lg."Time")) AS active_days_24h,

    AVG(
        EXTRACT(EPOCH FROM (lg."Time" - lg.previous_login_time)) / 60.0
    ) AS avg_login_gap_minutes

FROM login_gaps lg
GROUP BY lg.pid;


SELECT COUNT(*)
FROM engagement_features;

SELECT
    pid,
    COUNT(*)
FROM engagement_features
GROUP BY pid
HAVING COUNT(*) > 1;

SELECT *
FROM engagement_features
LIMIT 20;

SELECT
    MIN(login_count_24h) AS min_login_count,
    MAX(login_count_24h) AS max_login_count,
    AVG(login_count_24h) AS avg_login_count,

    MIN(repeat_login_count_24h) AS min_repeat_login,
    MAX(repeat_login_count_24h) AS max_repeat_login,

    MIN(active_days_24h) AS min_active_days,
    MAX(active_days_24h) AS max_active_days,

    MIN(avg_login_gap_minutes) AS min_gap,
    MAX(avg_login_gap_minutes) AS max_gap,
    AVG(avg_login_gap_minutes) AS avg_gap

FROM engagement_features;

SELECT
    login_count_24h,
    COUNT(*) AS players
FROM engagement_features
GROUP BY login_count_24h
ORDER BY login_count_24h;

/*
===========================================================
STEP 3: Create Exploration Features
===========================================================
*/

DROP TABLE IF EXISTS exploration_features;

CREATE TABLE exploration_features AS
SELECT
    pid,

    COUNT(*) AS jobs_started_24h,

    COUNT(DISTINCT "CurrentJobName") AS unique_jobs_started_24h,

    COUNT(*) FILTER (
        WHERE "CurrentGameMode" = 'Career'
    ) AS career_jobs_started_24h,

    COUNT(*) FILTER (
        WHERE "CurrentGameMode" = 'Special'
    ) AS special_jobs_started_24h,

    COUNT(*) FILTER (
        WHERE "CurrentGameMode" = 'FreePlay'
    ) AS freeplay_jobs_started_24h,

    COUNT(*) FILTER (
        WHERE "CurrentGameMode" = 'Challenge'
    ) AS challenge_jobs_started_24h

FROM job_started_24h
GROUP BY pid;

--- VALIDATION ---
SELECT COUNT(*)
FROM exploration_features;

--- DUPLICATE CHECK ---
SELECT
    pid,
    COUNT(*)
FROM exploration_features
GROUP BY pid
HAVING COUNT(*) > 1;

--- PREVIEW ---
SELECT *
FROM exploration_features
LIMIT 20;

--- SUMMARY STATISTICS --
SELECT
    MIN(jobs_started_24h),
    MAX(jobs_started_24h),
    AVG(jobs_started_24h),

    MIN(unique_jobs_started_24h),
    MAX(unique_jobs_started_24h),
    AVG(unique_jobs_started_24h),

    MIN(career_jobs_started_24h),
    MAX(career_jobs_started_24h),
    AVG(career_jobs_started_24h),

    MIN(special_jobs_started_24h),
    MAX(special_jobs_started_24h),
    AVG(special_jobs_started_24h)
FROM exploration_features;

--- BEHAVIOUR VALIDATION ---
SELECT *
FROM exploration_features
WHERE jobs_started_24h <>
      career_jobs_started_24h
    + special_jobs_started_24h
    + freeplay_jobs_started_24h
    + challenge_jobs_started_24h;

SELECT
    "CurrentGameMode",
    COUNT(*) AS events
FROM job_started_24h
GROUP BY "CurrentGameMode"
ORDER BY events DESC;

--- DISTRIBUTION ---
SELECT
    jobs_started_24h,
    COUNT(*) AS players
FROM exploration_features
GROUP BY jobs_started_24h
ORDER BY jobs_started_24h;

---------------------------

SELECT *
FROM job_started_24h
LIMIT 1;

SELECT
    column_name
FROM information_schema.columns
WHERE table_name = 'job_started_24h'
ORDER BY ordinal_position;

SELECT
    COUNT(*) AS total_job_starts,
    COUNT(DISTINCT "CurrentJobName") AS unique_job_names
FROM job_started_24h;


/*
===========================================================
STEP 4: Create Progression Features
===========================================================
*/

--- Job Completion Features ---

DROP TABLE IF EXISTS job_completion_features;

CREATE TABLE job_completion_features AS
SELECT
    pid,

    COUNT(*) AS jobs_completed_24h,

    COUNT(*) FILTER (
        WHERE "CurrentGameMode" = 'Career'
    ) AS career_jobs_completed_24h,

    COUNT(*) FILTER (
        WHERE "CurrentGameMode" = 'Special'
    ) AS special_jobs_completed_24h,

    COUNT(*) FILTER (
        WHERE "CurrentGameMode" = 'FreePlay'
    ) AS freeplay_jobs_completed_24h,

    COUNT(*) FILTER (
        WHERE "CurrentGameMode" = 'Challenge'
    ) AS challenge_jobs_completed_24h

FROM job_completed_24h
GROUP BY pid;

--- Task Completion Features

DROP TABLE IF EXISTS task_completion_features;

CREATE TABLE task_completion_features AS
SELECT

    pid,

    COUNT(*) AS tasks_completed_24h

FROM task_completed_24h
GROUP BY pid;

--- Subtask Completion Features ---

DROP TABLE IF EXISTS subtask_completion_features;

CREATE TABLE subtask_completion_features AS
SELECT

    pid,

    COUNT(*) AS subtasks_completed_24h

FROM subtask_completed_24h
GROUP BY pid;

--- Now Merge into one Progression table --

DROP TABLE IF EXISTS progression_features;

CREATE TABLE progression_features AS

SELECT

    p.pid,

    COALESCE(j.jobs_completed_24h,0) AS jobs_completed_24h,

    COALESCE(j.career_jobs_completed_24h,0) AS career_jobs_completed_24h,

    COALESCE(j.special_jobs_completed_24h,0) AS special_jobs_completed_24h,

    COALESCE(j.freeplay_jobs_completed_24h,0) AS freeplay_jobs_completed_24h,

    COALESCE(j.challenge_jobs_completed_24h,0) AS challenge_jobs_completed_24h,

    COALESCE(t.tasks_completed_24h,0) AS tasks_completed_24h,

    COALESCE(s.subtasks_completed_24h,0) AS subtasks_completed_24h

FROM player_features p

LEFT JOIN job_completion_features j
ON p.pid = j.pid

LEFT JOIN task_completion_features t
ON p.pid = t.pid

LEFT JOIN subtask_completion_features s
ON p.pid = s.pid;

--- VALIDATION --
SELECT COUNT(*) FROM progression_features;

--- DUPLICATION CHECK --
SELECT
    pid,
    COUNT(*)
FROM progression_features
GROUP BY pid
HAVING COUNT(*) > 1;

-- BEHAVIOUR VALIDATION CHECK --
SELECT *
FROM progression_features
WHERE jobs_completed_24h <>
      career_jobs_completed_24h
    + special_jobs_completed_24h
    + freeplay_jobs_completed_24h
    + challenge_jobs_completed_24h;

--- SUMMARY STATISTICS ---
SELECT
    MIN(jobs_completed_24h),
    MAX(jobs_completed_24h),
    AVG(jobs_completed_24h),

    MIN(tasks_completed_24h),
    MAX(tasks_completed_24h),
    AVG(tasks_completed_24h),

    MIN(subtasks_completed_24h),
    MAX(subtasks_completed_24h),
    AVG(subtasks_completed_24h)

FROM progression_features;


SELECT
    "CurrentGameMode",
    COUNT(*)
FROM job_completed_24h
GROUP BY "CurrentGameMode"
ORDER BY COUNT(*) DESC;


/*
===========================================================
STEP 5: Create Persistance Features
===========================================================
*/

DROP TABLE IF EXISTS persistence_features;

CREATE TABLE persistence_features AS
SELECT
    pid,

    COUNT(*) AS jobs_exited_24h,

    AVG("CurrentSessionLength") AS avg_session_length_exit,

    MAX("CurrentSessionLength") AS max_session_length_exit

FROM job_exited_24h
GROUP BY pid;

--- VALIDATION ---

SELECT COUNT(*) FROM persistence_features;

SELECT
    pid,
    COUNT(*)
FROM persistence_features
GROUP BY pid
HAVING COUNT(*) > 1;


/*
===========================================================
STEP 6: Create Gameplay State Features
===========================================================
*/

DROP TABLE IF EXISTS gameplay_state_features;

CREATE TABLE gameplay_state_features AS
SELECT

    pid,

    AVG("CurrentSessionLength") AS avg_session_length,

    MAX("CurrentSessionLength") AS max_session_length

FROM job_started_24h
GROUP BY pid;

--- VALIDATION ---
SELECT COUNT(*) FROM gameplay_state_features;

SELECT
    pid,
    COUNT(*)
FROM gameplay_state_features
GROUP BY pid
HAVING COUNT(*) > 1;


/*
===========================================================
STEP 8: Create Play Style Features
===========================================================
*/

DROP TABLE IF EXISTS playstyle_features;

CREATE TABLE playstyle_features AS
SELECT

    pid,

    CASE
        WHEN jobs_started_24h > 0
        THEN career_jobs_started_24h::DOUBLE PRECISION / jobs_started_24h
        ELSE 0
    END AS career_play_ratio,

    CASE
        WHEN jobs_started_24h > 0
        THEN special_jobs_started_24h::DOUBLE PRECISION / jobs_started_24h
        ELSE 0
    END AS special_play_ratio,

    CASE
        WHEN jobs_started_24h > 0
        THEN freeplay_jobs_started_24h::DOUBLE PRECISION / jobs_started_24h
        ELSE 0
    END AS freeplay_ratio,

    CASE
        WHEN jobs_started_24h > 0
        THEN challenge_jobs_started_24h::DOUBLE PRECISION / jobs_started_24h
        ELSE 0
    END AS challenge_ratio

FROM exploration_features;

--- VALIDATION ---
SELECT COUNT(*) FROM playstyle_features;

SELECT
    pid,
    COUNT(*)
FROM playstyle_features
GROUP BY pid
HAVING COUNT(*) > 1;

SELECT * FROM playstyle_features LIMIT 1;



/*
======================================================================================================================
======================================================================================================================
STEP 9: Creating Player Final Features
======================================================================================================================
======================================================================================================================
*/

DROP TABLE IF EXISTS player_features_final;

CREATE TABLE player_features_final AS

SELECT

    ------------------------------------------------------------------
    -- Player Profile
    ------------------------------------------------------------------

    p.pid,
    p.age,
    p.gender,
    p.country,

    ------------------------------------------------------------------
    -- Engagement
    ------------------------------------------------------------------

    COALESCE(e.login_count_24h,0)                 AS login_count_24h,
    COALESCE(e.repeat_login_count_24h,0)          AS repeat_login_count_24h,
    COALESCE(e.active_days_24h,0)                 AS active_days_24h,
    COALESCE(e.avg_login_gap_minutes,0)           AS avg_login_gap_minutes,

    ------------------------------------------------------------------
    -- Exploration
    ------------------------------------------------------------------

    COALESCE(ex.jobs_started_24h,0)               AS jobs_started_24h,
    COALESCE(ex.unique_jobs_started_24h,0)        AS unique_jobs_started_24h,
    COALESCE(ex.career_jobs_started_24h,0)        AS career_jobs_started_24h,
    COALESCE(ex.special_jobs_started_24h,0)       AS special_jobs_started_24h,
    COALESCE(ex.freeplay_jobs_started_24h,0)      AS freeplay_jobs_started_24h,
    COALESCE(ex.challenge_jobs_started_24h,0)     AS challenge_jobs_started_24h,

    ------------------------------------------------------------------
    -- Progression
    ------------------------------------------------------------------

    COALESCE(pr.jobs_completed_24h,0)             AS jobs_completed_24h,
    COALESCE(pr.career_jobs_completed_24h,0)      AS career_jobs_completed_24h,
    COALESCE(pr.special_jobs_completed_24h,0)     AS special_jobs_completed_24h,
    COALESCE(pr.freeplay_jobs_completed_24h,0)    AS freeplay_jobs_completed_24h,
    COALESCE(pr.challenge_jobs_completed_24h,0)   AS challenge_jobs_completed_24h,
    COALESCE(pr.tasks_completed_24h,0)            AS tasks_completed_24h,
    COALESCE(pr.subtasks_completed_24h,0)         AS subtasks_completed_24h,

    ------------------------------------------------------------------
    -- Persistence
    ------------------------------------------------------------------

    COALESCE(pe.jobs_exited_24h,0)                AS jobs_exited_24h,
    COALESCE(pe.avg_session_length_exit,0)        AS avg_session_length_exit,
    COALESCE(pe.max_session_length_exit,0)        AS max_session_length_exit,

    ------------------------------------------------------------------
    -- Gameplay State
    ------------------------------------------------------------------

    COALESCE(gs.avg_session_length,0)             AS avg_session_length,
    COALESCE(gs.max_session_length,0)             AS max_session_length,

    
    ------------------------------------------------------------------
    -- Play Style
    ------------------------------------------------------------------

    COALESCE(ps.career_play_ratio,0)              AS career_play_ratio,
    COALESCE(ps.special_play_ratio,0)             AS special_play_ratio,
    COALESCE(ps.freeplay_ratio,0)                 AS freeplay_ratio,
    COALESCE(ps.challenge_ratio,0)                AS challenge_ratio

FROM player_features p

LEFT JOIN engagement_features e
ON p.pid = e.pid

LEFT JOIN exploration_features ex
ON p.pid = ex.pid

LEFT JOIN progression_features pr
ON p.pid = pr.pid

LEFT JOIN persistence_features pe
ON p.pid = pe.pid

LEFT JOIN gameplay_state_features gs
ON p.pid = gs.pid


LEFT JOIN playstyle_features ps
ON p.pid = ps.pid;


--- VALIDATION ---

-- ROW COUNT --
SELECT COUNT(*)
FROM player_features_final;

-- DUPLICATE PLAYERS --
SELECT
    pid,
    COUNT(*)
FROM player_features_final
GROUP BY pid
HAVING COUNT(*) > 1;

-- MISSING PID --
SELECT *
FROM player_features_final
WHERE pid IS NULL;

-- MISSING VALUES --
SELECT
    COUNT(*)
FROM player_features_final
WHERE
age IS NULL
OR gender IS NULL
OR country IS NULL;

--- PREVIEW ---
SELECT *
FROM player_features_final
LIMIT 5;

SELECT COLUMN_NAME FROM information_schema."columns" WHERE TABLE_NAME = 'player_features_final' ORDER BY ordinal_position;