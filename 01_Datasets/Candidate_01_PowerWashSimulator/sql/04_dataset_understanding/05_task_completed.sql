-- ============================================================
-- TABLE OVERVIEW
-- ============================================================

SELECT COUNT(*) AS total_rows
FROM task_completed;

SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'task_completed';

SELECT *
FROM task_completed
LIMIT 10;

-- ============================================================
-- SCHEMA
-- ============================================================

SELECT
    ordinal_position,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name='task_completed'
ORDER BY ordinal_position;

-- ============================================================
-- DATA QUALITY
-- ============================================================

SELECT COUNT(*) AS missing_pid
FROM task_completed
WHERE pid IS NULL;

SELECT COUNT(*) AS missing_task
FROM task_completed
WHERE "LastTaskCompleted" IS NULL;

SELECT COUNT(*) AS missing_subtask
FROM task_completed
WHERE "LastSubtaskCompleted" IS NULL;

SELECT COUNT(*) AS missing_mode
FROM task_completed
WHERE "CurrentGameMode" IS NULL;

SELECT COUNT(*) AS missing_progress
FROM task_completed
WHERE "LevelProgressionAmount" IS NULL;

SELECT COUNT(*) AS missing_time
FROM task_completed
WHERE "Time" IS NULL;

-- ============================================================
-- DUPLICATE ANALYSIS
-- ============================================================

SELECT
    COUNT(*) total_rows,
    COUNT(DISTINCT pid) unique_players
FROM task_completed;

SELECT
    pid,
    "Time",
    COUNT(*)
FROM task_completed
GROUP BY
    pid,
    "Time"
HAVING COUNT(*)>1;

SELECT *
FROM task_completed 
WHERE pid = 'p3260';

-- ============================================================
-- TIMELINE
-- ============================================================

SELECT
    MIN("Time") AS first_task_completed,
    MAX("Time") AS last_task_completed
FROM task_completed;

-- ============================================================
-- TASKS COMPLETED PER PLAYER
-- ============================================================

SELECT
    pid,
    COUNT(*) AS tasks_completed
FROM task_completed
GROUP BY pid
ORDER BY tasks_completed DESC
LIMIT 20;

-- ============================================================
-- MOST COMPLETED TASKS
-- ============================================================

SELECT
    "LastTaskCompleted",
    COUNT(*) AS completion_count
FROM task_completed
GROUP BY "LastTaskCompleted"
ORDER BY completion_count DESC
LIMIT 25;

-- ============================================================
-- UNIQUE TASKS
-- ============================================================

SELECT
    COUNT(DISTINCT "LastTaskCompleted") AS unique_tasks FROM task_completed;

-- ============================================================
-- GAME MODES
-- ============================================================

SELECT
    "CurrentGameMode",
    COUNT(*) AS completion_events
FROM task_completed
GROUP BY "CurrentGameMode"
ORDER BY completion_events DESC;

-- ============================================================
-- LEVEL PROGRESSION
-- ============================================================

SELECT
    MIN("LevelProgressionAmount") AS min_progress,
    MAX("LevelProgressionAmount") AS max_progress,
    AVG("LevelProgressionAmount") AS avg_progress
FROM task_completed;

-- ============================================================
-- TASK FREQUENCY
-- ============================================================

SELECT
    COUNT(DISTINCT pid) AS players_completed_task,
    COUNT(DISTINCT "LastTaskCompleted") AS unique_tasks,
    COUNT(*) AS total_task_events
FROM task_completed;



SELECT COUNT(DISTINCT pid)
FROM job_started;

SELECT COUNT(DISTINCT pid)
FROM task_completed;

SELECT COUNT(DISTINCT pid)
FROM job_completed;

SELECT
    "LastTaskCompleted",
    COUNT(DISTINCT "LastSubtaskCompleted")
FROM task_completed
GROUP BY "LastTaskCompleted"
ORDER BY COUNT(DISTINCT "LastSubtaskCompleted") DESC;
