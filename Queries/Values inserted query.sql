SELECT COUNT(*) AS Total_Visitors
FROM Customer;

SELECT COUNT(*) AS Total_Orders
FROM Orders;

SELECT ROUND(SUM(Order_Amount), 2) AS Total_Revenue
FROM Orders
WHERE Payment_Status = 'Success';

SELECT ROUND(
(
COUNT(DISTINCT o.Customer_ID) * 100.0
/
COUNT(DISTINCT c.Customer_ID)
),
2
) AS Funnel_Conversion_Rate
FROM Customer c
LEFT JOIN Orders o
ON c.Customer_ID = o.Customer_ID;

SELECT ROUND(
(
COUNT(CASE WHEN Cart_Status = 'Abandoned' THEN 1 END) * 100.0
/
COUNT(*)
),
2
) AS Cart_Abandonment_Rate
FROM Cart;