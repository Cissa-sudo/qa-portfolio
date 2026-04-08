#queries.sql
  

-- =====================================
-- БАЗОВЫЕ ЗАПРОСЫ
-- =====================================

\\ Получить всех пользователей
SELECT * FROM users;

\\Получить только email и дату регистрации
SELECT email, created_at FROM users;

-- =====================================
-- ФИЛЬТРАЦИЯ
-- =====================================

\\Пользователи, зарегистрированные после 2024 года
SELECT * 
FROM users
WHERE created_at > '2024-01-01';

\\Товары дороже 100
SELECT name, price
FROM products
WHERE price > 100;

-- =====================================
-- СОРТИРОВКА
-- =====================================

\\Сортировка товаров по цене (убывание)
SELECT name, price
FROM products
ORDER BY price DESC;

-- =====================================
-- JOIN (ОБЯЗАТЕЛЬНО ДЛЯ СОБЕСА)
-- =====================================

\\Получить заказы с именами пользователей
SELECT users.name, orders.id, orders.total_price
FROM orders
JOIN users ON orders.user_id = users.id;

\\Получить товары в заказах
SELECT orders.id, products.name, order_items.quantity
FROM order_items
JOIN products ON order_items.product_id = products.id
JOIN orders ON order_items.order_id = orders.id;

-- =====================================
-- АГРЕГАЦИИ
-- =====================================

\\Общее количество заказов
SELECT COUNT(*) AS total_orders
FROM orders;

\\Средняя цена товара
SELECT AVG(price) AS avg_price
FROM products;

-- =====================================
-- GROUP BY
-- =====================================

\\Количество заказов по каждому пользователю
SELECT user_id, COUNT(*) AS orders_count
FROM orders
GROUP BY user_id;

\\Общая сумма заказов по пользователям
SELECT user_id, SUM(total_price) AS total_spent
FROM orders
GROUP BY user_id;

-- =====================================
-- HAVING (часто спрашивают)
-- =====================================

\\ Пользователи с более чем 5 заказами
SELECT user_id, COUNT(*) AS orders_count
FROM orders
GROUP BY user_id
HAVING COUNT(*) > 5;

-- =====================================
-- ПОДЗАПРОСЫ
-- =====================================

\\Пользователи, у которых есть заказы
SELECT name
FROM users
WHERE id IN (
    SELECT user_id FROM orders
);

\\ Самый дорогой товар
SELECT name, price
FROM products
WHERE price = (
    SELECT MAX(price) FROM products
);

-- =====================================
-- LEFT JOIN (важно понимать разницу)
-- =====================================

\\Все пользователи и их заказы (даже если заказов нет)
SELECT users.name, orders.id
FROM users
LEFT JOIN orders ON users.id = orders.user_id;

-- =====================================
-- CASE WHEN (плюс к уровню)
-- =====================================

\\Классификация товаров по цене
SELECT name, price,
CASE
    WHEN price < 50 THEN 'Дешёвый'
    WHEN price BETWEEN 50 AND 200 THEN 'Средний'
    ELSE 'Дорогой'
END AS price_category
FROM products;

-- =====================================
-- LIMIT
-- =====================================

\\Топ-5 самых дорогих товаров
SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- =====================================
-- ПРОВЕРКА НА NULL
-- =====================================

\\Заказы без пользователя (ошибка данных)
SELECT *
FROM orders
WHERE user_id IS NULL;
