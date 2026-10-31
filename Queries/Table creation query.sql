INSERT INTO Customer
(Customer_ID, Customer_Name, Customer_Type, Registration_Date)
SELECT
    gs,
    'Customer_' || gs,
    CASE
        WHEN gs <= 250 THEN 'New'
        ELSE 'Returning'
    END,
    DATE '2025-01-01' + (gs % 365)
FROM generate_series(1, 500) AS gs;
INSERT INTO Products
(Product_ID, Product_Name, Category, Price, Stock_Status)
SELECT
    gs,

    CASE
        WHEN gs % 5 = 1 THEN 'Mobile_' || gs
        WHEN gs % 5 = 2 THEN 'Laptop_' || gs
        WHEN gs % 5 = 3 THEN 'Electronic_' || gs
        WHEN gs % 5 = 4 THEN 'Fashion_' || gs
        ELSE 'Appliance_' || gs
    END AS Product_Name,

    CASE
        WHEN gs % 5 = 1 THEN 'Mobiles'
        WHEN gs % 5 = 2 THEN 'Laptops'
        WHEN gs % 5 = 3 THEN 'Electronics'
        WHEN gs % 5 = 4 THEN 'Fashion'
        ELSE 'Home Appliances'
    END AS Category,

    (floor(random() * 90000) + 1000)::DECIMAL(10,2) AS Price,

    CASE
        WHEN random() < 0.8 THEN 'In Stock'
        ELSE 'Out of Stock'
    END AS Stock_Status

FROM generate_series(1,500) AS gs;
INSERT INTO Customer_Activity
(Activity_ID, Customer_ID, Session_ID, Product_ID,
 Event_Type, Event_Date, Device_Type, Traffic_Source)

SELECT
ROW_NUMBER() OVER () AS Activity_ID,
Customer_ID,
1000 + Customer_ID AS Session_ID,
floor(random()*500 + 1)::INT AS Product_ID,
Event_Type,
DATE '2025-01-01' + floor(random()*365)::INT AS Event_Date,

CASE
    WHEN random() < 0.5 THEN 'Mobile'
    ELSE 'Desktop'
END AS Device_Type,

CASE
    WHEN random() < 0.33 THEN 'Ads'
    WHEN random() < 0.66 THEN 'Organic'
    ELSE 'Referral'
END AS Traffic_Source

FROM
(
    -- 50 customers : Visit only
    SELECT Customer_ID, 'Visit' AS Event_Type
    FROM generate_series(1,50) Customer_ID

    UNION ALL

    -- 100 customers : Visit + Product View
    SELECT Customer_ID, Event_Type
    FROM generate_series(51,150) Customer_ID
    CROSS JOIN
    (
        VALUES
        ('Visit'),
        ('Product View')
    ) AS E(Event_Type)

    UNION ALL

    -- 100 customers : Visit + Product View + Add to Cart
    SELECT Customer_ID, Event_Type
    FROM generate_series(151,250) Customer_ID
    CROSS JOIN
    (
        VALUES
        ('Visit'),
        ('Product View'),
        ('Add to Cart')
    ) AS E(Event_Type)

    UNION ALL

    -- 70 customers : Visit + Product View + Add to Cart + Checkout
    SELECT Customer_ID, Event_Type
    FROM generate_series(251,320) Customer_ID
    CROSS JOIN
    (
        VALUES
        ('Visit'),
        ('Product View'),
        ('Add to Cart'),
        ('Checkout')
    ) AS E(Event_Type)

    UNION ALL

    -- 180 customers : Complete Purchase
    SELECT Customer_ID, Event_Type
    FROM generate_series(321,500) Customer_ID
    CROSS JOIN
    (
        VALUES
        ('Visit'),
        ('Product View'),
        ('Add to Cart'),
        ('Checkout'),
        ('Purchase')
    ) AS E(Event_Type)

) AS X;
INSERT INTO Customer_Activity
(Activity_ID, Customer_ID, Session_ID, Product_ID,
 Event_Type, Event_Date, Device_Type, Traffic_Source)

SELECT
ROW_NUMBER() OVER () AS Activity_ID,
Customer_ID,
1000 + Customer_ID AS Session_ID,
floor(random()*500 + 1)::INT AS Product_ID,
Event_Type,
DATE '2025-01-01' + floor(random()*365)::INT AS Event_Date,

