--"Write a query that shows the following data for each compensation outlier: employee ID, salary, and whether they are potentially overpaid or potentially underpaid."

--get average salary by title
with t1 as (
SELECT 
  employee_id,
  salary,
  title,
  avg(salary) over (partition by title order by title) as title_avg
FROM employee_pay
),
--assign overpaid/underpaid status
t2 as (
SELECT 
  employee_id,
  salary,
  title,
  CASE 
    WHEN salary > 2*title_avg then 'Overpaid'
    WHEN salary < .5*title_avg then 'Underpaid'
    ELSE null END as status
FROM t1)
SELECT 
  employee_id,
  salary,
  status
FROM t2
WHERE status = 'Overpaid' or status = 'Underpaid'
ORDER BY employee_id
