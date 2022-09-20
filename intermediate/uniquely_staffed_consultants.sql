--"Write a SQL query that outputs the client name, the number of uniquely staffed consultants, and the number of exclusively staffed consultants."

with cte as 
(SELECT
  employee_id,
  count(engagement_id) as engagements
from employees
group by employee_id)
SELECT
  ce.client_name,
  count(cte.employee_id),
  sum(case when cte.engagements = 1 then 1 else 0 end) as unique
from consulting_engagements ce 
join employees e 
  on ce.engagement_id = e.engagement_id
join cte 
  on e.employee_id = cte.employee_id
group by ce.client_name
order by ce.client_name
