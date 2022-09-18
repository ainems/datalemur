--"A shopping spree occurs when a user makes purchases on 3 or more consecutive days. List the user ids who have gone on at least 1 shopping spree."

with cte as 
(SELECT
  user_id,
  transaction_date,
  lead(transaction_date,1) over (partition by user_id order by transaction_date) as next_day,
  lead(transaction_date,2) over (partition by user_id order by transaction_date) as third_day
from transactions)
SELECT
  user_id
from cte 
where next_day - transaction_date = interval '1 day'
and third_day - next_day = interval '1 day'
