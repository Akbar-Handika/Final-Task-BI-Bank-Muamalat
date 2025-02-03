--Create Table
-- Membuat tabel Customers
CREATE TABLE customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    CustomerEmail VARCHAR(255) UNIQUE NOT NULL,
    CustomerPhone VARCHAR(20),
    CustomerAddress VARCHAR(255),
    CustomerCity VARCHAR(100),
    CustomerState VARCHAR(100),
    CustomerZip VARCHAR(10)
);

-- Membuat tabel Orders
CREATE TABLE orders (
    OrderID INT PRIMARY KEY,
    Date DATE NOT NULL,
    CustomerID INT NOT NULL,
    ProdNumber VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL
);

-- Membuat tabel ProductCategory
CREATE TABLE productcategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    CategoryAbbreviation VARCHAR(10) NOT NULL
);

-- Membuat tabel Product
CREATE TABLE product (
    ProdNumber VARCHAR(50) PRIMARY KEY,
    ProdName VARCHAR(255) NOT NULL,
    Category INT NOT NULL,
    Price NUMERIC(10,2) NOT NULL
);


--View Table
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM product;
SELECT * FROM productcategory;

--Membuat Relasi
--Membuat FK CustomerID
ALTER TABLE orders
ADD CONSTRAINT fk_customerid
FOREIGN KEY (CustomerID)
REFERENCES customers(CustomerID);

--Membuat FK ProdNumber
ALTER TABLE orders
ADD CONSTRAINT fk_prodnum
FOREIGN KEY (ProdNumber)
REFERENCES product(ProdNumber);

--Membuat FK CategoryID
ALTER TABLE product
ADD CONSTRAINT fk_category
FOREIGN KEY (Category)
REFERENCES productcategory(CategoryID);



-- --Menampilkan Tabel Master
-- SELECT
-- 	o."Date" AS order_date,
-- 	pc."CategoryName" AS category_name,
-- 	p."ProdName" AS product_name,
-- 	p."Price" AS product_price,
-- 	o."Quantity" AS order_qty,
-- 	(o."Quantity" * p."Price") AS total_sales,
-- 	c."CustomerEmail" AS cust_email,
-- 	c."CustomerCity" AS cust_city
	
-- FROM orders AS o
-- JOIN
-- 	customers AS c 
-- 	ON o."CustomerID" = c."CustomerID"
-- JOIN
-- 	product AS p 
-- 	ON o."ProdNumber" = p."ProdNumber"
-- JOIN
-- 	productcategory AS pc 
-- 	ON p."Category" = pc."CategoryID"
-- ORDER BY order_date, order_qty;


-- Menampilkan Tabel Master (clean)
SELECT
    o.Date AS order_date,
    pc.CategoryName AS category_name,
    p.ProdName AS product_name,
    p.Price AS product_price,
    o.Quantity AS order_qty,
    ROUND(o.Quantity * p.Price, 1) AS total_sales, --membulatkan angka
    TRIM(SPLIT_PART(c.CustomerEmail, '#',1))  AS cust_email, --membersihkan email
    c.CustomerCity AS cust_city
FROM orders AS o
JOIN
    customers AS c 
    ON o.CustomerID = c.CustomerID
JOIN
    product AS p 
    ON o.ProdNumber = p.ProdNumber
JOIN
    productcategory AS pc 
    ON p.Category = pc.CategoryID
ORDER BY order_date, order_qty;
