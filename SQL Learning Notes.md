# 📝 SQL Learning Notes

Hi, I'm Katie! This is my work-in-progress notes on SQL - so you'll find some empty spaces or NULL values 😉 as I'm updating the notes as I learn. 

## 📚 Table of Content

<details>
<summary>
Click here to expand!
</summary>

## Content

- CRUD Operations
- Insert records
- Alter table
- Table constraints
- Create index
  - Set primary key and foreign key
- Data types	
  - Text
  - Numerical
  - Date time
- Base query
- Filter techniques
  - Using WHERE
  - Limit results with TOP
  - Remove duplicates with DISTINCT
  - Comparison operators
  - NULL values
  - Match text with LIKE and wildcards
- JOINS
  - Inner Joins
  - Left Joins
  - Right Joins
  - Full Outer Joins
- Grouping records
  - GROUP BY, COUNT and HAVING
- Functions
  - Aggregate functions
  - String functions
  - Mathematical functions
  - Date functions
- Window functions
- Condition statement
  - IIF
  - If Else
  - CASE WHEN
- Create temp table
- Subquery
- PIVOT
- Create and use variables
- Result set operators
  - Combine results with UNION
  - Return distinct rows with EXCEPT
  - Return common rows with INTERSECT
 
</details>

***

## 📌 Order of Execution

Sequence of how SQL runs the clauses:

1. FROM, JOINS - The SQL engine fetches the data from the tables
2. WHERE - Filters it
3. GROUP BY - Aggregates data and can remove duplicates
4. HAVING - Filters aggregated data
5. SELECT - Selects the columns and expressions to display
6. DISTINCT - Remove duplicates
7. UNION, INTERSECT, EXCEPT - Can remove duplicates. UNION ALL include duplicates
8. ORDER BY - Orders the remaining data
9. OFFSET, LIMIT - Limits the results

## 📌 Table Design

### CRUD Operations

- **CREATE** - Create databases, tables or views
- **READ** - Read using SELECT clause
- **UPDATE** - Amend existing database records
- **DELETE** - Delete records

### Create Table

````sql
CREATE TABLE rooms (
	room_id INT IDENTITY(1,1) NOT NULL, -- IDENTITY(1,1) means room_id is an identity key that auto-increments by 1
	room_no CHAR(3) NOT NULL,
	bed_type VARCHAR(15) NOT NULL,
	rate SMALLMONEY NOT NULL);
````

### Update Records

Before running `UPDATE` clause, run a `SELECT` query to identify the exact row(s) to update to ensure that we update correct rows.

````sql
UPDATE guests
SET checkin_date = '2021-05-10'
WHERE reservation_id = 1001; - a condition to identify the specific rows to update
````

````sql
UPDATE guests
SET checkin_date = '2021-05-10',
	checkout_date = '2021-05-15'
WHERE reservation_id = 1001;
````

````sql
UPDATE movies
SET title = "Toy Story 3", 
	director = "Lee Unkrich"
WHERE id = 11;
````

### Delete Records

Before running `DELETE` clause, run a `SELECT` query to identify the exact row(s) for deletion to ensure that we delete only the unwanted rows.

````sql
DELETE FROM guests
WHERE customer_id = 1005;
````

### Insert Records

````sql
INSERT INTO rooms (room_no, bed_type, rate)
	VALUES ('101', 'King', 120),
		('102', 'Queen', 100),
		('103', 'Deluxe', 80),
		('104', 'King', 120),
		('105', 'Queen', 100);
````

````sql
INSERT INTO rooms (room_no, bed_type, rate)
SELECT
  col_1,
  col_2,
  col_3
FROM other_table
WHERE --conditions apply
````

### Remove Table

Use `TRUNCATE TABLE` to remove all data from the table with table structure still exists in the database.

````sql
TRUNCATE TABLE rooms;
````

Use `DROP TABLE` to delete the entire table including data from the database.

````sql
DROP TABLE rooms;
````

***

## 📌 Alter Table

### Add Columns

````sql
ALTER TABLE guests
ADD last_name VARCHAR(15);
````

