--" A top-rated busines is defined as one whose reviews contain only 4 or 5 stars. Output the number of businesses and percentage of top rated businesses rounded to the 2 decimal places."

with cte as 
(SELECT 
  business_id,
  sum(review_stars)/count(review_id) as rating
FROM reviews
GROUP BY business_id)
SELECT 
  sum(case when rating = 4 or rating = 5 
    then 1 else 0 end) as business_num,
  round(100*sum(case when rating = 4 or rating = 5 
    then 1 else 0 end)/count(business_id),2)
from cte 
