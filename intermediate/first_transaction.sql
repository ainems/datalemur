--"Write a query to obtain the list of customers whose first transaction was valued at $50 or more. Output the number of users."

WITH cte AS (
SELECT 
  transaction_id,
  user_id,
  spend,
  row_number() over (partition by user_id order by transaction_id)
    as rownum
FROM user_transactions
)
SELECT  
  count(user_id)
FROM cte 
WHERE rownum = 1 and spend > 50