````sql
ALTER TABLE movies
  ADD COLUMN Language TEXT DEFAULT "English"; -- Set 'English' as the default values in all rows in Language column
````

### Remove/Drop Columns

````sql
ALTER TABLE table_name
DROP COLUMN old_column;
````

### Rename Table

````sql
ALTER TABLE table_name
RENAME COLUMN old_column TO new_column;
````
***

## 📌 Table Constraints

Constraints give the data structure and help with consistency and data quality.

**Integrity Constrains**
1. Attribute constraints - Eg. data types on columns
2. Key constraints - Primary keys
3. Referential integrity constraints - Enforced through foreign keys

- Primary key
- Foreign key
- Auto-increment
- Unique
- NOT NULL

**Create Primary Key**

````sql
CREATE CLUSTERED INDEX IX_guests_guest_id -- Name of your index
ON guests (guest_id); -- table name and column name
````

**Create Foreign Key**

````sql
CREATE NONCLUSTERED INDEX IX_guests_last_name -- Name of your index
ON guests (last_name); -- table name and column name
````

***

## 📌 Index

Index improves the speed of looking through the table's data. Without an index, SQL performs a table scan by searching for every record in the table. 

It acts as 'Table of Content' in a book - it's (usually) much faster to look up something in a book by looking at its index than by flipping every page until we find what we want.

### Create Index

### Drop Index

***

## 📌 Data Types

***

## 📌 Filtering Techniques

### Using WHERE

### Limit Results with TOP

**Limit results with TOP**
````sql
SELECT TOP 3 TaxRate
FROM Sales.SalesTaxRate
ORDER BY TaxRate DESC;
````

**Limit results with TOP PERCENT**

Specify the number of percentage of results to generate. For example, to generate the first 50% of the results, use `TOP 50 PERCENT`. 

````sql
SELECT TOP 50 PERCENT TaxRate, Name
FROM Sales.SalesTaxRate
ORDER BY TaxRate DESC;
````

**Limit results with TOP X WITH TIES**

Results include multiple records of the same values from the last record. 

For example, we are interested to know the Top 5 students in the classroom. Since there are 2 students who have received the same 5th highest score in the classroom, hence there will be a total of 6 rows of records in the results table - 1, 2, 3, 4, 5, 5.

````sql
SELECT TOP 5 WITH TIES student_name, score
FROM classroom
ORDER BY score;
````

### Remove duplicates with DISTINCT

To remove duplicates and retrieve unique values only.

````sql
SELECT DISTINCT City, StateProvinceID
FROM Person.Address
ORDER BY City;
````
### Using ISNUMERIC()

To return values that are numeric only.

````sql
SELECT ISNUMERIC(student_score)
FROM School.Scores;
````

### Comparison operators

| Comparison Operator | Description |
| ------------------- | ----------- |
| =                   | Equal to    |
| !=                  | Not equal to    |
| <>                  | Not equal to   |
| >                   | Greater than    |
| >=                  | Greater than or equal to    |
| <                   | Less than    |
| <=                  | Less than or equal to    |
| BETWEEN ... AND ... |     |
| NOT BETWEEN ... AND ... |     |
| IN (..., ..., ...)    |    |
| NOT IN (..., ..., ...)  | |

### NULL Values

Take note that we cannot use `!=` or `<>` on NULL values.

````sql
SELECT WorkOrderID, ScrappedQty, ScrapReasonID
FROM Production.WorkOrder
WHERE ScrapReasonID IS NOT NULL;
````

**ISNULL**

For example, replace NULL values with '99'.
````sql
SELECT WorkOrderID, ScrappedQty, ISNULL(ScrapReasonID, 99) AS ScrapReason
FROM Production.WorkOrder;
````

### Match texts using LIKE and Wildcards**

