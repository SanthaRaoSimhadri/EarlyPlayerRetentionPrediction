SELECT COUNT(*) total_rows
FROM job_exited;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'job_completed';

SELECT *
FROM job_exited
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(pid) AS missing_pid,
    COUNT(*) - COUNT(job_exited."Time") AS missing_time,
    COUNT(*) - COUNT(job_exited."CurrentJobName") AS missing_current_job
FROM job_exited;

SELECT
    MIN("Time") AS first_job_exit,
    MAX("Time") AS last_job_exit
FROM job_exited;

SELECT COUNT(*) AS total_rows
FROM job_exited;

SELECT COUNT(*) AS cleaned_rows
FROM (
    SELECT DISTINCT *
    FROM job_exited
) t;

SELECT
ordinal_position,
column_name,
data_type
FROM information_schema.columns
WHERE table_name='job_exited'
ORDER BY ordinal_position;

SELECT COUNT(*) AS missing_pid
FROM job_exited
WHERE pid IS NULL;

SELECT COUNT(*) AS missing_task
FROM job_exited
WHERE "LastTaskCompleted" IS NULL;

SELECT COUNT(*) AS missing_subtask
FROM job_exited
WHERE "LastSubtaskCompleted" IS NULL;

SELECT COUNT(*) AS missing_mode
FROM job_exited
WHERE "CurrentGameMode" IS NULL;

SELECT COUNT(*) AS missing_progress
FROM job_exited
WHERE "LevelProgressionAmount" IS NULL;

SELECT COUNT(*) AS missing_time
FROM job_exited
WHERE "Time" IS NULL;

SELECT COUNT(*) AS missing_time
FROM job_exited
WHERE "CurrentSessionLength" IS NULL;

SELECT
    COUNT(*) total_rows,
    COUNT(DISTINCT pid) unique_players
FROM job_exited;

SELECT
    pid,
    "Time",
    COUNT(*)
FROM job_exited
GROUP BY
    pid,
    "Time"
HAVING COUNT(*)>1;

SELECT *
FROM job_exited 
WHERE pid = 'p6866';

SELECT
    MIN("Time") AS first_job_exited,
    MAX("Time") AS last_job_exited
FROM job_exited;

SELECT
COUNT(DISTINCT pid)
FROM job_exited;

SELECT
"CurrentJobName",
COUNT(*)
FROM job_exited
GROUP BY "CurrentJobName"
ORDER BY COUNT(*) DESC;


SELECT
    "CurrentGameMode",
    COUNT(*) AS job_exited_events
FROM job_exited
GROUP BY "CurrentGameMode"
ORDER BY job_exited_events DESC;


SELECT
    MIN("CurrentSessionLength") AS min_session_length,
    MAX("CurrentSessionLength") AS max_session_length,
    AVG("CurrentSessionLength") AS avg_session_length
FROM job_exited;

SELECT

MIN("LevelProgressionAmount"),

MAX("LevelProgressionAmount"),

AVG("LevelProgressionAmount")

FROM job_exited;

SELECT
"LastTaskCompleted",
COUNT(*)
FROM job_exited
GROUP BY "LastTaskCompleted"
ORDER BY COUNT(*) DESC;

SELECT
"LastSubtaskCompleted",
COUNT(*)
FROM job_exited
GROUP BY "LastSubtaskCompleted"
ORDER BY COUNT(*) DESC;
