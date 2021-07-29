--LinkedIn Querying Microsoft SQL Server 2019
--Completed 27/07/2021
--Learning Notes


--Use Blank columns 
SELECT Name, ProductNumber, 'AdventureWorks' AS Manufacturer, ListPrice, CAST (ListPrice * 0.85 AS DECIMAL (10,2)) AS SalePrice
FROM Production.Product
WHERE ListPrice > 0;

--TOP clause

-- Limit results with TOP
SELECT TOP 3 TaxRate, Name
FROM Sales.SalesTaxRate
ORDER BY TaxRate DESC;

-- Limit results with TOP PERCENT
-- Specify no. of percentage of records to pull
SELECT TOP 50 PERCENT TaxRate, Name
FROM Sales.SalesTaxRate
ORDER BY TaxRate DESC;

-- Limit results with TOP X WITH TIES
-- Include multiple records with same values from the last record
SELECT TOP 5 WITH TIES TaxRate, Name
FROM Sales.SalesTaxRate
ORDER BY TaxRate;

--DISTINCT clause
--Remove duplicates
SELECT DISTINCT City, StateProvinceID
FROM Person.Address
ORDER BY City;

-- Comparison Operators
SELECT Name, TaxRate
FROM Sales.SalesTaxRate
WHERE TaxRate >= 7.25;

SELECT Name, TaxRate
FROM Sales.SalesTaxRate
WHERE (TaxRate > 7) AND (TaxRate < 10);

-- NULL values
-- Cannot use != or <> on NULL values
SELECT WorkOrderID, ScrappedQty, ScrapReasonID
FROM Production.WorkOrder
WHERE ScrapReasonID IS NOT NULL;

-- Replace NULL values with '99'
SELECT WorkOrderID, ScrappedQty, ISNULL(ScrapReasonID, 99) AS ScrapReason
FROM Production.WorkOrder;

-- Match text with LIKE and wildcards %_[]
--% Any string of zero or more characters
--_ Any single character
--[ABCDEF] Any single character in set
--[A-F] Any single character in range
--[^ABCDEC] Any single character not in set

SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE 'A%';

SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE 'A%n';

SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE '%ae%';

SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE 'A___';

SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE '[ABC]%';

SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE 'A[LMN]___';

SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE 'A[L-O]___';

--Table JOINS and relationship
SELECT p.BusinessEntityID, p.FirstName, p.LastName, pp.PhoneNumber
FROM Person.Person AS p
JOIN Person.PersonPhone AS pp
	ON p.BusinessEntityID = pp.BusinessEntityID;

SELECT p.BusinessEntityID, p.PersonType, p.FirstName, p.LastName, e.JobTitle
FROM Person.Person AS p
LEFT JOIN HumanResources.Employee AS e
	ON p.BusinessEntityID = e.BusinessEntityID;

SELECT p.BusinessEntityID, p.PersonType, p.FirstName, p.LastName, e.JobTitle
FROM Person.Person AS p
RIGHT JOIN HumanResources.Employee AS e
	ON p.BusinessEntityID = e.BusinessEntityID;

-- Combine every records from both table with no common ID
SELECT d.Name AS DepartmentName, a.Name AS AddressName
FROM HumanResources.Department AS d
CROSS JOIN Person.AddressType AS a;

-- Use GROUP BY and COUNT
SELECT City, StateProvinceID, COUNT(*) AS AddressCount
FROM Person.Address
GROUP BY City, StateProvinceID
ORDER BY AddressCount DESC;

--Column 'Person.Address.AddressID' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
--Every column in GROUP BY clause needs to be in SELECT clause

--Aggregate Functions
--COUNT(*), COUNT(DISTINCT )
--COUNT_BIG()
--SUM, AVG, MIN, MAX()
--STDEV, VAR, VARP()
--APPROX_COUNT_DISTINCT()

