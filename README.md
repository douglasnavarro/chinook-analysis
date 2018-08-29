### Question 1.1: Which countries have the most Invoices?
```sql
SELECT BillingCountry AS billingCountry,
       COUNT(*)       AS Invoices 
  FROM Invoice 
GROUP BY BillingCountry 
ORDER BY Invoices DESC;
```

### Question 2.2: Which city has the best customers?
```sql
SELECT BillingCity AS billingCity,
       SUM(Total)  AS InvoiceDollars 
  FROM Invoice 
GROUP BY BillingCity 
ORDER BY InvoiceDollars DESC;
```

### Question 3.3: Who is the best customer?
```sql
SELECT CustomerId AS customerId,
       SUM(Total) AS money_spent 
  FROM Invoice 
GROUP BY CustomerId 
ORDER BY money_spent DESC 
 LIMIT 1;
```

### Question 2.1:
Use your query to return the email, first name, last name, and Genre of all Rock Music listeners. Return your list ordered alphabetically by email address starting with A. Can you find a way to deal with duplicate email addresses so no one receives multiple emails?
```sql
SELECT DISTINCT    AS distinct
       C.Email     AS email,
       C.FirstName AS firstName,
       C.LastName  AS lastName,
       G.Name      AS name
  FROM Customer C JOIN Invoice I 
    ON C.CustomerId = I.CustomerId JOIN InvoiceLine IL 
    ON I.InvoiceId = IL.InvoiceId JOIN Track T 
    ON IL.TrackId = T.TrackId JOIN Genre G 
    ON T.GenreId = G.GenreId 
 WHERE G.Name = "Rock" 
ORDER BY C.Email;
```

### Question 2.2: Who is writing the rock music?
Now that we know that our customers love rock music, we can decide which musicians to invite to play at the concert.
Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands.
```sql
SELECT Artist.ArtistId   AS artistId,
       Artist.Name       AS name,
       COUNT(Track.Name) AS Songs 
  FROM Artist JOIN Album 
    ON Album.ArtistId = Artist.ArtistId JOIN Track 
    ON Album.AlbumId = Track.AlbumId JOIN Genre 
    ON Track.GenreId = Genre.GenreId 
 WHERE Genre.Name = 'Rock' 
GROUP BY Artist.ArtistId,
       Artist.Name,
       Genre.Name 
ORDER BY Songs DESC 
 LIMIT 10;
```

### Question 2.3:
First, find which artist has earned the most according to the InvoiceLines?
Now use this artist to find which customer spent the most on this artist.
```sql
SELECT a.Name          AS name,
       SUM(il.Quantity AS quantity
       *               AS *
       il.UnitPrice)   AS AmountSpent,
       c.CustomerId    AS customerId,
       c.FirstName     AS firstName,
       c.LastName      AS lastName
  FROM Artist a JOIN Album al 
    ON a.ArtistId = al.ArtistId JOIN Track t 
    ON t.AlbumId = al.AlbumId JOIN InvoiceLine il 
    ON t.TrackId = il.Trackid JOIN Invoice i 
    ON il.InvoiceId = i.InvoiceId JOIN Customer c 
    ON c.CustomerId = i.CustomerId 
 WHERE a.Name = 'Iron Maiden' 
GROUP BY c.CustomerId 
ORDER BY AmountSpent DESC;
```

### Question 3.1:
We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres.
```sql
WITH t1 AS (
	SELECT
		COUNT(i.InvoiceId) Purchases, c.Country, g.Name, g.GenreId
	FROM Invoice i
		JOIN Customer c ON i.CustomerId = c.CustomerId
		JOIN InvoiceLine il ON il.Invoiceid = i.InvoiceId
		JOIN Track t ON t.TrackId = il.Trackid
		JOIN Genre g ON t.GenreId = g.GenreId
	GROUP BY c.Country, g.Name
	ORDER BY c.Country, Purchases DESC
	)

SELECT t1.*
FROM t1
JOIN (
	SELECT MAX(Purchases) AS MaxPurchases, Country, Name, GenreId
	FROM t1
	GROUP BY Country
	)t2
ON t1.Country = t2.Country
WHERE t1.Purchases = t2.MaxPurchases;
```

### Question 3.2:
Return all the track names that have a song length longer than the average song length. Though you could perform this with two queries. Imagine you wanted your query to update based on when new data is put in the database. Therefore, you do not want to hard code the average into your query. You only need the Track table to complete this query.
```sql
SELECT Name, Milliseconds FROM (
	SELECT t.Name, t.Milliseconds, (SELECT AVG(Milliseconds) FROM Track) AS AvgLenght
	FROM Track t
	WHERE AvgLenght < t.Milliseconds
	ORDER BY t.Milliseconds DESC
);
```
### Question 3.3:
Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount.
```sql
WITH t1 AS 
(
	SELECT c.Country, SUM(i.Total) TotalSpent, c.FirstName, c.LastName, c.CustomerId
	FROM 
		Customer c
		JOIN Invoice i ON c.CustomerId = i.CustomerId
	GROUP BY c.CustomerId
)

SELECT t1.*
FROM t1
JOIN(
	SELECT Country, MAX(TotalSpent) AS MaxTotalSpent, FirstName, LastName, CustomerId
	FROM t1
	GROUP BY Country
)t2
ON t1.Country = t2.Country
WHERE t1.TotalSpent = t2.MaxTotalSpent
ORDER BY Country;
```
