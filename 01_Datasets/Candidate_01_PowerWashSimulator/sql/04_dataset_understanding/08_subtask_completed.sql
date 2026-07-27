

SELECT COUNT(*) total_rows
FROM subtask_completed;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'subtask_completed';

SELECT *
FROM subtask_completed
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(pid) AS missing_pid,
    COUNT(*) - COUNT(subtask_completed."Time") AS missing_time,
    COUNT(*) - COUNT(subtask_completed."LastSubtaskCompleted") AS missing_subtask
FROM subtask_completed;

SELECT
    MIN("Time") AS first_subtask_completed,
    MAX("Time") AS last_subtask_completed
FROM subtask_completed;

-- Original row count
SELECT COUNT(*) AS total_rows
FROM subtask_completed;

-- Unique row count
SELECT COUNT(*) AS cleaned_rows
FROM (
    SELECT DISTINCT *
    FROM subtask_completed
) t;

CREATE TABLE subtask_completed_clean AS
SELECT DISTINCT *
FROM subtask_completed;

SELECT COUNT(*) AS cleaned_rows
FROM subtask_completed_clean;

SELECT
    ordinal_position,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name='subtask_completed_clean'
ORDER BY ordinal_position;