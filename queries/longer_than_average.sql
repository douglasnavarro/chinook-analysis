/*
Question 2
Return all the track names that have a song length longer than the average song length.
Though you could perform this with two queries. Imagine you wanted your query to update based on when new data is put in the database.
Therefore, you do not want to hard code the average into your query. You only need the Track table to complete this query.

Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.
*/

SELECT Name, Milliseconds FROM (
	SELECT t.Name, t.Milliseconds, (SELECT AVG(Milliseconds) FROM Track) AS AvgLenght
	FROM Track t
	WHERE AvgLenght < t.Milliseconds
	ORDER BY t.Milliseconds DESC
);

