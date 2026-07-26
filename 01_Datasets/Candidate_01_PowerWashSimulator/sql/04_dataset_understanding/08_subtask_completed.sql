

SELECT COUNT(*) total_rows
FROM subtask_completed;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'subtask_completed';

SELECT *
FROM subtask_completed
LIMIT 10;