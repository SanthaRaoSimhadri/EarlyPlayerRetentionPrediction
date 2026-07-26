

SELECT COUNT(*) total_rows
FROM mood_reported;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'mood_reported';

SELECT *
FROM mood_reported
LIMIT 10;