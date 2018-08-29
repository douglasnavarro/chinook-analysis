/*
Question 1
Use your query to return the email, first name, last name, and Genre of all Rock Music listeners.
Return your list ordered alphabetically by email address starting with A.
Can you find a way to deal with duplicate email addresses so no one receives multiple emails?

I chose to link information from the Customer, Invoice, InvoiceLine, Track, and Genre tables,
but you may be able to find another way to get at the information.
*/
SELECT DISTINCT C.Email, C.FirstName, C.LastName, G.Name
FROM Customer C
JOIN Invoice I
ON C.CustomerId = I.CustomerId
JOIN InvoiceLine IL
ON I.InvoiceId = IL.InvoiceId
JOIN Track T
ON IL.TrackId = T.TrackId
JOIN Genre G
ON T.GenreId = G.GenreId
WHERE G.Name = "Rock"
ORDER BY C.Email;