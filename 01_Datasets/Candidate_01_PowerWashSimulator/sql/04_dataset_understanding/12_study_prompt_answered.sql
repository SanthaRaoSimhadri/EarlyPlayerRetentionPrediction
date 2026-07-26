

SELECT COUNT(*) total_rows
FROM study_prompt_answered;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'study_prompt_answered';

SELECT *
FROM study_prompt_answered
LIMIT 10;