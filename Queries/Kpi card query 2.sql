--KPI CARDS
--TO CALCULATE SUCCESSFUL PAYMENTS
SELECT COUNT(*) AS Successful_Payments
FROM Orders
WHERE Payment_Status = 'Success';

--TO CALCULATE FAILED PAYMENTS
SELECT COUNT(*) AS Failed_Payments
FROM Orders
WHERE Payment_Status = 'Failed';

--TO CALCULATE AB TEST CONVERSION RATE
SELECT ROUND(
(
COUNT(CASE WHEN Conversion_Status='Converted' THEN 1 END)
* 100.0
/
COUNT(*)
),
2
) AS AB_Test_Conversion_Rate
FROM AB_Test;

--TO CALCULATE TOTAL ABANDONED CARTS
SELECT COUNT(*) AS Total_Abandoned_Carts
FROM Cart
WHERE Cart_Status = 'Abandoned';

--TO CALCULATE TOTAL CONVERTED CUSTOMERS
SELECT COUNT(*) AS Total_Converted_Customers
FROM AB_Test
WHERE Conversion_Status = 'Converted';