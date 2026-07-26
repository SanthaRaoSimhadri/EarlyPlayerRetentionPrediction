

SELECT COUNT(*) total_rows
FROM item_purchased;

SELECT COUNT(*) total_columns FROM information_schema.columns WHERE table_name = 'item_purchased';

SELECT *
FROM item_purchased
LIMIT 10;