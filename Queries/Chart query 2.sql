--AB TEST CONVERSION ANALYSIS
SELECT
    Version,
    Conversion_Status,
    COUNT(*) AS Customers
FROM AB_Test
GROUP BY Version, Conversion_Status
ORDER BY Version;

--REVENUE TREND ANALYSIS
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(order_amount) AS total_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

--CART STATUS ANALYSIS
SELECT
    Cart_Status,
    COUNT(*) AS Total_Carts
FROM Cart
GROUP BY Cart_Status
ORDER BY Total_Carts DESC;

--PAYMENT STATUS ANALYSIS
SELECT
    payment_status,
    COUNT(order_id) AS total_payments
FROM orders
GROUP BY payment_status
ORDER BY total_payments DESC;

--ORDER TREND ANALYSIS
SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

