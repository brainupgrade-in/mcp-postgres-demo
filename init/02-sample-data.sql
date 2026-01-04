-- MCP + PostgreSQL Demo - Sample Data
-- Video 5: MCP Masterclass by Gheware DevOps AI

-- Insert categories
INSERT INTO categories (name, description) VALUES
('Electronics', 'Electronic devices and accessories'),
('Clothing', 'Apparel and fashion items'),
('Books', 'Physical and digital books'),
('Home & Garden', 'Home improvement and garden supplies'),
('Sports', 'Sports equipment and accessories');

-- Insert products
INSERT INTO products (name, category_id, price, stock_quantity, description) VALUES
-- Electronics
('Wireless Headphones', 1, 79.99, 150, 'Bluetooth over-ear headphones with noise cancellation'),
('USB-C Hub', 1, 49.99, 200, '7-in-1 USB-C hub with HDMI and SD card slots'),
('Mechanical Keyboard', 1, 129.99, 75, 'RGB mechanical keyboard with Cherry MX switches'),
('Webcam HD', 1, 89.99, 100, '1080p HD webcam with built-in microphone'),
('Portable Charger', 1, 39.99, 300, '20000mAh portable power bank'),
-- Clothing
('Cotton T-Shirt', 2, 24.99, 500, 'Premium cotton crew neck t-shirt'),
('Denim Jeans', 2, 59.99, 250, 'Classic fit denim jeans'),
('Running Shoes', 2, 89.99, 180, 'Lightweight running shoes with cushioning'),
('Winter Jacket', 2, 149.99, 80, 'Insulated winter jacket with hood'),
('Baseball Cap', 2, 19.99, 400, 'Adjustable cotton baseball cap'),
-- Books
('Python Programming', 3, 44.99, 120, 'Complete guide to Python programming'),
('DevOps Handbook', 3, 54.99, 90, 'Best practices for DevOps implementation'),
('Kubernetes Guide', 3, 49.99, 85, 'Mastering Kubernetes orchestration'),
('Docker Deep Dive', 3, 39.99, 110, 'Comprehensive Docker container guide'),
('AI Fundamentals', 3, 59.99, 70, 'Introduction to artificial intelligence'),
-- Home & Garden
('Garden Tools Set', 4, 34.99, 150, '5-piece stainless steel garden tool set'),
('Smart Thermostat', 4, 199.99, 45, 'WiFi-enabled programmable thermostat'),
('LED Desk Lamp', 4, 29.99, 200, 'Adjustable LED desk lamp with USB port'),
('Air Purifier', 4, 149.99, 60, 'HEPA air purifier for rooms up to 500 sq ft'),
('Coffee Maker', 4, 79.99, 120, '12-cup programmable coffee maker'),
-- Sports
('Yoga Mat', 5, 29.99, 250, 'Non-slip exercise yoga mat'),
('Dumbbells Set', 5, 99.99, 80, 'Adjustable dumbbell set 5-25 lbs'),
('Fitness Tracker', 5, 69.99, 150, 'Water-resistant fitness tracker with heart rate'),
('Tennis Racket', 5, 89.99, 60, 'Professional grade tennis racket'),
('Basketball', 5, 34.99, 100, 'Official size indoor/outdoor basketball');

-- Insert customers
INSERT INTO customers (name, email, city, country) VALUES
('John Smith', 'john.smith@email.com', 'New York', 'USA'),
('Sarah Johnson', 'sarah.j@email.com', 'Los Angeles', 'USA'),
('Michael Brown', 'mbrown@email.com', 'Chicago', 'USA'),
('Emily Davis', 'emily.d@email.com', 'Houston', 'USA'),
('David Wilson', 'dwilson@email.com', 'Phoenix', 'USA'),
('Lisa Anderson', 'lisa.a@email.com', 'Philadelphia', 'USA'),
('James Taylor', 'jtaylor@email.com', 'San Antonio', 'USA'),
('Jennifer Martinez', 'jmartinez@email.com', 'San Diego', 'USA'),
('Robert Garcia', 'rgarcia@email.com', 'Dallas', 'USA'),
('Amanda Lee', 'alee@email.com', 'San Jose', 'USA'),
('Christopher White', 'cwhite@email.com', 'Austin', 'USA'),
('Jessica Harris', 'jharris@email.com', 'Jacksonville', 'USA'),
('Daniel Clark', 'dclark@email.com', 'San Francisco', 'USA'),
('Michelle Lewis', 'mlewis@email.com', 'Columbus', 'USA'),
('Matthew Robinson', 'mrobinson@email.com', 'Charlotte', 'USA'),
('Ashley Walker', 'awalker@email.com', 'Seattle', 'USA'),
('Andrew Hall', 'ahall@email.com', 'Denver', 'USA'),
('Stephanie Allen', 'sallen@email.com', 'Boston', 'USA'),
('Joshua Young', 'jyoung@email.com', 'Nashville', 'USA'),
('Nicole King', 'nking@email.com', 'Portland', 'USA');

