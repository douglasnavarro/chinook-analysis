SELECT CustomerId, SUM(Total) AS money_spent
FROM Invoice
GROUP BY CustomerId
ORDER BY money_spent DESC
LIMIT 1;