-- Sample data: fictional retail business. IDs are explicit for reproducibility.
INSERT INTO regions(region_id, region_name) VALUES
(1,'Kigali'), (2,'Northern'), (3,'Eastern');

INSERT INTO branches(branch_id, branch_name, region_id, city) VALUES
(1,'Kigali Central',1,'Kigali'),
(2,'Kimironko',1,'Kigali'),
(3,'Musanze Branch',2,'Musanze'),
(4,'Rwamagana Branch',3,'Rwamagana'),
(5,'Nyagatare Branch',3,'Nyagatare'); -- intentionally has no sales

INSERT INTO employees(employee_id, employee_name, job_title, branch_id, manager_id, hire_date, performance_score) VALUES
(1,'Aline Mukamana','Regional Manager',1,NULL,'2021-02-10',94.00),
(2,'Jean Niyonzima','Branch Manager',1,1,'2022-04-15',89.00),
(3,'Grace Uwase','Sales Officer',2,2,'2023-01-20',86.00),
(4,'Eric Habimana','Branch Manager',3,1,'2022-08-01',91.00),
(5,'Diane Ingabire','Sales Officer',4,1,'2023-05-12',82.00);

INSERT INTO customers(customer_id, customer_name, email, region_id, registration_date) VALUES
(1,'Customer A','a@example.com',1,'2024-01-10'),
(2,'Customer B','b@example.com',1,'2024-02-11'),
(3,'Customer C','c@example.com',2,'2024-03-12'),
(4,'Customer D','d@example.com',2,'2024-04-13'),
(5,'Customer E','e@example.com',3,'2024-05-14'),
(6,'Customer F','f@example.com',3,'2024-06-15'),
(7,'Customer G','g@example.com',1,'2024-07-16'); -- intentionally has no purchases

INSERT INTO products(product_id, product_name, category, unit_price) VALUES
(1,'Laptop','Electronics',850.00),
(2,'Smartphone','Electronics',450.00),
(3,'Office Chair','Furniture',120.00),
(4,'Desk','Furniture',210.00),
(5,'Printer','Electronics',180.00),
(6,'Notebook Pack','Stationery',15.00);

INSERT INTO sales(sale_id, customer_id, branch_id, employee_id, sale_date, status) VALUES
(1,1,1,2,'2025-01-15','COMPLETED'),
(2,2,1,2,'2025-01-25','COMPLETED'),
(3,3,3,4,'2025-02-10','COMPLETED'),
(4,1,2,3,'2025-02-18','COMPLETED'),
(5,4,3,4,'2025-03-05','COMPLETED'),
(6,5,4,5,'2025-03-20','COMPLETED'),
(7,2,1,2,'2025-04-12','COMPLETED'),
(8,6,4,5,'2025-04-22','COMPLETED'),
(9,3,3,4,'2025-05-11','COMPLETED'),
(10,1,2,3,'2025-05-28','COMPLETED'),
(11,5,4,5,'2025-06-09','COMPLETED'),
(12,4,3,4,'2025-06-21','COMPLETED'),
(13,2,1,2,'2025-07-03','PENDING');

INSERT INTO sale_items(sale_item_id, sale_id, product_id, quantity, unit_price) VALUES
(1,1,1,1,850),(2,1,6,2,15),
(3,2,2,2,450),(4,2,5,1,180),
(5,3,3,2,120),(6,3,6,5,15),
(7,4,4,1,210),(8,4,2,1,450),
(9,5,1,1,850),(10,5,3,1,120),
(11,6,5,2,180),(12,6,6,10,15),
(13,7,2,1,450),(14,7,4,2,210),
(15,8,1,1,850),(16,8,5,1,180),
(17,9,3,3,120),(18,9,6,4,15),
(19,10,1,1,850),(20,10,2,1,450),
(21,11,4,1,210),(22,11,5,1,180),
(23,12,2,2,450),(24,12,6,6,15),
(25,13,1,1,850);

-- Reset identity sequences after explicit ID inserts.
SELECT setval(pg_get_serial_sequence('regions','region_id'), (SELECT MAX(region_id) FROM regions));
SELECT setval(pg_get_serial_sequence('branches','branch_id'), (SELECT MAX(branch_id) FROM branches));
SELECT setval(pg_get_serial_sequence('employees','employee_id'), (SELECT MAX(employee_id) FROM employees));
SELECT setval(pg_get_serial_sequence('customers','customer_id'), (SELECT MAX(customer_id) FROM customers));
SELECT setval(pg_get_serial_sequence('products','product_id'), (SELECT MAX(product_id) FROM products));
SELECT setval(pg_get_serial_sequence('sales','sale_id'), (SELECT MAX(sale_id) FROM sales));
SELECT setval(pg_get_serial_sequence('sale_items','sale_item_id'), (SELECT MAX(sale_item_id) FROM sale_items));
