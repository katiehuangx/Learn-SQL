# Advent of SQL

## Day 1

/*
Find the most popular song with the most plays and least skips, in that order.

A skip is when the song hasn't been played the whole way through.

Submit the song name.

table: song_title   | total_plays | total_skips 

Plays - song_duration = duration
Skips - duration < song_duration

*/

```sql
WITH song_report AS (
SELECT
	songs.song_id,
    songs.song_title,
    songs.song_duration,
    up.play_id,
    up.play_time,
    up.duration,
    users.user_id,
    users.username
FROM songs
LEFT JOIN user_plays AS up
	ON songs.song_id = up.song_id
LEFT JOIN users
	ON up.user_id = users.user_id
)
,play_report AS (

SELECT 
	*,
    CASE WHEN song_duration = duration THEN 1
    ELSE NULL
    END AS plays,
    CASE WHEN song_duration > duration THEN 1 
    ELSE NULL
    END AS skips
FROM song_report
WHERE song_duration IS NOT NULL
  AND duration IS NOT NULL
)

SELECT 
	song_title,
    COUNT(plays) AS total_plays,
    COUNT(skips) AS total_skips
FROM play_report
GROUP BY song_title
ORDER BY total_plays DESC, total_skips ASC;
```

