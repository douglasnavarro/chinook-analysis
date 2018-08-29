/*
Question 3

First, find which artist has earned the most according to the InvoiceLines?

Now use this artist to find which customer spent the most on this artist.

For this query, you will need to use the Invoice, InvoiceLine, Track, Customer, Album, and Artist tables.

Notice, this one is tricky because the Total spent in the Invoice table might not be on a single product, 
so you need to use the InvoiceLine table to find out how many of each product was purchased, and then multiply this by the price for each artist.
*/
SELECT 
	a.Name, SUM(i.Quantity * i.UnitPrice) AS AmountSpent
FROM Artist a
	JOIN Album al ON a.ArtistId = al.ArtistId
	JOIN Track t ON t.AlbumId = al.AlbumId
	JOIN InvoiceLine i ON t.TrackId = i.Trackid
GROUP BY a.Name
ORDER BY AmountSpent DESC;
