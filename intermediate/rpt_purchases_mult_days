--"Write a query to obtain the number of users who purchased the same product on two or more different days. Output the number of unique users."

with cte as (
SELECT 
  user_id,
  product_id,
  purchase_date::date,
  rank() over 
  (partition by user_id, product_id
  order by purchase_date::date) as rank
FROM purchases
group by user_id, product_id, purchase_date
)
select 
  count(user_id)
from cte 
where rank > 1
