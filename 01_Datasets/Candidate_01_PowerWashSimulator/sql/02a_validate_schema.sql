-- Verify all tables in the public schema
SELECT
    table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

-- Count the number of tables
SELECT COUNT(*) AS total_tables
FROM information_schema.tables
WHERE table_schema = 'public';