--- CREATE RETION TARGET ---

DROP TABLE IF EXISTS retention_target;

CREATE TABLE retention_target AS

SELECT

    d.pid,

    CASE
        WHEN EXISTS
        (
            SELECT 1
            FROM player_logged_in pl
            WHERE pl.pid = d.pid
              AND pl."Time" >= d.first_login + INTERVAL '1 day'
              AND pl."Time" <  d.first_login + INTERVAL '7 days'
        )
        THEN 1
        ELSE 0
    END AS retained

FROM demographics d;

--- VALIDATION ---
SELECT COUNT(*)
FROM retention_target;

--- DUPLICATE CHECK ---
SELECT
    pid,
    COUNT(*)
FROM retention_target
GROUP BY pid
HAVING COUNT(*) > 1;

--- DISTRIBUTION ---
SELECT
    retained,
    COUNT(*) AS players,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM retention_target
GROUP BY retained
ORDER BY retained;


---- MERGE INTO THE FINAL DATASET ---
ALTER TABLE player_features_final
ADD COLUMN retained INTEGER;

UPDATE player_features_final pf
SET retained = rt.retained
FROM retention_target rt
WHERE pf.pid = rt.pid;

--- VALIDATION ---
SELECT
    COUNT(*)
FROM player_features_final;

SELECT
    retained,
    COUNT(*)
FROM player_features_final
GROUP BY retained;

--------- FINAL PREVIEW ----
SELECT COLUMN_NAME FROM information_schema."columns" WHERE TABLE_NAME = 'player_features_final' ORDER BY ordinal_position;

SELECT *
FROM player_features_final
LIMIT 5;


---- EXPORT CSV ----
SELECT *
FROM player_features_final;