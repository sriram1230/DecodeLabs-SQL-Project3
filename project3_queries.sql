-- DecodeLabs Industrial Training Kit - Project 3: SQL Data Analysis
-- Table: orders (1,200 records)

-- 1. High-Volume Shipped Orders
SELECT 
    OrderID,
    Date,
    CustomerID,
    Product,
    Quantity,
    UnitPrice,
    TotalPrice,
    PaymentMethod,
    OrderStatus
FROM orders
WHERE OrderStatus = 'Shipped' AND Quantity >= 4
ORDER BY TotalPrice DESC
LIMIT 10;

-- 2. Product Performance Summary
SELECT 
    Product,
    COUNT(OrderID) AS total_orders,
    SUM(Quantity) AS total_units_sold,
    ROUND(AVG(UnitPrice), 2) AS avg_unit_price,
    ROUND(SUM(TotalPrice), 2) AS gross_revenue,
    ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY Product
ORDER BY gross_revenue DESC;

-- 3. Fulfillment Leakage Analysis
SELECT 
    Product,
    OrderStatus,
    COUNT(OrderID) AS order_count,
    ROUND(SUM(TotalPrice), 2) AS lost_or_pending_revenue
FROM orders
WHERE OrderStatus IN ('Returned', 'Cancelled')
GROUP BY Product, OrderStatus
ORDER BY lost_or_pending_revenue DESC;

-- 4. Acquisition Channel Filtering (HAVING)
SELECT 
    ReferralSource,
    COUNT(OrderID) AS total_transactions,
    ROUND(SUM(TotalPrice), 2) AS channel_revenue,
    ROUND(AVG(TotalPrice), 2) AS average_order_value
FROM orders
GROUP BY ReferralSource
HAVING COUNT(OrderID) >= 200 AND SUM(TotalPrice) > 200000
ORDER BY channel_revenue DESC;

-- 5. Promotional Impact Evaluation
SELECT 
    COALESCE(CouponCode, 'NO_COUPON') AS coupon_tier,
    COUNT(OrderID) AS usage_count,
    ROUND(AVG(ItemsInCart), 2) AS avg_items_in_cart,
    ROUND(AVG(Quantity), 2) AS avg_quantity_per_order,
    ROUND(SUM(TotalPrice), 2) AS gross_sales,
    ROUND(AVG(TotalPrice), 2) AS aov
FROM orders
GROUP BY COALESCE(CouponCode, 'NO_COUPON')
ORDER BY gross_sales DESC;
