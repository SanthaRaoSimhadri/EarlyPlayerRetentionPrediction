

SELECT COUNT(*) total_rows
FROM study_reward_unlocked;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'study_reward_unlocked';

SELECT *
FROM study_reward_unlocked
LIMIT 10;