--CHARTS
--SALES FUNNEL ANALYSIS
SELECT
    Event_Type AS Funnel_Stage,
    COUNT(DISTINCT Customer_ID) AS Customers
FROM Customer_Activity
GROUP BY Event_Type
ORDER BY
CASE Event_Type
    WHEN 'Visit' THEN 1
    WHEN 'Product View' THEN 2
    WHEN 'Add to Cart' THEN 3
    WHEN 'Checkout' THEN 4
    WHEN 'Purchase' THEN 5
END;
--TRAFFIC SOURCE ANALYSIS
SELECT
    Traffic_Source,
    COUNT(*) AS Customers
FROM Customer_Activity
GROUP BY Traffic_Source
ORDER BY Customers DESC;
--DEVICE USAGE DISTRIBUTION
SELECT
    Device_Type,
    COUNT(*) AS Customers
FROM Customer_Activity
GROUP BY Device_Type
ORDER BY Customers DESC;
--CUSTOMER TYPE DISTRIBUTION
SELECT
    Customer_Type,
    COUNT(*) AS Customers
FROM Customer
GROUP BY Customer_Type
ORDER BY Customers DESC;
--PRODUCT CATEGORY ENGAGEMENT
SELECT
    p.Category,
    COUNT(*) AS Activity_Count
FROM Customer_Activity ca
JOIN Products p
ON ca.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Activity_Count DESC;
