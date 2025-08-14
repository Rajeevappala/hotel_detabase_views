use HotelDatabase

-- 1. Create a server-level login
CREATE LOGIN reporting_user WITH PASSWORD = 'Rajeev@123';

CREATE USER reporting_user FOR LOGIN reporting_user;

-- Complex View: Summary of customer spending
CREATE VIEW CustomerOrderSummary AS 
SELECT 
    C.CustomerId,
    C.FirstName,
    C.LastName,
    C.Email,
    COUNT(O.OrderId) AS TotalOrders,
    SUM(O.TotalAmount) AS TotalSpent,
    AVG(O.TotalAmount) AS AvgOrderValue
FROM CUSTOMERS C
JOIN ORDERS O
    ON C.CustomerId = O.CustomerId
GROUP BY 
    C.CustomerId, 
    C.FirstName, 
    C.LastName, 
    C.Email;


-- Give reporting user access only to the view
GRANT SELECT ON CustomerOrderSummary TO reporting_user;

-- Remove direct access to ORDERS table
REVOKE SELECT ON ORDERS FROM reporting_user;

--- View all customer summaries

SELECT * 
FROM CustomerOrderSummary;


--- Find the top 3 customers by total spent

SELECT TOP 3 * 
FROM CustomerOrderSummary
ORDER BY TotalSpent DESC;


--- List customers who placed more than or equal to 2 orders

SELECT * 
FROM CustomerOrderSummary
WHERE TotalOrders >= 2;



--- List customers with average order value above ₹3,000

SELECT * 
FROM CustomerOrderSummary
WHERE AvgOrderValue > 3000;


--- Find total revenue from all customers

SELECT SUM(TotalSpent) AS TotalRevenue
FROM CustomerOrderSummary;


--- Find customers with no orders (via LEFT JOIN view method)

SELECT C.CustomerId, C.FirstName, C.LastName
FROM CUSTOMERS C
LEFT JOIN CustomerOrderSummary V
    ON C.CustomerId = V.CustomerId
WHERE V.CustomerId IS NULL;

--- Show percentage contribution of each customer to total revenue

SELECT 
    CustomerId,
    FirstName,
    LastName,
    TotalSpent,
    ROUND((TotalSpent / (SELECT SUM(TotalSpent) FROM CustomerOrderSummary)) * 100, 2) AS RevenuePercent
FROM CustomerOrderSummary;

--- Show top spender’s details

SELECT * 
FROM CustomerOrderSummary
WHERE TotalSpent = (SELECT MAX(TotalSpent) FROM CustomerOrderSummary);

