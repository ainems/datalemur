-- "Identify the top two highest-grossing products within each category in 2022. Output the category, product, and total spend."

WITH cte AS
(SELECT  
  category,
  product,
  sum(spend)  as spend,
  row_number() over 
  (partition by category 
  order by sum(spend)desc) as rownum
FROM product_spend
WHERE date_part('year',transaction_date) = 2022
GROUP BY category, product
)
SELECT 
  category,
  product,
  spend
FROM cte
WHERE (rownum=1 or rownum=2) 
