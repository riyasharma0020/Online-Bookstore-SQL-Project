-- Online Bookstore Database Project
-- Author: Riya Sharma
-- Description: This project manages books, customers, and orders in an online bookstore.
-- It demonstrates SQL skills including table creation, data import, and analytical queries.

-- ========================
-- 1. Drop Tables if Exist
-- ========================
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Books;

-- ========================
-- 2. Create Tables
-- ========================
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

-- ========================
-- 3. Import Data from CSV
-- ========================
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'C:/OnlineBookStore/Books.csv' 
DELIMITER ',' CSV HEADER;

TRUNCATE TABLE Customers RESTART IDENTITY CASCADE;
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'C:/OnlineBookStore/Customers.csv' 
DELIMITER ',' CSV HEADER;

COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'C:/OnlineBookStore/Orders.csv' 
DELIMITER ',' CSV HEADER;

-- ========================
-- 4. Analytical Queries
-- ========================

-- Q1: List all Fiction books
SELECT * FROM Books WHERE Genre = 'Fiction';

-- Q2: Orders placed in November 2023
SELECT * FROM Orders 
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- Q3: Total stock available
SELECT SUM(Stock) AS total_stock FROM Books;

-- Q4: Most expensive book
SELECT * FROM Books ORDER BY Price DESC LIMIT 1;

-- Q5: Orders with more than 1 quantity
SELECT * FROM Orders WHERE Quantity > 1;

-- Q6: Distinct genres available
SELECT DISTINCT Genre FROM Books;

-- Q7: Book with lowest stock
SELECT * FROM Books ORDER BY Stock ASC LIMIT 1;

-- Q8: Total revenue generated
SELECT SUM(Total_Amount) AS total_revenue FROM Orders;

-- Q9: Genre-wise total books sold
SELECT b.Genre, SUM(o.Quantity) AS total_books_sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Genre;

-- Q10: Average price of Fantasy books
SELECT AVG(Price) AS avg_fantasy_price 
FROM Books 
WHERE Genre = 'Fantasy';

-- Q11: Customers with at least 2 orders
SELECT o.Customer_ID, c.Name, COUNT(o.Order_ID) AS order_count
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY o.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

-- Q12: Most frequently ordered book
SELECT o.Book_ID, b.Title, COUNT(o.Order_ID) AS order_count
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title
ORDER BY order_count DESC LIMIT 1;

-- Q13: Top 3 expensive Fantasy books
SELECT * FROM Books 
WHERE Genre = 'Fantasy'
ORDER BY Price DESC LIMIT 3;

-- Q14: Author-wise books sold
SELECT b.Author, SUM(o.Quantity) AS total_books_sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Author;

-- Q15: Cities with orders above $30
SELECT DISTINCT c.City
FROM Orders o 
JOIN Customers c ON o.Customer_ID = c.Customer_ID
WHERE o.Total_Amount > 30;

-- Q16: Customer who spent the most
SELECT c.Customer_ID, c.Name, SUM(o.Total_Amount) AS total_spent
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY total_spent DESC LIMIT 1;

-- Q17: Stock status after orders
SELECT b.Book_ID, b.Title, b.Stock, COALESCE(SUM(o.Quantity),0) AS ordered_quantity,
       b.Stock - COALESCE(SUM(o.Quantity),0) AS remaining_stock
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID
ORDER BY b.Book_ID;
