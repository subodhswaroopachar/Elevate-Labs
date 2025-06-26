CREATE DATABASE ECommerceDB;
USE ECommerceDB;

CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Address TEXT
);

CREATE TABLE Category (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT
);

CREATE TABLE Product (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL,
    StockQty INT DEFAULT 0,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE OrderItem (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- Insert into Category
INSERT INTO Category (Name, Description) VALUES 
('Electronics', 'Smart devices and accessories'),
('Books', NULL),  -- NULL description
('Clothing', 'Men and women apparel');

-- Insert into Customer
INSERT INTO Customer (Name, Email, Phone, Address) VALUES
('Alice Singh', 'alice@example.com', '9876543210', 'Delhi, India'),
('Bob Patel', 'bob@example.com', NULL, 'Mumbai, India'), -- NULL phone
('Carol Khan', 'carol@example.com', '8899776655', NULL); -- NULL address

-- Insert into Product
INSERT INTO Product (Name, Description, Price, StockQty, CategoryID) VALUES
('Smartphone', 'Latest Android smartphone', 19999.99, 100, 1),
('USB Cable', 'Fast charging cable', 299.00, 500, 1),
('Fiction Book', NULL, 499.00, 100, 2), -- NULL description
('T-Shirt', 'Cotton round-neck', 399.50, 200, 3);

-- Insert into Orders
INSERT INTO Orders (CustomerID, OrderDate, Status) VALUES
(1, NOW(), 'Shipped'),
(2, NOW(), 'Pending');

-- Insert into OrderItem
INSERT INTO OrderItem (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 19999.99),
(1, 2, 2, 299.00),
(2, 4, 3, 399.50);

-- Insert into Payment
INSERT INTO Payment (OrderID, PaymentDate, Amount, PaymentMethod) VALUES
(1, NOW(), 20597.99, 'Credit Card'),
(2, NOW(), 1198.50, 'Cash on Delivery');

-- Add phone number for Bob
UPDATE Customer
SET Phone = '9988776655'
WHERE Name = 'Bob Patel';

-- Update Product description that was NULL
UPDATE Product
SET Description = 'Popular fiction novel'
WHERE Name = 'Fiction Book';

-- Set order status to 'Delivered'
UPDATE Orders
SET Status = 'Delivered'
WHERE OrderID = 1;
-- Delete a customer with no orders (example only, adjust ID as needed)
DELETE FROM Customer
WHERE CustomerID = 4;

-- Delete a product with stock = 0 (simulate out-of-stock cleanup)
DELETE FROM Product
WHERE StockQty = 0;

-- All customers
SELECT * FROM Customer;

-- All products
SELECT * FROM Product;

-- Product names and prices
SELECT Name, Price FROM Product;

-- Customer names and email
SELECT Name, Email FROM Customer;

-- Products with price greater than 1000
SELECT * FROM Product
WHERE Price > 1000;

-- Customers from Delhi or Mumbai
SELECT * FROM Customer
WHERE Address LIKE '%Delhi%' OR Address LIKE '%Mumbai%';

-- Products with "shirt" in the name (case-insensitive)
SELECT * FROM Product
WHERE Name LIKE '%shirt%';

-- Products with price between 300 and 2000
SELECT * FROM Product
WHERE Price BETWEEN 300 AND 2000;

-- Orders with specific statuses
SELECT * FROM Orders
WHERE Status IN ('Shipped', 'Delivered');

-- Sort products by price (low to high)
SELECT * FROM Product
ORDER BY Price ASC;

-- Sort customers by name (Z to A)
SELECT * FROM Customer
ORDER BY Name DESC;

-- Get only 3 cheapest products
SELECT * FROM Product
ORDER BY Price ASC
LIMIT 3;

-- Get the latest 2 orders
SELECT * FROM Orders
ORDER BY OrderDate DESC
LIMIT 2;

