-- ============================================================
-- TABLE OVERVIEW
-- ============================================================

SELECT COUNT(*) AS total_rows
FROM job_started;

SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'job_started';

SELECT column_name FROM information_schema.columns WHERE TABLE_NAME = 'job_started';

SELECT *
FROM job_started
LIMIT 10;

-- Missig values
SELECT
    COUNT(*) AS total_rows,

    COUNT(*) - COUNT(pid) AS missing_pid,
    COUNT(*) - COUNT(job_started."Time") AS missing_time,
    COUNT(*) - COUNT(job_started."CurrentJobName") AS missing_jobname

FROM job_started;

--Duplicate events
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT (pid, job_started."Time", job_started."CurrentJobName")) AS distinct_events
FROM job_started;

-- Data quality (Time stamp)
SELECT
    MIN(job_started."Time") AS first_job_started,
    MAX(job_started."Time") AS last_job_started
FROM job_started;

SELECT
    pid,
    job_started."Time",
    job_started."CurrentJobName",
    COUNT(*) AS occurrences
FROM job_started
GROUP BY pid, job_started."Time", job_started."CurrentJobName"
HAVING COUNT(*) > 1;



-- ============================================================
-- SCHEMA
-- ============================================================

SELECT
    ordinal_position,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name='job_started'
ORDER BY ordinal_position;

-- ============================================================
-- DATA QUALITY
-- ============================================================

SELECT COUNT(*) AS missing_pid
FROM job_started
WHERE pid IS NULL;

SELECT COUNT(*) AS missing_job
FROM job_started
WHERE "CurrentJobName" IS NULL;

SELECT COUNT(*) AS missing_mode
FROM job_started
WHERE "CurrentGameMode" IS NULL;

SELECT COUNT(*) AS missing_session
FROM job_started
WHERE "CurrentSessionLength" IS NULL;

SELECT COUNT(*) AS missing_time
FROM job_started
WHERE "Time" IS NULL;

-- ============================================================
-- DUPLICATES
-- ============================================================

SELECT
    COUNT(*) total_rows,
    COUNT(DISTINCT pid) unique_players
FROM job_started;

SELECT
    pid,
    "Time",
    COUNT(*)
FROM job_started
GROUP BY
    pid,
    "Time"
HAVING COUNT(*)>1;

SELECT *
FROM job_started
WHERE pid = 'p5884';

-- ============================================================
-- TIMELINE
-- ============================================================

SELECT
    MIN("Time") first_job_started,
    MAX("Time") last_job_started
FROM job_started;

-- ============================================================
-- JOBS PER PLAYER
-- ============================================================

SELECT
    pid,
    COUNT(*) AS jobs_started
FROM job_started
GROUP BY pid
ORDER BY jobs_started DESC
LIMIT 20;

SELECT
    pid,
    COUNT(*) AS jobs_started
FROM job_started
GROUP BY pid
ORDER BY jobs_started ASC
LIMIT 20;

-- ============================================================
-- MOST STARTED JOBS
-- ============================================================

SELECT
    "CurrentJobName",
    COUNT(*) AS frequency
FROM job_started
GROUP BY "CurrentJobName"
ORDER BY frequency DESC;

-- ============================================================
-- GAME MODES
-- ============================================================

SELECT
    "CurrentGameMode",
    COUNT(*) AS frequency
FROM job_started
GROUP BY "CurrentGameMode"
ORDER BY frequency DESC;

-- ============================================================
-- SESSION LENGTH
-- ============================================================

SELECT
    MIN("CurrentSessionLength"),
    MAX("CurrentSessionLength"),
    AVG("CurrentSessionLength")
FROM job_started;

-- ============================================================
-- PREVIOUS COMPLETED JOB
-- ============================================================

SELECT
    "LastJobCompleted",
    COUNT(*)
FROM job_started
GROUP BY "LastJobCompleted"
ORDER BY COUNT(*) DESC
LIMIT 20;

SELECT DISTINCT ON (pid)
       pid,
       "CurrentJobName",
       "Time"
FROM job_started
ORDER BY
       pid,
       "Time";