--"Output the age bucket and percentage of sending and opening snaps. Round the percentages to 2 decimal places."

WITH cte AS (
  SELECT
  age_breakdown.age_bucket,
  sum(case when activities.activity_type = 'open' 
    then activities.time_spent else null end) as opens,
  sum(case when activities.activity_type = 'send' 
    then activities.time_spent else null end) as sends,
  sum(activities.time_spent) as total_time
FROM activities
  LEFT JOIN age_breakdown on activities.user_id = age_breakdown.user_id
GROUP BY age_breakdown.age_bucket
)

SELECT
  age_bucket,
  round(100*sends/(sends+opens),2) as sends_p,
  round(100*opens/(sends+opens),2) as open_p
FROM cte 
GROUP BY age_bucket, opens, sends
