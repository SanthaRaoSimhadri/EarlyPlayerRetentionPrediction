

SELECT COUNT(*) total_rows
FROM game_saved;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'game_saved';

SELECT *
FROM game_saved
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(pid) AS missing_pid,
    COUNT(*) - COUNT("Time") AS missing_time
FROM game_saved;

SELECT
    MIN("Time") AS first_save,
    MAX("Time") AS last_save
FROM game_saved;

SELECT COUNT(*) AS total_rows
FROM game_saved;

SELECT COUNT(*) AS cleaned_rows
FROM (
    SELECT DISTINCT *
    FROM game_saved
) t;

SELECT
    ordinal_position,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name='game_saved'
ORDER BY ordinal_position;

SELECT DISTINCT game_saved."CumulativeTimeSpentInLevel"
FROM game_saved
LIMIT 20;