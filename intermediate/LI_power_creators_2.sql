--" If someone's LinkedIn page has more followers than the company they work for, we can safely assume that person is a power creator. Write a query to return the IDs of these LinkedIn power creators.[...]Assumption: A person can work at multiple companies." 

WITH cte AS (
SELECT 
  pp.profile_id,
  min(case when pp.followers > cp.followers then 1 else 0 end) as flag
FROM personal_profiles pp
JOIN employee_company ec 
  on pp.profile_id = ec.personal_profile_id
JOIN company_pages cp
  on ec.company_id = cp.company_id
GROUP BY pp.profile_id
)
SELECT 
  profile_id
FROM cte 
WHERE flag = 1
ORDER BY profile_id
