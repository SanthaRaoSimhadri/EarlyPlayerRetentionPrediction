-- ============================================================
-- SECTION 1 : TABLE OVERVIEW
-- ============================================================

SELECT COUNT(*) AS total_rows
FROM demographics;

SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'demographics';

SELECT *
FROM demographics
LIMIT 10;

SELECT 
    COUNT(demographics.pid) = COUNT(DISTINCT demographics.pid) AS is_unique
FROM demographics;

SELECT
    ordinal_position,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'demographics'
ORDER BY ordinal_position;


SELECT
    COUNT(*) AS missing_pid
FROM demographics
WHERE pid IS NULL;

SELECT
    COUNT(*) total_rows,
    COUNT(DISTINCT pid) unique_players
FROM demographics;

SELECT
    country,
    COUNT(*) AS players
FROM demographics
GROUP BY country
ORDER BY players DESC;

SELECT
    gender,
    COUNT(*) AS players
FROM demographics
GROUP BY gender
ORDER BY players DESC;

SELECT
    MIN(age),
    MAX(age),
    AVG(age),
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY age) AS median_age
FROM demographics;

SELECT
    MIN(logins),
    MAX(logins),
    AVG(logins)
FROM demographics;

SELECT
    MIN(first_login),
    MAX(first_login)
FROM demographics;

SELECT
    MIN(last_login),
    MAX(last_login)
FROM demographics;
