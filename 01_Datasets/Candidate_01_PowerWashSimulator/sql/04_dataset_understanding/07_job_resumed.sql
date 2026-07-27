

SELECT COUNT(*) total_rows
FROM job_resumed;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'job_resumed';

SELECT *
FROM job_resumed
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(pid) AS missing_pid,
    COUNT(*) - COUNT(job_resumed."Time") AS missing_time,
    COUNT(*) - COUNT(job_resumed."CurrentJobName") AS missing_current_job
FROM job_resumed;

SELECT
    MIN("Time") AS first_job_exit,
    MAX("Time") AS last_job_exit
FROM job_resumed;

SELECT COUNT(*) AS total_rows
FROM job_resumed;

SELECT COUNT(*) AS cleaned_rows
FROM (
    SELECT DISTINCT *
    FROM job_resumed
) t;