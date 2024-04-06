-- AUTOCOMMIT, COMMIT, ROLLBACK
SET AUTOCOMMIT = OFF;

ROLLBACK; -- if autocommit is off we can rollback to previous changes
COMMIT; -- if autocommit is off and we wanna save the changes

-- this is just test table ignore it
CREATE TABLE test (
  my_date DATE,
  my_time TIME,
  my_datetime DATETIME
);

-- how to work with dates
INSERT INTO test VALUES (CURRENT_DATE(), CURRENT_TIME(), NOW());
INSERT INTO test VALUES (CURRENT_DATE() + 1, NULL, NULL); -- + 1 on CURRENT_DATE function adds one day to it
DROP TABLE test; -- bye bye

SELECT * FROM test;

-- i know this but still working on UNIQUE data types
CREATE TABLE products (
  product_id INT,
  product_name VARCHAR(25) UNIQUE -- ensures that product_name is unique in the database,
  price DECIMAL(4, 2),
);

-- let's say we forgot to add our constraint a column.
ALTER TABLE products ADD CONSTRAINT UNIQUE(product_name);
SELECT * FROM products;

INSERT INTO products -- checking unique constraint
VALUES (100, 'hamburger', 3.99),
       (101, 'fries', 1.89),
       (102, 'soda', 1.00),
       (103, 'ice cream', 1.49);
SELECT * FROM products;       

-- NOT NULL constraint - i already know this but will still leave it here
CREATE TABLE required (
  age INT NOT NULL,
  name VARCHAR(35) NOT NULL,  
);

ALTER TABLE products
MODIFY price DECIMAL(4, 2) NOT NULL; -- unlike one we did with the unique here u have to be very specific and use MODIFY

INSERT INTO required VALUES (10, NULL); -- this would give me an error cause name can't be null

-- CHECK 

CREATE TABLE checkEmployees (
  employee_id INT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  hourly_pay DECIMAL(5, 2),
  hire_date DATE,
  CONSTRAINT chk_hourly_pay CHECK (hourly_pay > 10.00) -- this creates accessible constraint
);

INSERT INTO checkEmployees (hourly_pay) VALUES (9.9); -- this doesn't pass the chk_hourly_pay constraint cause pay must be more than 10

-- to add constraint to the column if we forgot to add it when we created our table
ALTER TABLE checkEmployees
ADD CONSTRAINT chk_hourly_pay CHECK (hourly_pay >= 10);

-- DEFAULT
INSERT INTO products
VALUES (104, 'straw', 0.00),
	     (105, "napkin", 0.00),
       (106, "fork", 0.00),
       (107, "spoon", 0.00);
-- lets's say we wanted default to be 0 if we didn't include price on insert

CREATE TABLE products (
  product_id INT,
  product_name VARCHAR(25),
  price DECIMAL(4, 2) DEFAULT 0
);

-- this if we forgot to add the default value while creating a table
ALTER TABLE products
ALTER price SET DEFAULT 0;

-- not inserting the value for price so default is 0.00
INSERT INTO products (product_id, product_name)
VALUES (104, 'straw'),
       (105, 'napkin'),
       (106, 'fork'),
       (107, 'spoon');


-- example with transactions table
CREATE TABLE transactions (
  transaction_id INT,
  amount DECIMAL(5, 2),
  transaction_date DATETIME DEFAULT NOW()
);

INSERT INTO transactions (transaction_id, amount)
VALUES (1, 4.99);

SELECT * FROM transactions -- right here default value for transaction_date is today

-- PRIMARY KEYS
CREATE TABLE  transactions (
  transaction_id INT PRIMARY KEY,
  amount DECIMAL(5, 2)  
);

-- Add a primary key constraint if we forgot
ALTER TABLE transactions
ADD CONSTRAINT
PRIMARY KEY(transaction_id);

-- AUTO_INCREMENT
CREATE TABLE transactions (
  transaction_id INT PRIMARY KEY AUTO_INCREMENT,
  amount DECIMAL(5, 2),
);

-- here id gets incremented by 1 every time we insert a column
INSERT INTO transactions (amount)
VALUES (4.99);

DELETE * FROM transactions

-- right here all we do is tell sql to start incrementing for 1000
ALTER TABLE transactions
AUTO_INCREMENT = 1000;

-- now every time we insert a column id starts to increment from 1000 and on every insert increments by 1 as default
INSERT INTO transactions (amount)
VALUES (2.89);


-- FOREIGN KEYS

CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50),
  last_name VARCHAR(50)
);

INSERT INTO customers (first_name, last_name)
VALUES ('Fred', 'Fish'),
       ('Larry', 'Lobster'),
       ('Bubble', 'Bass');


-- create a foreign key that references the customer_id column from customers table
CREATE TABLE transactions (
  transaction_id INT PRIMARY KEY AUTO_INCREMENT,
  amount DECIMAL(5, 2),
  customer_id INT,
  FOREIGN KEY(customer_id) REFERENCES customers (customer_id)
);

-- how to drop a foreign key
ALTER TABLE transactions
DROP FOREIGN KEY transactions_ibfk_1;

-- how to add FOREIGN KEY constraint
ALTER TABLE transactions
ADD CONSTRAINT fk_customer_id -- CONSTRAINT naming is optional
FOREIGN KEY (customer_id) REFERENCES customers (customer_id);

DELETE FROM transactions; -- just to restart

-- make auto_increment start from 1000
ALTER TABLE transactions 
AUTO_INCREMENT = 1000;

-- let's insert some rows in to the customers table
INSERT INTO customers (first_name, last_name) 
VALUES ('Dave', 'Gray'),
       ('John', 'Fish'),
       ('Fred', 'Jill'); 

-- if we gave customer_id that does not exist in customers table it would give us an error
INSERT INTO transactions (amount, customer_id)
VALUES (4.99, 3),
       (2.89, 2),
       (3.38, 3),
       (4.99, 1);

-- JOINS 

INSERT INTO transactions (amount, customer_id)
VALUES (1.00, NULL);

INSERT INTO customers (first_name, last_name)
VALUES ('Poppy', 'Puff');
SELECT * FROM customers