INSERT INTO customer (name, phone, email, address)
VALUES
('Ali Khan', '03001234567', 'ali@gmail.com', 'Lahore'),
('Sara Ahmed', '03111234567', 'sara@gmail.com', 'Islamabad'),
('Usman Tariq', '03221234567', 'usman@gmail.com', 'Karachi'),
('Ayesha Malik', '03331234567', 'ayesha@gmail.com', 'Faisalabad'),
('Bilal Hussain', '03441234567', 'bilal@gmail.com', 'Multan');

INSERT INTO restaurant (restaurant_name, address, phone)
VALUES
('Pizza House', 'Lahore', '0421234567'),
('Burger Hub', 'Islamabad', '0511234567'),
('BBQ Express', 'Karachi', '0211234567');

INSERT INTO delivery_agents (name, phone, vehicle_type)
VALUES
('Hamza Ali', '03009998888', 'Bike'),
('Ahmed Raza', '03119997777', 'Bike'),
('Zain Khan', '03229996666', 'Car');

INSERT INTO menu_items (restaurant_id, item_name, price)
VALUES
(1, 'Chicken Pizza', 1500),
(1, 'Cheese Pizza', 1800),
(1, 'Garlic Bread', 500),

(2, 'Zinger Burger', 700),
(2, 'Beef Burger', 900),
(2, 'French Fries', 300),

(3, 'Chicken Boti', 800),
(3, 'Seekh Kebab', 600),
(3, 'Malai Tikka', 950),
(3, 'Raita', 150);

INSERT INTO orders (customer_id, total_amount, status)
VALUES
(1, 2200, 'Delivered'),
(2, 700, 'Delivered'),
(3, 1750, 'Out for Delivery'),
(4, 1200, 'Preparing'),
(5, 950, 'Pending');

INSERT INTO order_details (order_id, item_id, quantity, subtotal)
VALUES
(1, 1, 1, 1500),
(1, 6, 1, 300),
(1, 10, 2, 300),

(2, 4, 1, 700),

(3, 9, 1, 950),
(3, 8, 1, 600),
(3, 10, 1, 150),

(4, 7, 1, 800),
(4, 6, 1, 300),
(4, 10, 1, 100),

(5, 9, 1, 950);

INSERT INTO payments (order_id, payment_method, amount)
VALUES
(1, 'Credit Card', 2200),
(2, 'Cash', 700),
(3, 'JazzCash', 1750),
(4, 'Easypaisa', 1200),
(5, 'Debit Card', 950);

INSERT INTO reviews (customer_id, restaurant_id, rating, comment) VALUES
(1, 1, 5, 'Amazing food and excellent taste!'),
(2, 1, 4, 'Very good food but slightly expensive.'),
(3, 2, 5, 'Best restaurant experience so far!'),
(4, 3, 3, 'Food was average, can improve quality.'),
(5, 2, 4, 'Nice taste and good service.');

INSERT INTO reviews (customer_id, agent_id, rating, comment) VALUES
(1, 1, 5, 'Very fast and polite delivery agent.'),
(2, 2, 4, 'Good service, delivered on time.'),
(3, 1, 5, 'Excellent behavior and quick delivery!'),
(4, 3, 3, 'Delivery was a bit late.'),
(5, 2, 4, 'Friendly and professional rider.');

INSERT INTO reviews (customer_id, order_id, rating, comment) VALUES
(1, 1, 5, 'Everything in the order was perfect!'),
(2, 2, 4, 'Good order but one item was missing initially.'),
(3, 3, 5, 'Perfect packaging and fresh food.'),
(4, 4, 3, 'Order was okay but not hot enough.'),
(5, 5, 4, 'Overall good experience.');