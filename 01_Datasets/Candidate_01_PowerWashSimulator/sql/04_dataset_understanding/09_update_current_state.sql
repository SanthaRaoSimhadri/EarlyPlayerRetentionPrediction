

SELECT COUNT(*) total_rows
FROM update_current_state;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'update_current_state';

SELECT *
FROM update_current_state
LIMIT 10;