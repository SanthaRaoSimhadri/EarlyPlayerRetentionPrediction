SELECT
    table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;


SELECT
    'demographics' AS table_name,
    COUNT(*) AS row_count
FROM demographics

UNION ALL

SELECT
    'player_logged_in',
    COUNT(*)
FROM player_logged_in

UNION ALL

SELECT
    'game_saved',
    COUNT(*)
FROM game_saved

UNION ALL

SELECT
    'subtask_completed',
    COUNT(*)
FROM subtask_completed

UNION ALL

SELECT
    'study_reward_unlocked',
    COUNT(*)
FROM study_reward_unlocked

UNION ALL

SELECT
    'study_reward_claimed',
    COUNT(*)
FROM study_reward_claimed

UNION ALL

SELECT
    'study_prompt_answered',
    COUNT(*)
FROM study_prompt_answered

UNION ALL

SELECT
    'mood_reported',
    COUNT(*)
FROM mood_reported

UNION ALL

SELECT
    'job_started',
    COUNT(*)
FROM job_started

UNION ALL

SELECT
    'job_resumed',
    COUNT(*)
FROM job_resumed

UNION ALL

SELECT
    'job_exited',
    COUNT(*)
FROM job_exited

UNION ALL

SELECT
    'job_completed',
    COUNT(*)
FROM job_completed

UNION ALL

SELECT
    'task_completed',
    COUNT(*)
FROM task_completed

UNION ALL

SELECT
    'item_purchased',
    COUNT(*)
FROM item_purchased

UNION ALL

SELECT
    'update_current_state',
    COUNT(*)
FROM update_current_state

UNION ALL

SELECT
    'exited_game',
    COUNT(*)
FROM exited_game

ORDER BY row_count DESC;

SELECT
    COUNT(*)
FROM demographics
WHERE pid IS NULL;

SELECT
    COUNT(*) total_rows,
    COUNT(DISTINCT pid) unique_players
FROM demographics;

SELECT *
FROM player_logged_in
LIMIT 100;

SELECT
    MIN("Time_utc"),
    MAX("Time_utc")
FROM player_logged_in;

SELECT
    COUNT(DISTINCT pid)
FROM player_logged_in;