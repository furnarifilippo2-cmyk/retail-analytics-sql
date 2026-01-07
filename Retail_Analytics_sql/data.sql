/* INSERT DATA */

INSERT INTO customers
(first_name, last_name, gender, birth_date, country, city, signup_date)
VALUES
('Mario', 'Rossi', 'M', '1985-04-12', 'Italy', 'Rome', '2021-01-15'),
('Luigi', 'Bianchi', 'M', '1990-06-23', 'Italy', 'Milan', '2021-03-10'),
('Anna', 'Verdi', 'F', '1992-11-02', 'Italy', 'Turin', '2021-05-20'),
('Sara', 'Neri', 'F', '1988-02-14', 'Italy', 'Bologna', '2021-07-05'),
('Marco', 'Gialli', 'M', '1979-09-30', 'Italy', 'Naples', '2021-09-18');

INSERT INTO products
(product_name, category, subcategory, price, cost)
VALUES
('Laptop Pro 15', 'Electronics', 'Computers', 1500, 1100),
('Smartphone X', 'Electronics', 'Mobile', 900, 650),
('Wireless Headphones', 'Electronics', 'Audio', 200, 120),
('Office Chair', 'Furniture', 'Office', 300, 180),
('Standing Desk', 'Furniture', 'Office', 600, 400);

INSERT INTO orders
(customer_id, order_date, status, payment_method)
VALUES
(1, '2022-01-10', 'Completed', 'Credit Card'),
(2, '2022-01-15', 'Completed', 'PayPal'),
(3, '2022-02-05', 'Completed', 'Credit Card'),
(1, '2022-02-20', 'Completed', 'Debit Card'),
(4, '2022-03-12', 'Completed', 'Credit Card');

INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 1500),
(1, 3, 1, 200),
(2, 2, 1, 900),
(3, 4, 1, 300),
(4, 5, 1, 600),
(5, 3, 2, 200);

INSERT INTO marketing_campaigns
(campaign_name, channel, start_date, end_date)
VALUES
('Winter Sale', 'Email', '2021-12-01', '2022-01-31'),
('Spring Promo', 'Social Media', '2022-03-01', '2022-04-15');

INSERT INTO customer_campaigns
(customer_id, campaign_id)
VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2);

INSERT INTO returns
(order_item_id, return_date, reason)
VALUES
(2, '2022-01-20', 'Product defective'),
(4, '2022-02-10', 'Wrong size'),
(6, '2022-03-20', 'Changed mind');



