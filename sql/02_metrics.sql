-- Изучаем данные и считаем метрики

-- Проверим базовую информацию о данных: количестве уникальных заказов, покупателей и продавцов
SELECT 
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers
FROM orders o;

SELECT 
	COUNT(DISTINCT s.seller_id) as total_sellers
FROM
	sellers s;

--1. Финансовые показатели

-- Средний чек (AOV) и количество товаров в заказе

SELECT 
    ROUND(SUM(oi.price) / COUNT(DISTINCT oi.order_id), 2) AS aov,
    ROUND(SUM(oi.price+ oi.freight_value ) / COUNT(DISTINCT oi.order_id), 2) AS aov_with_freight,
    ROUND(COUNT(oi.product_id) * 1.0 / COUNT(DISTINCT oi.order_id), 2) AS avg_items_per_order
FROM order_items oi;


-- Средняя выручка по месяцам
SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS month,
    ROUND(SUM(oi.price), 2) AS revenue,
    ROUND(SUM(oi.price + oi.freight_value ), 2) AS revenue_with_freight
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1;



-- 2. Лояльность покупателей

-- Retention rate
SELECT
    SUM(CASE WHEN orders_count > 1 THEN 1 ELSE 0 END) AS returning_customers,
    COUNT(*) AS total_customers,
    ROUND(100.0 * SUM(CASE WHEN orders_count > 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS retention_rate
FROM (
    SELECT customer_unique_id, COUNT(DISTINCT order_id) AS orders_count
    FROM orders
    JOIN customers USING(customer_id)
    GROUP BY customer_unique_id
) t;


-- Воронка заказов
SELECT 
    order_status,
    COUNT(*) AS orders_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS perc
FROM orders
WHERE order_status IN ('created','approved','shipped','delivered')
GROUP BY order_status
ORDER BY orders_count DESC;



--3. Качество сервиса

-- Доля доставленных заказов
SELECT 
    order_status,
    COUNT(*) AS count_orders,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM orders
GROUP BY order_status
ORDER BY 3 DESC;

-- Average review rate
SELECT
    ROUND(AVG(review_score), 2) AS avg_review_score
FROM order_reviews;










