

SELECT COUNT(*) total_rows
FROM mood_reported;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'mood_reported';

SELECT *
FROM mood_reported
LIMIT 10;

SELECT
    ordinal_position,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name='mood_reported'
ORDER BY ordinal_position;

SELECT DISTINCT mood_reported."LastStudyPromptType"
FROM mood_reported;

SELECT DISTINCT mood_reported.response
FROM mood_reported
ORDER BY mood_reported.response;