-- Insert orders (spanning last 6 months)
INSERT INTO orders (customer_id, order_date, status, total_amount, shipping_address) VALUES
-- Recent orders (last month)
(1, CURRENT_DATE - INTERVAL '5 days', 'delivered', 259.97, '123 Main St, New York, NY'),
(2, CURRENT_DATE - INTERVAL '7 days', 'delivered', 149.99, '456 Oak Ave, Los Angeles, CA'),
(3, CURRENT_DATE - INTERVAL '10 days', 'delivered', 89.99, '789 Pine Rd, Chicago, IL'),
(4, CURRENT_DATE - INTERVAL '12 days', 'shipped', 199.98, '321 Elm St, Houston, TX'),
(5, CURRENT_DATE - INTERVAL '15 days', 'delivered', 79.99, '654 Maple Dr, Phoenix, AZ'),
(6, CURRENT_DATE - INTERVAL '18 days', 'delivered', 324.96, '987 Cedar Ln, Philadelphia, PA'),
(7, CURRENT_DATE - INTERVAL '20 days', 'delivered', 134.98, '147 Birch Way, San Antonio, TX'),
(8, CURRENT_DATE - INTERVAL '22 days', 'pending', 89.99, '258 Spruce Ct, San Diego, CA'),
-- Last 2 months
(9, CURRENT_DATE - INTERVAL '35 days', 'delivered', 179.97, '369 Willow Pl, Dallas, TX'),
(10, CURRENT_DATE - INTERVAL '40 days', 'delivered', 249.98, '741 Ash Blvd, San Jose, CA'),
(11, CURRENT_DATE - INTERVAL '45 days', 'delivered', 99.99, '852 Hickory St, Austin, TX'),
(12, CURRENT_DATE - INTERVAL '50 days', 'delivered', 189.98, '963 Walnut Ave, Jacksonville, FL'),
(1, CURRENT_DATE - INTERVAL '55 days', 'delivered', 279.97, '123 Main St, New York, NY'),
(2, CURRENT_DATE - INTERVAL '60 days', 'delivered', 159.98, '456 Oak Ave, Los Angeles, CA'),
-- Last 3 months
(13, CURRENT_DATE - INTERVAL '70 days', 'delivered', 219.97, '159 Cherry Rd, San Francisco, CA'),
(14, CURRENT_DATE - INTERVAL '75 days', 'delivered', 89.99, '357 Peach Ln, Columbus, OH'),
(15, CURRENT_DATE - INTERVAL '80 days', 'delivered', 329.96, '468 Apple Way, Charlotte, NC'),
(16, CURRENT_DATE - INTERVAL '85 days', 'delivered', 149.99, '579 Grape Dr, Seattle, WA'),
(3, CURRENT_DATE - INTERVAL '90 days', 'delivered', 199.98, '789 Pine Rd, Chicago, IL'),
-- Last 4-6 months
(17, CURRENT_DATE - INTERVAL '100 days', 'delivered', 269.97, '680 Berry Ct, Denver, CO'),
(18, CURRENT_DATE - INTERVAL '110 days', 'delivered', 179.98, '791 Melon Pl, Boston, MA'),
(19, CURRENT_DATE - INTERVAL '120 days', 'delivered', 139.98, '802 Lemon Blvd, Nashville, TN'),
(20, CURRENT_DATE - INTERVAL '130 days', 'delivered', 209.97, '913 Orange St, Portland, OR'),
(4, CURRENT_DATE - INTERVAL '140 days', 'delivered', 99.99, '321 Elm St, Houston, TX'),
(5, CURRENT_DATE - INTERVAL '150 days', 'delivered', 289.96, '654 Maple Dr, Phoenix, AZ'),
(6, CURRENT_DATE - INTERVAL '160 days', 'delivered', 169.98, '987 Cedar Ln, Philadelphia, PA'),
(7, CURRENT_DATE - INTERVAL '170 days', 'delivered', 119.98, '147 Birch Way, San Antonio, TX'),
(8, CURRENT_DATE - INTERVAL '180 days', 'delivered', 239.97, '258 Spruce Ct, San Diego, CA');

