-- "Write a query to compare the viewership on laptops versus mobile devices."


SELECT 
count(distinct case 
  when device_type = 'laptop' 
    then user_id else null end) as laptop,
count(distinct case 
  when device_type = 'tablet' or device_type = 'phone' 
    then user_id else  null end) as mobile
FROM viewership;
