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
CREATE TABLE require (
  age INT NOT NULL,
  name VARCHAR(35) NOT NULL,  
)