SELECT SalesOrderID, SUM(LineTotal) AS OrderTotal, SUM(OrderQty) AS NumberOfItems, COUNT(DISTINCT ProductID) AS UniqueItems
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY SUM(LineTotal) DESC;

SELECT s.ProductID, p.Name, SUM(s.OrderQty) AS TotalQtySold
FROM Sales.SalesOrderDetail AS s
JOIN Production.Product AS p
	ON s.ProductID = p.ProductID
GROUP BY s.ProductID, p.Name
ORDER BY TotalQTYSold DESC;

--Filter groups with HAVING

SELECT Color, COUNT(*) AS NumberOfProducts
FROM Production.Product
WHERE Color IS NOT NULL
GROUP BY Color
HAVING COUNT(*) > 25;

--Functions
--1. Aggregate functions
--2. String functions - LEFT(1,2), RIGHT()
--3. Mathematical functions
--4. Date and time functions
--5. Logical functions

--2. String functions
SELECT FirstName, LastName, 
	UPPER(FirstName) AS FName, LOWER(LastName) AS LName, 
	LEN(FirstName) AS LenFName,
	LEFT(LastName, 3) AS First3, RIGHT(LastName,3) AS Last3,
	TRIM(LastName) AS TrimmedName
FROM Person.Person;

SELECT FirstName, LastName,
	CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS FullName,
	CONCAT_WS(' ', FirstName, MiddleName, LastName) AS FullNameWS --With Separator. More accurate results
FROM Person.Person;

--3. Mathematical functions
SELECT BusinessEntityID, SalesYTD,
	ROUND(SalesYTD, 2) AS Round2, -- 2 decimals
	ROUND(SalesYTD, -2) AS Round100, -- Round up to nearest hundreds
	CEILING(SalesYTD) AS RoundCeiling, -- Round up to nearest integer
	FLOOR(SalesYTD) AS RoundFloor -- Round down to nearest integer
FROM Sales.SalesPerson;

--4. Date and time functions
SELECT BusinessEntityID, HireDate,
	YEAR(HireDate) AS HireYear,
	MONTH(HireDate) AS HireMonth,
	DAY(HireDate) AS HireDay
FROM HumanResources.Employee

SELECT YEAR(HireDate) AS HireYear, COUNT(*) AS NewHires
FROM HumanResources.Employee
GROUP BY YEAR(HireDate);

SELECT GETDATE();

SELECT GETUTCDATE();

SELECT BusinessEntityID, HireDate,
	DATEDIFF (YEAR, HireDate, GETDATE()) AS YearsSinceHire,
	DATEADD(YEAR, 10, HireDate) AS AnniversaryDate -- 2nd argument is no. of years to add
FROM HumanResources.Employee;

SELECT BusinessEntityID, HireDate,
	FORMAT(HireDate, 'dddd') AS FormattedDay,
	FORMAT(HireDate, 'dd-MMM-yyyy') AS FormattedDay
FROM HumanResources.Employee;

-- Random records NEWID
SELECT  TOP 10 WorkOrderID, NEWID() AS NewID
FROM Production.WorkOrder
ORDER BY NewID;

--IIF logical function
SELECT IIF (SalesYTD > 2000000, 'Met sales goal', 'Has not met goal') AS Status,
	COUNT(*)
FROM Sales.SalesPerson
GROUP BY IIF (SalesYTD > 2000000, 'Met sales goal', 'Has not met goal');

-- Subquery in SELECT
SELECT BusinessEntityID, SalesYTD, 
	(SELECT MAX(SalesYTD) 
	FROM Sales.SalesPerson) AS HighestSalesYTD,
	(SELECT MAX(SalesYTD) 
	FROM Sales.SalesPerson) - SalesYTD AS SalesGap
FROM Sales.SalesPerson
ORDER BY SalesYTD DESC

