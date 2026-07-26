

SELECT COUNT(*) total_rows
FROM job_resumed;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'job_resumed';

SELECT *
FROM job_resumed
LIMIT 10;