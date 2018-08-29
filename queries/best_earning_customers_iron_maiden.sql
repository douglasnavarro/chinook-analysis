/*
Solution Continued with top Purchaser

Then, the top purchasers are shown in the table below. The customer with the highest total invoice amount is customer 55, Mark Taylor.
*/
SELECT 
	a.Name, SUM(il.Quantity * il.UnitPrice) AS AmountSpent, c.CustomerId, c.FirstName, c.LastName
FROM Artist a
	JOIN Album al ON a.ArtistId = al.ArtistId
	JOIN Track t ON t.AlbumId = al.AlbumId
	JOIN InvoiceLine il ON t.TrackId = il.Trackid
	JOIN Invoice i ON il.InvoiceId = i.InvoiceId
	JOIN Customer c ON c.CustomerId = i.CustomerId
WHERE a.Name = 'Iron Maiden'
GROUP BY c.CustomerId
ORDER BY AmountSpent DESC;