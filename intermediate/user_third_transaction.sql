--"Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date."

with cte as (
SELECT 
  user_id,
  spend,
  transaction_date,
  row_number() over (partition by user_id 
  order by transaction_date) as rank
FROM transactions
)
SELECT 
  user_id,
  spend,
  transaction_date
FROM cte 
WHERE rank = 3