````sql
WHERE first_name LIKE 'a%' -- Finds any values that starts with "a"
WHERE first_name LIKE '%a' -- Finds any values that ends with "a"
WHERE first_name LIKE '%ae%' -- Finds any values that have "ae" in the middle
WHERE first_name LIKE '_b%' -- Finds any values with "b" in the second position
WHERE first_name LIKE 'a_%_%' -- Finds any values that starts with "a" and are at least 3 characters in length
WHERE first_name LIKE 'a%o' -- Finds any values that starts with "a" and ends with "o"
WHERE first_name LIKE 'a___' -- Finds any value that starts with "a" and has 3 characters
WHERE first_name LIKE '[abc]%' -- Finds any values with "a", "b" or "c"
WHERE first_name LIKE '[a-f]%' -- Finds any values with "a" to "f"
WHERE first_name LIKE 'a[l-n]' -- Finds any values that starts with "a" and has "l", "m" or "n"
WHERE first_name LIKE 'a[c-e]__' -- Finds any values that starts with "a" and has "c", "d" or "e" in the middle and ends with 2 characters
````

***

## 📌 JOINS

- `INNER JOIN`: Only returns matching rows.
- `LEFT JOIN` (or `RIGHT JOIN`): All rows from main table + matches from joining table.
- `NULL`: Displayed if no match is found in `LEFT JOIN` / `RIGHT JOIN`.

### Inner Joins

````sql
SELECT p.BusinessEntityID, p.FirstName, p.LastName, pp.PhoneNumber
FROM Person.Person AS p
JOIN Person.PersonPhone AS pp
	ON p.BusinessEntityID = pp.BusinessEntityID;
````  

### Left Joins

````sql
SELECT p.BusinessEntityID, p.PersonType, p.FirstName, p.LastName, e.JobTitle
FROM Person.Person AS p
LEFT JOIN HumanResources.Employee AS e
	ON p.BusinessEntityID = e.BusinessEntityID;
````

### Right Joins

````sql
SELECT p.BusinessEntityID, p.PersonType, p.FirstName, p.LastName, e.JobTitle
FROM Person.Person AS p
RIGHT JOIN HumanResources.Employee AS e
	ON p.BusinessEntityID = e.BusinessEntityID;
````

### Cross Joins

For example, table_1 has 10 rows and table_2 has 5 rows. A `CROSS JOIN` would result in 10 rows x 5 rows = 50 rows table.

````sql
SELECT d.Name AS DepartmentName, a.Name AS AddressName
FROM HumanResources.Department AS d
CROSS JOIN Person.AddressType AS a;
````

***

## 📌 Grouping records

### GROUP BY and COUNT

Every column in `GROUP BY` clause needs to be in `SELECT` clause.

````sql
SELECT City, StateProvinceID, COUNT(*) AS AddressCount
FROM Person.Address
GROUP BY City, StateProvinceID
ORDER BY AddressCount DESC;
````

### GROUP BY and HAVING

`HAVING` must be used in conjuction with `GROUP BY`.

````sql
SELECT City, StateProvinceID, COUNT(*) AS AddressCount
FROM Person.Address
GROUP BY City, StateProvinceID
HAVING City = 'New York'
````

***

## 📌 Functions

### Aggregate Functions

| Aggregate Functions     | Description                 |
| ----------------------- | --------------------------- |
| COUNT(*)                | Count total number of rows  |
| COUNT(DISTINCT column)  | Count unique values only    |
| COUNT_BIG()             |                             |
| SUM, AVG, MIN, MAX()    | Self-explanatory            |
| STDEV, VAR, VARP()      | Self-explanatory            |


### String Functions

| String Functions  | Description                 | Syntax | 
| ----------------- | --------------------------- | ------- |
| UPPER()           | Convert 'NaMe' into UPPERCAESE  | SELECT UPPER(col_1) |
| LOWER()           | Convert 'NaMe' into lowercase   | SELECT LOWER(col_1) |
| LEN()             | Count number of characters in a value   | SELECT LEN(col_1) |
| TRIM()            | Trim blank spaces in a value            | SELECT TRIM(col_1) | 
| LEFT(,3)         | Return 1st 3 characters from the left    | SELECT LEFT(col_1,3) |
| RIGHT(,3)        | Returns 1st 3 characters from the right  | SELECT RIGHT(col_1,3) |
| SUBSTRING(col,3,3) | To retrieve midsection of string        | SELECT SUBSTRING(col_1,10,10) |
| CONCAT()          | Combine >= 2 values with ' ',-,/          | SELECT CONCAT(col_1, ' ', col_2, ' ', col_3) |
| CONCAT_WS()       | To insert ' ' (blank space) between all values     | SELECT CONCAT_WS(' ', col_1, col_2, col_3) |
| CHARINDEX(' ',col) | To find location of character in string        | SELECT CHARINDEX('-', col_1) |
| TOP(5) REPLACE(col,' ', ' ') | TOP specifies the rows being replaced and REPLACE replaces 1st '' with 2nd ' ' | SELECT TOP(5) REPLACE(col_1, '_', '-') |


