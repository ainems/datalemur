--"Write a SQL query to find the confirmation rate of people who confirmed their signups with text messages. Round the result to 2 decimal places."

--remove nulls as they are users who did not initiate signup process
WITH cte AS (
SELECT 
  user_id,
  texts.signup_action as signup_action
FROM emails
LEFT JOIN texts on emails.email_id = texts.email_id
WHERE texts.signup_action is not null
)
SELECT
  round(sum(case when signup_action = 'Confirmed' then 1 else 0 end)::numeric/count(user_id),2) as confirmation_rate
FROM cte
