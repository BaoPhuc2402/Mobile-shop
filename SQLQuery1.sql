﻿use master
go
drop database ASM_java5

CREATE DATABASE ASM_java5
go
use ASM_java5
go
create table voucher(
	id int primary key,
	name nvarchar(100),
	details int
)
Go

create table color(
	id int primary key,
	name nvarchar(20)
)
Go


create table capacity(
	id int primary key,
	detail int
)
Go

CREATE TABLE accounts
(
    username   VARCHAR(50) PRIMARY KEY,
    activated  BIT NOT NULL,
    admin      BIT NOT NULL,
    email      VARCHAR(50) NULL,
	birthday   DATE NULL,
	gender     BIT NULL,
    fullname   NVARCHAR(50) NULL,
    password   VARCHAR(50) NULL,
    photo      VARCHAR(50) NULL
    
);

GO
CREATE TABLE  categories (
     id   varchar (50) primary key,
     name   nvarchar (50) NULL,
)
go

CREATE TABLE  products (
     id   int  IDENTITY(1,1) primary key,
     available   bit  NULL,
     createdate   date  NULL,
     image   varchar (50) NULL,
     name   nvarchar (50) NULL,
     price   float,
	 colorid int references color(id),
	 capacityid int references capacity(id),
	 sale int,
     categoryid varchar(50) references categories(id)
)
go



CREATE TABLE  orders (
     id   int  IDENTITY(1,1) primary key,
     address   nvarchar (50) NULL,
     createdate   date  NULL,
     username   varchar (50) references accounts(username)
)
go

CREATE TABLE  orderdetails (
     id   int  IDENTITY(1,1) primary key,
     price   float,
     quantity   int  NULL,
	 voucherid int  references voucher(id),
	 colorid int references color(id),
	 capacityid int references capacity(id),
     orderid   int  references orders(id),
     productid   int  references products(id)
)
CREATE TABLE photoproduct(
idProduct int references products(id),
img nvarchar(50)
)

drop table carts
CREATE TABLE carts(
cartID int primary key identity,
userID varchar(50) references accounts(username),
productID int references products(id),
quantity int,
colorid int references color(id),
capacityid int references capacity(id)

)
INSERT INTO carts (userID, productID, quantity,colorid,capacityid)
VALUES 
('alex_jones', '2', '10',1,1)
SELECT * from carts where userID ='minhduc123' and productID=1

select * from carts WHERE userID = 'alex_jones'

GO
USE ASM_java5;
GO

-- Insert data into accounts
INSERT INTO accounts (username, activated, admin, email, birthday, gender, fullname, password, photo)
VALUES 
('john_doe', 1, 0, 'john@example.com', '1985-06-15', 1, 'John Doe', 'password123', 'john.jpg'),
('jane_smith', 1, 1, 'jane@example.com', '1990-08-25', 0, 'Jane Smith', 'password456', 'jane.jpg'),
('alex_jones', 1, 0, 'alex@example.com', '1992-12-05', 1, 'Alex Jones', 'password789', 'alex.jpg'),
('mary_jane', 1, 0, 'mary@example.com', '1988-03-10', 0, 'Mary Jane', 'password000', 'mary.jpg'),
('robert_brown', 1, 0, 'robert@example.com', '1995-07-20', 1, 'Robert Brown', 'password111', 'robert.jpg');
-- Insert data into categories
INSERT INTO categories (id, name)
VALUES 
('CAT01', 'Smartphones'),
('CAT02', 'Tablets'),
('CAT03', 'Accessories'),
('CAT04', 'Laptops'),
('CAT05', 'Wearables');
-- Insert data into color
INSERT INTO color (id, name)
VALUES 
(1, 'Black'),
(2, 'White'),
(3, 'Blue'),
(4, 'Red'),
(5, 'Green');


-- Insert data into capacity
INSERT INTO capacity (id, detail)
VALUES 
(1, 64),
(2, 128),
(3, 256),
(4, 512),
(5, 1024);