Refer to examples below.

````sql
SELECT FirstName, LastName, 
	UPPER(FirstName) AS FName, LOWER(LastName) AS LName, 
	LEN(FirstName) AS LenFName,
	LEFT(LastName, 3) AS First3, RIGHT(LastName,3) AS Last3,
	TRIM(LastName) AS TrimmedName
FROM Person.Person;
````

````sql
SELECT FirstName, LastName,
	CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS FullName,
	CONCAT_WS(' ', FirstName, MiddleName, LastName) AS FullNameWS -- 'WS' stands for 'With Separator'
FROM Person.Person;
````

````sql
SELECT 
	TOP 10 description, 
  CHARINDEX('Weather', description) AS start_of_string, -- Find index of 'Weather' which is 8
  LEN('Weather') AS length_of_string, -- Find length of 'Weather'
  SUBSTRING(description, 15, LEN(description)) AS additional_description -- Get substring between index 15 (after 'Weather') to end of description column
FROM grid
WHERE description LIKE '%Weather%';
````

### Mathematical Functions

| Mathematical Functions  | Description        | Syntax |
| ----------------- | ------------------------ | ------ |
| ROUND(,2)           | Round with 2 decimals  | ROUND(col_1, 2) |
| ROUND(,-2)           | Round up to nearest hundreds   | ROUND(col_1, -2) |
| CEILING()           | Round up to nearest integer     | CEILING(col_1) |
| FLOOR()            | Round down to nearest integer    | FLOOR(col_1)


````sql
SELECT BusinessEntityID, SalesYTD,
	ROUND(SalesYTD, 2) AS Round2, -- 2 decimals
	ROUND(SalesYTD, -2) AS Round100, -- Round up to nearest hundreds
	CEILING(SalesYTD) AS RoundCeiling, -- Round up to nearest integer
	FLOOR(SalesYTD) AS RoundFloor -- Round down to nearest integer
FROM Sales.SalesPerson;
````

### Date Functions

| Date Functions  | Description                 |
| ----------------| --------------------------- |
| YEAR()          | Returns year from date  |
| MONTH()         | Returns month from date   |
| DAY()           | Returns day from date                           |
| GETDATE()       | Returns today's date           |
| GETDATEUTC()    | Returns today's date in            |
| DATEDIFF()      |             |
| FORMAT()        |             |
| FORMAT()        |             |


***

## 📌 Window functions

***

## 📌 Condition statement

### IIF 

````sql
SELECT IIF (SalesYTD > 2000000, 'Met sales goal', 'Has not met goal') AS Status,
	COUNT(*)
FROM Sales.SalesPerson
GROUP BY IIF (SalesYTD > 2000000, 'Met sales goal', 'Has not met goal');
````

### If Else

### CASE WHEN

***

## 📌 Create Temp Table

````sql
DROP TABLE IF EXISTS clean_weight_logs;

CREATE TEMP TABLE clean_weight_logs AS (
SELECT *
FROM health.user_logs
WHERE measure = 'weight' 
	AND measure_value > 0
	AND measure_value < 201);
````

***

## 📌 Subquery

### Subquery in SELECT
````sql
SELECT BusinessEntityID, SalesYTD, 
	(SELECT MAX(SalesYTD) 
	FROM Sales.SalesPerson) AS HighestSalesYTD,
	(SELECT MAX(SalesYTD) 
	FROM Sales.SalesPerson) - SalesYTD AS SalesGap
