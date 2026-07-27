-- ============================================================
-- TABLE OVERVIEW
-- ============================================================

SELECT COUNT(*) AS total_rows
FROM job_completed;

SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'job_completed';

SELECT *
FROM job_completed
LIMIT 10;

-- Missig values
SELECT
    COUNT(*) AS total_rows,

    COUNT(*) - COUNT(pid) AS missing_pid,
    COUNT(*) - COUNT(job_completed."Time") AS missing_time,
    COUNT(*) - COUNT(job_completed."LastJobCompleted") AS missing_jobname

FROM job_completed;

--Duplicate events
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT (pid, job_completed."Time", job_completed."LastJobCompleted")) AS distinct_events
FROM job_completed;

-- Data quality (Time stamp)
SELECT
    MIN(job_completed."Time") AS first_job_started,
    MAX(job_completed."Time") AS last_job_started
FROM job_completed;

SELECT
    pid,
    job_completed."Time",
    job_completed."LastJobCompleted",
    COUNT(*) AS occurrences
FROM job_completed
GROUP BY pid, job_completed."Time", job_completed."LastJobCompleted"
HAVING COUNT(*) > 1;

SELECT
    pid,
    job_completed."Time",
    job_completed."LastJobCompleted",
    job_completed."LastTaskCompleted",
    job_completed."LastSubtaskCompleted",
    COUNT(*) AS occurrences
FROM job_completed
GROUP BY pid, job_completed."Time", job_completed."LastJobCompleted", job_completed."LastTaskCompleted", job_completed."LastSubtaskCompleted"
HAVING COUNT(*) > 1
ORDER BY occurrences DESC
LIMIT 50;

CREATE TABLE job_completed_clean AS
SELECT DISTINCT *
FROM job_completed;

SELECT COUNT(*) AS total_rows
FROM job_completed_clean;
-- ============================================================
-- SCHEMA
-- ============================================================

SELECT
    ordinal_position,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name='job_completed'
ORDER BY ordinal_position;

-- ============================================================
-- DATA QUALITY
-- ============================================================

SELECT COUNT(*) AS missing_pid
FROM job_completed
WHERE pid IS NULL;

SELECT COUNT(*) AS missing_job_completed
FROM job_completed
WHERE "LastJobCompleted" IS NULL;

SELECT COUNT(*) AS missing_game_mode
FROM job_completed
WHERE "CurrentGameMode" IS NULL;

SELECT COUNT(*) AS missing_time
FROM job_completed
WHERE "Time" IS NULL;

SELECT COUNT(*) AS missing_campaign_progress
FROM job_completed
WHERE "CampaignProgressionAmount" IS NULL;

-- ============================================================
-- DUPLICATE ANALYSIS
-- ============================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT pid) AS unique_players
FROM job_completed;

SELECT
    pid,
    "Time",
    COUNT(*)
FROM job_completed
GROUP BY
    pid,
    "Time"
HAVING COUNT(*) > 1;

-- ============================================================
-- TIMELINE
-- ============================================================

SELECT
    MIN("Time") AS first_job_completed,
    MAX("Time") AS last_job_completed
FROM job_completed;

-- ============================================================
-- JOBS COMPLETED PER PLAYER
-- ============================================================

SELECT
    pid,
    COUNT(*) AS jobs_completed
FROM job_completed
GROUP BY pid
ORDER BY jobs_completed DESC
LIMIT 20;

-- ============================================================
-- MOST COMPLETED JOBS
-- ============================================================

SELECT
    "LastJobCompleted",
    COUNT(*) AS completion_count
FROM job_completed
GROUP BY "LastJobCompleted"
ORDER BY completion_count DESC;

-- ============================================================
-- GAME MODES
-- ============================================================

SELECT
    "CurrentGameMode",
    COUNT(*) AS completion_events
FROM job_completed
GROUP BY "CurrentGameMode"
ORDER BY completion_events DESC;

-- ============================================================
-- CAMPAIGN PROGRESSION
-- ============================================================

SELECT
    MIN("CampaignProgressionAmount"),
    MAX("CampaignProgressionAmount"),
    AVG("CampaignProgressionAmount")
FROM job_completed;

SELECT
    "LastJobCompleted",
    COUNT(*) AS completed_count
FROM job_completed
GROUP BY "LastJobCompleted"
ORDER BY completed_count DESC
LIMIT 20;

-- ============================================================
-- JOB STARTED vs JOB COMPLETED
-- ============================================================

SELECT
    js."CurrentJobName",
    js.jobs_started,
    COALESCE(jc.jobs_completed, 0) AS jobs_completed,
    ROUND(
        (COALESCE(jc.jobs_completed, 0)::NUMERIC / js.jobs_started) * 100,
        2
    ) AS completion_percentage
FROM
(
    SELECT
        "CurrentJobName",
        COUNT(*) AS jobs_started
    FROM job_started
    GROUP BY "CurrentJobName"
) js
LEFT JOIN
(
    SELECT
        "LastJobCompleted",
        COUNT(*) AS jobs_completed
    FROM job_completed
    GROUP BY "LastJobCompleted"
) jc
ON js."CurrentJobName" = jc."LastJobCompleted"
ORDER BY js.jobs_started DESC;