CASE
    WHEN random() < 0.5 THEN 'Mobile'
    ELSE 'Desktop'
END AS Device_Type,

CASE
    WHEN random() < 0.33 THEN 'Ads'
    WHEN random() < 0.66 THEN 'Organic'
    ELSE 'Referral'
END AS Traffic_Source

FROM
(
    -- 50 customers : Visit only
    SELECT Customer_ID, 'Visit' AS Event_Type
    FROM generate_series(1,50) Customer_ID

    UNION ALL

    -- 100 customers : Visit + Product View
    SELECT Customer_ID, Event_Type
    FROM generate_series(51,150) Customer_ID
    CROSS JOIN
    (
        VALUES
        ('Visit'),
        ('Product View')
    ) AS E(Event_Type)

    UNION ALL

    -- 100 customers : Visit + Product View + Add to Cart
    SELECT Customer_ID, Event_Type
    FROM generate_series(151,250) Customer_ID
    CROSS JOIN
    (
        VALUES
        ('Visit'),
        ('Product View'),
        ('Add to Cart')
    ) AS E(Event_Type)

    UNION ALL

    -- 70 customers : Visit + Product View + Add to Cart + Checkout
    SELECT Customer_ID, Event_Type
    FROM generate_series(251,320) Customer_ID
    CROSS JOIN
    (
        VALUES
        ('Visit'),
        ('Product View'),
        ('Add to Cart'),
        ('Checkout')
    ) AS E(Event_Type)

    UNION ALL

    -- 180 customers : Complete Purchase
    SELECT Customer_ID, Event_Type
    FROM generate_series(321,500) Customer_ID
    CROSS JOIN
    (
        VALUES
        ('Visit'),
        ('Product View'),
        ('Add to Cart'),
        ('Checkout'),
        ('Purchase')
    ) AS E(Event_Type)

) AS X;
INSERT INTO Cart
(Cart_ID, Customer_ID, Product_ID, Quantity, Cart_Status)

SELECT
    gs AS Cart_ID,

    gs AS Customer_ID,

    floor(random() * 500 + 1)::INT AS Product_ID,

    floor(random() * 5 + 1)::INT AS Quantity,

    CASE
        WHEN random() < 0.4 THEN 'Purchased'
        WHEN random() < 0.7 THEN 'Abandoned'
        ELSE 'Active'
    END AS Cart_Status

FROM generate_series(1,500) AS gs;
INSERT INTO Orders
(Order_ID,
 Customer_ID,
 Product_ID,
 Order_Date,
 Order_Amount,
 Payment_Method,
 Payment_Status)

SELECT
    ROW_NUMBER() OVER () AS Order_ID,

    c.Customer_ID,

    c.Product_ID,

    DATE '2025-01-01' + floor(random() * 365)::INT AS Order_Date,

    (p.Price * c.Quantity)::DECIMAL(10,2) AS Order_Amount,

    CASE
        WHEN random() < 0.20 THEN 'UPI'
        WHEN random() < 0.40 THEN 'Credit Card'
        WHEN random() < 0.60 THEN 'Debit Card'
        WHEN random() < 0.80 THEN 'Net Banking'
        ELSE 'Cash on Delivery'
    END AS Payment_Method,

    CASE
        WHEN random() < 0.95 THEN 'Success'
        ELSE 'Failed'
    END AS Payment_Status

FROM Cart c
JOIN Products p
ON c.Product_ID = p.Product_ID

WHERE c.Cart_Status = 'Purchased';
INSERT INTO AB_Test
(Test_ID,
 Customer_ID,
 Test_Group,
 Version,
 Conversion_Status)

SELECT
    Customer_ID AS Test_ID,

    Customer_ID,

    CASE
        WHEN random() < 0.5 THEN 'Control'
        ELSE 'Test'
    END AS Test_Group,

    CASE
        WHEN random() < 0.5 THEN 'Old Checkout'
        ELSE 'New Checkout'
    END AS Version,

    CASE
        WHEN random() < 0.4 THEN 'Converted'
        ELSE 'Not Converted'
    END AS Conversion_Status

FROM generate_series(1,500) AS Customer_ID;