-- Subquery in HAVING clause
SELECT SalesOrderID, SUM(LineTotal) AS OrderTotal
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(LineTotal) > 
	(
	SELECT AVG(ResultTable.MyValues) AS AvgValue -- subsquery no. 2. Cannot combine both subqueries as cannot do AVG(SUM(LineTotal))
	FROM
		(SELECT SUM(LineTotal) AS MyValues --subquery no. 1
		FROM Sales.SalesOrderDetail
		GROUP BY SalesOrderID) AS ResultTable
	);


--Correlated subqueries
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.JobTitle
FROM Person.Person AS p
JOIN HumanResources.Employee AS e
	ON p.BusinessEntityID = e.BusinessEntityID

SELECT BusinessEntityID, FirstName, LastName,
	(SELECT JobTitle
	FROM HumanResources.Employee
	WHERE BusinessEntityID = MyPeople.BusinessEntityID) AS JobTitle --Better to use LEFT JOIN as give same results
FROM Person.Person AS MyPeople
WHERE EXISTS (SELECT JobTitle
		FROM HumanResources.Employee
		WHERE BusinessEntityID = MyPeople.BusinessEntityID); -- Better to use JOIN or WHERE EXISTS

-- PIVOT

SELECT ProductLine, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE ProductLine IS NOT NULL
GROUP BY ProductLine

SELECT 'AverageListPrice' AS 'ProductLine', -- To add meaning to the table
	M, R, S, T
FROM
	(SELECT ProductLine, ListPrice
	FROM Production.Product) AS SourceData
PIVOT (AVG(ListPrice) FOR ProductLine IN (M, R, S, T)) AS PivotTable; -- For every product line M, R, S, T we are going to find the average price

--Create and use variables by using DECLARE clause
DECLARE @MyFirstVariable INT;

SET @MyFirstVariable = 10;

SELECT @MyFirstVariable AS MyValue, 
	@MyFirstVariable * 5 AS Multiplication,
	@MyFirstVariable + 10 AS Addition


DECLARE @VarColor VARCHAR(20) = 'Blue';

SELECT ProductID, Name, ProductNumber, Color, ListPrice
FROM Production.Product
WHERE Color = @VarColor;

--Create counter for looping statement
DECLARE @Counter INT = 1;

WHILE @Counter <= 3
BEGIN
	SELECT @Counter AS CurrentValue
	SET @Counter = @Counter + 1
END;


DECLARE @Counter INT = 1;
DECLARE @Product INT = 710;

WHILE @Counter <= 3
BEGIN
	SELECT ProductID, Name, ProductNumber, Color, ListPrice
	FROM Production.Product
	WHERE ProductID = @Product
	SET @Counter = @Counter + 1
	SET @Product = @Product + 10
END;

-- UNION
SELECT ProductCategoryID, NULL AS ProductSubCategoryID, Name -- Create an empty column to represent ProductSubCategoryID column from 2nd table. Both table data types must be same.
FROM Production.ProductCategory
UNION
SELECT ProductCategoryID, ProductSubCategoryID, Name
FROM Production.ProductSubcategory;

--EXCEPT operator
SELECT BusinessEntityID
FROM Person.Person
WHERE PersonType <> 'EM' -- Select everyone who is not an employee
EXCEPT
SELECT BusinessEntityID
FROM Sales.PersonCreditCard; -- Everyone with credit card

SELECT p.BusinessEntityID
FROM Person.Person AS p
LEFT JOIN Sales.PersonCreditCard AS c --Same results using LEFT JOIN
	ON p.BusinessEntityID = c.BusinessEntityID
WHERE p.PersonType <> 'EM' AND c.CreditCardID IS NULL;

--INTERSECT 
SELECT ProductID
FROM Production.ProductProductPhoto
INTERSECT
SELECT ProductID
FROM Production.ProductReview;

SELECT DISTINCT(p.ProductID) -- Same results using JOIN
FROM Production.ProductProductPhoto AS p
JOIN Production.ProductReview AS r
	ON p.ProductID = r.ProductID;
