SELECT BillingCountry, COUNT(*) AS Invoices
FROM Invoice
GROUP BY BillingCountry
ORDER BY Invoices DESC;