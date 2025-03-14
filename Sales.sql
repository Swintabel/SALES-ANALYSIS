create database porfolio;
use porfolio;
drop table SalesB;

select * 
INTO SalesB
from dbo.sales;

--DATA CLEANING

SELECT *
FROM dbo.SalesB;

-------------------------------

-- Quantity column
SELECT *
FROM dbo.SalesB
WHERE ISNUMERIC(Quantity) = 0;

ALTER TABLE dbo.salesB
ALTER COLUMN Quantity INT;

SELECT * FROM
dbo.SalesB
WHERE Quantity<=0;

DELETE FROM
dbo.SalesB
WHERE Quantity<=0;


---------------------------------

--Unit Price Column
SELECT * FROM
dbo.SalesB
WHERE UnitPrice IS NULL;

DELETE FROM
dbo.SalesB
WHERE UnitPrice IS NULL;

SELECT * FROM
dbo.SalesB
WHERE UnitPrice <=0;

DELETE FROM
dbo.SalesB
WHERE UnitPrice <=0;

UPDATE t1
SET UnitPrice=t2.avg_Price
FROM dbo.SalesB t1
JOIN (
	SELECT StockCode, AVG(UnitPrice) AS avg_Price
	FROM dbo.SalesB WHERE UnitPrice>0
	GROUP BY StockCode
	) t2
ON t1.StockCode=t2.StockCode
WHERE t1.UnitPrice=0;


---------------------------------------
--Description Column
SELECT * FROM
dbo.SalesB
WHERE Description LIKE 'Adjust %';

SELECT * FROM
dbo.SalesB
WHERE Description LIKE 'SAMP%';

SELECT * FROM
dbo.SalesB
WHERE Description LIKE 'found';

SELECT * FROM
dbo.SalesB
WHERE Description LIKE 'test';

SELECT * FROM
dbo.SalesB
WHERE Description LIKE '?%' AND StockCode IS NULL;

DELETE FROM
dbo.SalesB
WHERE Description LIKE 'Adjust %';

DELETE FROM
dbo.SalesB
WHERE Description LIKE 'test';

DELETE FROM
dbo.SalesB
WHERE Description LIKE 'SAMP%';

DELETE FROM
dbo.SalesB
WHERE Description LIKE 'found';

-------------------------------------------------
--Country Column
SELECT * FROM
dbo.SalesB
WHERE ISNUMERIC(Country)=1;

SELECT * FROM
dbo.SalesB
WHERE Country IS NULL;

-------------------------------------------------

--StockCode Column
SELECT DISTINCT(StockCode) FROM
dbo.SalesB
WHERE LEN(StockCode) < 5;

SELECT * FROM
dbo.SalesB
WHERE StockCode IS NULL;

SELECT * FROM
dbo.SalesB
WHERE StockCode='23049'
---------------------------------
--Outliers

WITH ZCTE AS 
(
SELECT 
*, 
(Quantity-AVG(Quantity) OVER())/STDEV(Quantity) OVER() AS z_score
FROM
dbo.SalesB)
SELECT *
FROM
ZCTE
WHERE ABS(z_score)>3;

SELECT * FROM
dbo.SalesB
WHERE Quantity>500

DELETE FROM
dbo.SalesB
WHERE Quantity>500



SELECT Description, StockCode, MAX(UnitPrice) as MaxPrice, MIN(UnitPrice) MinPrice
FROM dbo.SalesB
GROUP BY Description, StockCode 
HAVING MAX(UnitPrice)> 1000
ORDER BY MAX(UnitPrice) DESC;

SELECT * FROM dbo.SalesB
WHERE Description IN
('AMAZON FEE', 'POSTAGE', 'DOTCOM POSTAGE', 'Manual');

DELETE FROM dbo.SalesB
WHERE Description IN
('AMAZON FEE', 'POSTAGE', 'DOTCOM POSTAGE', 'Manual');

------------------------------------------

--Duplicates


WITH CTE AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY InvoiceNo, InvoiceDate, StockCode, Description, Quantity, UnitPrice, CustomerID, Country 
                              ORDER BY (SELECT NULL)) AS RowNum
    FROM dbo.SalesB
)
SELECT InvoiceNo, StockCode, 
		Description, Quantity,InvoiceDate, UnitPrice, CustomerID, Country 
INTO SalesBN FROM CTE WHERE RowNum = 1;

DROP TABLE dbo.SalesB;

EXEC sp_rename 'dbo.SalesBN', 'SalesB'; 
