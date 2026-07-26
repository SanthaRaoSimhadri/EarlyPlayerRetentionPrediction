

SELECT COUNT(*) total_rows
FROM study_reward_claimed;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'study_reward_claimed';

SELECT *
FROM study_reward_claimed
LIMIT 10;