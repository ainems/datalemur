--"Write a query to obtain the year-on-year growth rate for the total spend of each product for each year."

with cte as (
SELECT  
  extract(year from transaction_date) as year,
  product_id,
  sum(spend) as current_year,
  lag(sum(spend), 1) over 
  (partition by product_id 
  order by date_part('year',transaction_date)) as prior_year
from user_transactions
group by product_id, transaction_date
)
SELECT
  year,
  product_id,
  current_year,
  prior_year,
  round(100*(current_year-prior_year)/prior_year,2) as yoy
from cte 