INSERT INTO products (available, createdate, image, name, price, colorid, capacityid, sale, categoryid)
VALUES 
(1, '2023-01-15', 'iphone13.jpg', 'iPhone 13', 799.99, 1, 1, 10, 'CAT01'),
(1, '2023-02-10', 'samsungs21.jpg', 'Samsung Galaxy S21', 699.99, 2, 2, 15, 'CAT01'),
(1, '2023-03-05', 'ipadpro.jpg', 'iPad Pro', 999.99, 3, 3, 5, 'CAT02'),
(1, '2023-04-12', 'macbookpro.jpg', 'MacBook Pro', 1999.99, 4, 4, 10, 'CAT04'),
(1, '2023-05-20', 'applewatch.jpg', 'Apple Watch', 399.99, 5, 1, 20, 'CAT05');

-- Insert data into orders
INSERT INTO orders (address, createdate, username)
VALUES 
('123 Main St', '2024-01-20', 'john_doe'),
('456 Elm St', '2024-01-22', 'jane_smith'),
('789 Oak St', '2024-01-25', 'alex_jones'),
('101 Pine St', '2024-01-27', 'mary_jane'),
('202 Maple St', '2024-01-30', 'robert_brown');
-- Insert data into voucher
INSERT INTO voucher (id, name, details)
VALUES 
(1, 'New Year Sale', 10),
(2, 'Black Friday', 15),
(3, 'Cyber Monday', 20),
(4, 'Summer Sale', 25),
(5, 'Winter Sale', 30);

-- Insert data into orderdetails with updated column names
INSERT INTO orderdetails (price, quantity, voucherid, colorid, capacityid, orderid, productid)
VALUES 
(799.99, 1, 1, 1, 1, 1, 1),
(699.99, 1, 2, 2, 2, 2, 2),
(999.99, 1, 3, 3, 3, 3, 3),
(1999.99, 1, 4, 4, 4, 4, 4),
(399.99, 1, 5, 5, 1, 5, 5);
GO


select * from products where id =1


/* thong ke theo tong don dang */
SELECT COUNT(*) AS TotalOrders
FROM orders;

-- thống kê đơn hàng theo tung nguoi dung
SELECT username, COUNT(*) AS TotalOrders
FROM orders
GROUP BY username;

-- thong ke so don hang theo ngay
SELECT createdate, COUNT(*) AS TotalOrders
FROM orders
GROUP BY createdate;


-- Thống kê tổng số lượng sản phẩm bán được:
SELECT SUM(quantity) AS TotalProductsSold
FROM orderdetails;


-- tong san pham da ban 
SELECT SUM(quantity) AS TotalProductsSold
FROM orderdetails;

-- thong ke ban duoc theo tung san pham:
SELECT productid, SUM(quantity) AS TotalQuantitySold
FROM orderdetails
GROUP BY productid;

-- TONG doanh thu cac don hang
SELECT SUM(price * quantity) AS TotalRevenue
FROM orderdetails;

-- doanh thu theo tung sp:
SELECT productid, SUM(price * quantity) AS TotalRevenue
FROM orderdetails
GROUP BY productid;


-- thong ke theo tung nguoi dung
SELECT o.username, COUNT(o.id) AS TotalOrders, SUM(od.price * od.quantity) AS TotalRevenue
FROM orders o
JOIN orderdetails od ON o.id = od.orderid
GROUP BY o.username;


-- doanh thu theo tháng all
SELECT 
    YEAR(o.createdate) AS Year,
    MONTH(o.createdate) AS Month,
    COUNT(o.id) AS TotalOrders,
    SUM(od.price * od.quantity) AS TotalRevenue,
    SUM(od.quantity) AS TotalQuantitySold
FROM 
    orders o
JOIN 
    orderdetails od ON o.id = od.orderid
GROUP BY 
    YEAR(o.createdate), MONTH(o.createdate)
ORDER BY 
    Year, Month;

-- thong ke theo thang tu chon
SELECT 
    YEAR(o.createdate) AS Year,
    MONTH(o.createdate) AS Month,
    COUNT(o.id) AS TotalOrders,
    SUM(od.price * od.quantity) AS TotalRevenue,
    SUM(od.quantity) AS TotalQuantitySold
FROM 
    orders o
JOIN 
    orderdetails od ON o.id = od.orderid
WHERE 
    YEAR(o.createdate) = 2023 AND MONTH(o.createdate) = 12
GROUP BY 
    YEAR(o.createdate), MONTH(o.createdate)
ORDER BY 
    Year, Month;
