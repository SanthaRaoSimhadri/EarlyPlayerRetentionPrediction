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

-- Missing values
SELECT
    COUNT(*) AS total_rows,

    COUNT(*) - COUNT(pid) AS missing_pid,
    COUNT(*) - COUNT(responses) AS missing_responses,
    COUNT(*) - COUNT(logins) AS missing_logins,
    COUNT(*) - COUNT(first_login) AS missing_first_login,
    COUNT(*) - COUNT(last_login) AS missing_last_login,
    COUNT(*) - COUNT(country) AS missing_country,
    COUNT(*) - COUNT(age) AS missing_age,
    COUNT(*) - COUNT(gender) AS missing_gender,
    COUNT(*) - COUNT(n_demographics) AS missing_n_demographics

FROM demographics;

-- Duplicate analysis
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT (
        pid,
        responses,
        logins,
        first_login,
        last_login,
        country,
        age,
        gender,
        n_demographics
    )) AS distinct_rows
FROM demographics;

-- Outlier analysis

SELECT
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    AVG(age) AS avg_age,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY age) AS median_age
FROM demographics
WHERE age IS NOT NULL;

SELECT
    age,
    COUNT(*) AS players
FROM demographics
WHERE age >= 100
GROUP BY age
ORDER BY age;

SELECT
    MIN(logins) AS min_logins,
    MAX(logins) AS max_logins,
    AVG(logins) AS avg_logins,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY logins) AS median_logins
FROM demographics
WHERE logins IS NOT NULL;

SELECT
    logins,
    COUNT(*) AS players
FROM demographics
WHERE logins >= 100
GROUP BY logins
ORDER BY logins;



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