FROM Sales.SalesPerson
ORDER BY SalesYTD DESC
````

### Subquery in HAVING
````sql
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
````

### Correlated Subquery

````sql
SELECT BusinessEntityID, FirstName, LastName,
	(SELECT JobTitle
	FROM HumanResources.Employee
	WHERE BusinessEntityID = MyPeople.BusinessEntityID) AS JobTitle --Better to use LEFT JOIN as give same results
FROM Person.Person AS MyPeople
WHERE EXISTS (SELECT JobTitle
		FROM HumanResources.Employee
		WHERE BusinessEntityID = MyPeople.BusinessEntityID); -- Better to use JOIN or WHERE EXISTS

````

***

## 📌 PIVOT

````sql
SELECT 'AverageListPrice' AS 'ProductLine', -- To add meaning to the table
FROM
	(SELECT ProductLine, ListPrice
	FROM Production.Product) AS SourceData
PIVOT (AVG(ListPrice) FOR ProductLine IN (M, R, S, T)) AS PivotTable; -- For every product line M, R, S, T we are going to find the average price
````

***

## 📌 Create and Use Variables

Use Variables to avoid repetition of creating different queries using same variable. 

For example, having to create different queries to find for specific artists. Instead, we assign/declare placeholder `=@my_artist`. All we need to do is update the variable each time we run the query.

Syntax example:
````sql
-- To declare a variable
DECLARE @col_1 INT
DECLARE @my_name VARCHAR(100)

-- To assign value to variable
SET @col_1 = 5
SET @my_name = 'Katie'
````

### Using DECLARE

````sql
DECLARE @MyFirstVariable INT;

SET @MyFirstVariable = 10;

SELECT @MyFirstVariable AS MyValue, 
	@MyFirstVariable * 5 AS Multiplication,
	@MyFirstVariable + 10 AS Addition


DECLARE @VarColor VARCHAR(20) = 'Blue';

SELECT ProductID, Name, ProductNumber, Color, ListPrice
FROM Production.Product
WHERE Color = @VarColor;
````

### Create counter for Looping Statement
````sql
DECLARE @Counter INT = 1;

WHILE @Counter <= 3
BEGIN
	SELECT @Counter AS CurrentValue
	SET @Counter = @Counter + 1
END;
````

````sql
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
````
***

## 📌 Result set operators



### Combine results with UNION

`UNION` excludes duplicate rows in both set of queries whereas, `UNION ALL` includes any duplicate rows in the sets of queries.

To use `UNION` or `UNION ALL`, when combining data from different tables
- Select same number of columns in same order
- Columns should have same data type

````sql
SELECT ProductCategoryID, NULL AS ProductSubCategoryID, Name
-- Create an empty column to represent ProductSubCategoryID column from 2nd table. Both table data types must be same.
FROM Production.ProductCategory
UNION
SELECT ProductCategoryID, ProductSubCategoryID, Name
FROM Production.ProductSubcategory;
````


### Return distinct rows with EXCEPT

````sql
SELECT BusinessEntityID
FROM Person.Person
WHERE PersonType <> 'EM' -- Select everyone who is not an employee
EXCEPT
SELECT BusinessEntityID
FROM Sales.PersonCreditCard; -- Everyone with credit card
````

You can achieve the same results as above using a `LEFT JOIN` below.

````sql
SELECT p.BusinessEntityID
FROM Person.Person AS p
LEFT JOIN Sales.PersonCreditCard AS c --Same results using LEFT JOIN
	ON p.BusinessEntityID = c.BusinessEntityID
WHERE p.PersonType <> 'EM' AND c.CreditCardID IS NULL;
````

### Return common rows with INTERSECT

````sql
SELECT ProductID
FROM Production.ProductProductPhoto
INTERSECT
SELECT ProductID
FROM Production.ProductReview;
````

You can achieve the same results as above using `JOIN` below.

````sql
SELECT DISTINCT(p.ProductID) -- Same results using JOIN
FROM Production.ProductProductPhoto AS p
JOIN Production.ProductReview AS r
	ON p.ProductID = r.ProductID;
````
***
