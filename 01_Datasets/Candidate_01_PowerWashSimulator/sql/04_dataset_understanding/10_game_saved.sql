

SELECT COUNT(*) total_rows
FROM game_saved;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'game_saved';

SELECT *
FROM game_saved
LIMIT 10;