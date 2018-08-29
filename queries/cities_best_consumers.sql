SELECT BillingCity, SUM(Total) AS InvoiceDollars
FROM Invoice
GROUP BY BillingCity
ORDER BY InvoiceDollars DESC;