-- Insert order items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- Order 1: John Smith
(1, 1, 1, 79.99), (1, 3, 1, 129.99), (1, 5, 1, 39.99),
-- Order 2: Sarah Johnson
(2, 9, 1, 149.99),
-- Order 3: Michael Brown
(3, 8, 1, 89.99),
-- Order 4: Emily Davis
(4, 17, 1, 199.99),
-- Order 5: David Wilson
(5, 1, 1, 79.99),
-- Order 6: Lisa Anderson
(6, 3, 1, 129.99), (6, 4, 1, 89.99), (6, 11, 1, 44.99), (6, 12, 1, 54.99),
-- Order 7: James Taylor
(7, 21, 1, 29.99), (7, 22, 1, 99.99),
-- Order 8: Jennifer Martinez
(8, 8, 1, 89.99),
-- Order 9: Robert Garcia
(9, 2, 1, 49.99), (9, 3, 1, 129.99),
-- Order 10: Amanda Lee
(10, 17, 1, 199.99), (10, 2, 1, 49.99),
-- Order 11: Christopher White
(11, 22, 1, 99.99),
-- Order 12: Jessica Harris
(12, 1, 1, 79.99), (12, 13, 1, 49.99), (12, 14, 1, 39.99),
-- Order 13: John Smith again
(13, 9, 1, 149.99), (13, 3, 1, 129.99),
-- Order 14: Sarah Johnson again
(14, 6, 2, 24.99), (14, 10, 2, 19.99), (14, 21, 1, 29.99),
-- Order 15: Daniel Clark
(15, 11, 1, 44.99), (15, 12, 1, 54.99), (15, 13, 1, 49.99), (15, 14, 1, 39.99), (15, 15, 1, 59.99),
-- Order 16: Michelle Lewis
(16, 4, 1, 89.99),
-- Order 17: Matthew Robinson
(17, 3, 1, 129.99), (17, 17, 1, 199.99),
-- Order 18: Ashley Walker
(18, 9, 1, 149.99),
-- Order 19: Michael Brown again
(19, 1, 1, 79.99), (19, 18, 1, 29.99), (19, 21, 1, 29.99),
-- Order 20: Andrew Hall
(20, 2, 1, 49.99), (20, 4, 1, 89.99), (20, 18, 1, 29.99), (20, 22, 1, 99.99),
-- Order 21: Stephanie Allen
(21, 1, 1, 79.99), (21, 8, 1, 89.99), (21, 22, 1, 99.99),
-- Order 22: Joshua Young
(22, 6, 2, 24.99), (22, 7, 1, 59.99), (22, 10, 2, 19.99),
-- Order 23: Nicole King
(23, 4, 1, 89.99), (23, 5, 1, 39.99),
-- Order 24: Emily Davis again
(24, 15, 1, 59.99), (24, 21, 1, 29.99),
-- Order 25: David Wilson again
(25, 3, 1, 129.99), (25, 9, 1, 149.99),
-- Order 26: Lisa Anderson again
(26, 8, 1, 89.99), (26, 1, 1, 79.99),
-- Order 27: James Taylor again
(27, 6, 2, 24.99), (27, 23, 1, 69.99),
-- Order 28: Jennifer Martinez again
(28, 17, 1, 199.99), (28, 5, 1, 39.99);

-- Update order totals based on items
UPDATE orders o SET total_amount = (
    SELECT COALESCE(SUM(subtotal), 0) FROM order_items WHERE order_id = o.id
);
