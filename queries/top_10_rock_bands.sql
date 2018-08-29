/*
Question 2: Who is writing the rock music?

Now that we know that our customers love rock music, we can decide which musicians to invite to play at the concert.

Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands.

You will need to use the Genre, Track , Album, and Artist tables.
*/

SELECT Artist.ArtistId, Artist.Name, COUNT(Track.Name) AS Songs
FROM Artist
JOIN Album
ON Album.ArtistId = Artist.ArtistId
JOIN Track
ON Album.AlbumId = Track.AlbumId
JOIN Genre
ON Track.GenreId = Genre.GenreId
WHERE Genre.Name = 'Rock'
GROUP BY Artist.ArtistId, Artist.Name, Genre.Name
ORDER BY Songs DESC
LIMIT 10;