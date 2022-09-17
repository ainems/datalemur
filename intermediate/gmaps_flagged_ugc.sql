--"Write a query to determine which type of place (place_category) attracts the most UGC tagged as "off-topic"."

SELECT 
  place_category
FROM 
--calculate dense-rank for place categories labelled 'off topic'
(SELECT 
  pi.place_category,
  dense_rank() over (order by count(pi.place_id) desc) as place_rank
FROM maps_ugc_review r
LEFT JOIN place_info pi
  ON r.place_id = pi.place_id
WHERE r.content_tag = 'Off-topic'
GROUP BY pi.place_category
) A  
--return only top rank
WHERE place_rank = 1
