

SELECT COUNT(*) total_rows
FROM update_current_state;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'update_current_state';

SELECT *
FROM update_current_state
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(pid) AS missing_pid,
    COUNT(*) - COUNT("Time") AS missing_time,
    COUNT(*) - COUNT("CurrentNozzle") AS missing_nozzle,
    COUNT(*) - COUNT("CurrentWasher") AS missing_washer,
    COUNT(*) - COUNT("LevelProgressionAmount") AS missing_level_progression
FROM update_current_state;

SELECT
    MIN("Time") AS first_state_update,
    MAX("Time") AS last_state_update
FROM update_current_state;

SELECT COUNT(*) AS total_rows
FROM update_current_state;

SELECT COUNT(*) AS unique_rows
FROM (
    SELECT DISTINCT *
    FROM update_current_state
) t;

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE "CurrentNozzle" IS NULL AND "CurrentWasher" IS NULL) AS both_missing,
    COUNT(*) FILTER (WHERE "CurrentNozzle" IS NULL AND "CurrentWasher" IS NOT NULL) AS nozzle_only_missing,
    COUNT(*) FILTER (WHERE "CurrentNozzle" IS NOT NULL AND "CurrentWasher" IS NULL) AS washer_only_missing
FROM update_current_state;

SELECT
    ordinal_position,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name='update_current_state'
ORDER BY ordinal_position;