--"Write a query to show the user ID, song ID, and the number of times the user has played each song as of August 4, 2022. We'll refer to the number of song plays as song_plays. The rows with the most song plays should be at the top of the output."

with cte as  (
SELECT
  user_id,
  song_id,
  count(listen_time) as song_plays
from songs_weekly
where listen_time::date between '08/01/2022' and '08/04/2022'
group by user_id, song_id
UNION ALL
SELECT
  user_id,
  song_id,
  song_plays
from songs_history
)
select 
  user_id,
  song_id,
  sum(song_plays)
from cte 
group by user_id, song_id
order by 3 desc
  
