/* =========================================================
   ACCOUNTS PAYABLE DASHBOARD – SQL QUERIES
   Author      : Bhavani Gowda
   Description : SQL queries used for Accounts Payable
                 analytics in Power BI dashboard
   ========================================================= */

------------------------------------------------------------
-- 1. Total Invoice Amount
------------------------------------------------------------
SELECT
    SUM(InvoiceAmount) AS Total_Invoice_Amount
FROM FactAPInvoices;

------------------------------------------------------------
-- 2. Total Paid Amount
------------------------------------------------------------
SELECT
    SUM(PaidAmount) AS Total_Paid_Amount
FROM FactAPInvoices;

------------------------------------------------------------
-- 3. Outstanding Amount
------------------------------------------------------------
SELECT
    SUM(InvoiceAmount - ISNULL(PaidAmount, 0)) AS Outstanding_Amount
FROM FactAPInvoices;

------------------------------------------------------------
-- 4. Overdue Amount
------------------------------------------------------------
SELECT
    SUM(InvoiceAmount - ISNULL(PaidAmount, 0)) AS Overdue_Amount
FROM FactAPInvoices
WHERE
    DueDate < GETDATE()
    AND (PaymentDate IS NULL OR PaidAmount < InvoiceAmount);

------------------------------------------------------------
-- 5. Invoice Count
------------------------------------------------------------
SELECT
    COUNT(DISTINCT InvoiceID) AS Invoice_Count
FROM FactAPInvoices;

------------------------------------------------------------
-- 6. Paid vs Unpaid Invoice Count
------------------------------------------------------------
SELECT
    CASE
        WHEN PaymentDate IS NULL THEN 'Unpaid'
        ELSE 'Paid'
    END AS Payment_Status,
    COUNT(*) AS Invoice_Count
FROM FactAPInvoices
GROUP BY
    CASE
        WHEN PaymentDate IS NULL THEN 'Unpaid'
        ELSE 'Paid'
    END;

------------------------------------------------------------
-- 7. Invoice Aging Buckets
------------------------------------------------------------
SELECT
    CASE
        WHEN DATEDIFF(DAY, DueDate, GETDATE()) <= 30 THEN '0-30 Days'
        WHEN DATEDIFF(DAY, DueDate, GETDATE()) <= 60 THEN '31-60 Days'
        WHEN DATEDIFF(DAY, DueDate, GETDATE()) <= 90 THEN '61-90 Days'
        ELSE '90+ Days'
    END AS Aging_Bucket,
    SUM(InvoiceAmount - ISNULL(PaidAmount, 0)) AS Outstanding_Amount
FROM FactAPInvoices
WHERE
    PaymentDate IS NULL OR PaidAmount < InvoiceAmount
GROUP BY
    CASE
        WHEN DATEDIFF(DAY, DueDate, GETDATE()) <= 30 THEN '0-30 Days'
        WHEN DATEDIFF(DAY, DueDate, GETDATE()) <= 60 THEN '31-60 Days'
        WHEN DATEDIFF(DAY, DueDate, GETDATE()) <= 90 THEN '61-90 Days'
        ELSE '90+ Days'
    END;

------------------------------------------------------------
-- 8. Vendor-wise Outstanding Amount
------------------------------------------------------------
SELECT
    V.VendorName,
    SUM(F.InvoiceAmount - ISNULL(F.PaidAmount, 0)) AS Outstanding_Amount
FROM FactAPInvoices F
JOIN DimVendor V
    ON F.VendorID = V.VendorID
GROUP BY V.VendorName
ORDER BY Outstanding_Amount DESC;

------------------------------------------------------------
-- 9. Invoice Trend by Month
------------------------------------------------------------
SELECT
    YEAR(InvoiceDate) AS Invoice_Year,
    MONTH(InvoiceDate) AS Invoice_Month,
    COUNT(InvoiceID) AS Invoice_Count,
    SUM(InvoiceAmount) AS Total_Invoice_Amount
FROM FactAPInvoices
GROUP BY
    YEAR(InvoiceDate),
    MONTH(InvoiceDate)
ORDER BY Invoice_Year, Invoice_Month;

------------------------------------------------------------
-- 10. Average Days Overdue
------------------------------------------------------------
SELECT
    AVG(DATEDIFF(DAY, DueDate, GETDATE())) AS Avg_Days_Overdue
FROM FactAPInvoices
WHERE
    DueDate < GETDATE()
    AND (PaymentDate IS NULL OR PaidAmount < InvoiceAmount);

------------------------------------------------------------
-- 11. Vendor Payment Status Summary
------------------------------------------------------------
SELECT
    V.VendorName,
    COUNT(F.InvoiceID) AS Total_Invoices,
    SUM(F.InvoiceAmount) AS Total_Invoice_Amount,
    SUM(ISNULL(F.PaidAmount, 0)) AS Paid_Amount,
    SUM(F.InvoiceAmount - ISNULL(F.PaidAmount, 0)) AS Outstanding_Amount
FROM FactAPInvoices F
JOIN DimVendor V
    ON F.VendorID = V.VendorID
GROUP BY V.VendorName
ORDER BY Outstanding_Amount DESC;
