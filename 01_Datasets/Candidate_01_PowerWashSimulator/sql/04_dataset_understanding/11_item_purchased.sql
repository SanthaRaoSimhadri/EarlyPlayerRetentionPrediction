

SELECT COUNT(*) total_rows
FROM item_purchased;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'item_purchased';

SELECT *
FROM item_purchased
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(pid) AS missing_pid,
    COUNT(*) - COUNT("Time") AS missing_time,
    COUNT(*) - COUNT(item_purchased."LastItemPurchased") AS missing_item_name,
    COUNT(*) - COUNT(item_purchased."CurrentCreditAmount") AS missing_cost
FROM item_purchased;

SELECT
    MIN("Time") AS first_purchase,
    MAX("Time") AS last_purchase
FROM item_purchased;

SELECT COUNT(*) AS total_rows
FROM item_purchased;

SELECT COUNT(*) AS unique_rows
FROM (
    SELECT DISTINCT *
    FROM item_purchased
) t;

SELECT
    ordinal_position,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name='item_purchased'
ORDER BY ordinal_position;

SELECT DISTINCT item_purchased."LastItemPurchased"
FROM item_purchased
ORDER BY item_purchased."LastItemPurchased"
LIMIT 50;