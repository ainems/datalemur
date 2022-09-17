
--"Output the top 5 artist names in ascending order along with their song appearances ranking (not the number of song appearances, but the rank of who has the most appearances). The order of the rank should take precedence."

--count songs that are globally ranked per artist
with t1 as (
SELECT 
  a.artist_name,
  count(sr.song_id) as song_count
FROM 
  artists a
JOIN songs s on a.artist_id = s.artist_id
JOIN global_song_rank sr on s.song_id = sr.song_id
where sr.rank <= 10
group by a.artist_name
),
--dense rank of artists
t2 as (
SELECT
  artist_name,
  dense_rank() over (order by song_count desc) as RANk
FROM 
t1
)
--limit to top 5 artists
SELECT
  artist_name,
  rank 
FROM t2 
WHERE rank <= 5
  
