

SELECT COUNT(*) total_rows
FROM exited_game;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'exited_game';

SELECT *
FROM exited_game
LIMIT 10;

SELECT
    ordinal_position,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name='exited_game'
ORDER BY ordinal_position;