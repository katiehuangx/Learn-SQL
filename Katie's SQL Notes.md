# 📝 Katie's SQL Notes

Hi, I'm Katie! This is a WIP notes on SQL. 

## 📚 Table of Content
- Create, alter, drop, truncate and delete database 
- Create, drop and delete index
- Alter table and column
- Set primary and foreign key
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
- Result set operators
  - Combine results with UNION
  - Return distinct rows with EXCEPT
  - Return common rows with INTERSECT
 
***

## 📌 Data Types

***

## 📌 Basics

***

## 📌 Filtering Techniques

### Using WHERE

***

### Limit Results with TOP

**1. Limit results with TOP**
````sql
SELECT TOP 3 TaxRate
FROM Sales.SalesTaxRate
ORDER BY TaxRate DESC;
````
***

**2. Limit results with TOP PERCENT**

Specify the number of percentage of results to generate. For example, to generate the first 50% of the results, use `TOP 50 PERCENT`. 

````sql
SELECT TOP 50 PERCENT TaxRate, Name
FROM Sales.SalesTaxRate
ORDER BY TaxRate DESC;
````
***

**3. Limit results with TOP X WITH TIES**

Results include multiple records of the same values from the last record. 

For example, we are interested to know the Top 5 students in the classroom. Since there are 2 students who have received the same 5th highest score in the classroom, hence there will be a total of 6 rows of records in the results table - 1, 2, 3, 4, 5, 5.

````sql
SELECT TOP 5 WITH TIES student_name, score
FROM classroom
ORDER BY score;
````

***

### Remove duplicates with DISTINCT

To remove duplicates and retrieve unique values only.

````sql
SELECT DISTINCT City, StateProvinceID
FROM Person.Address
ORDER BY City;
````

***

### Comparison operators

| Comparison Operator | Description |
| ------------------- | ----------- |
| =                   | Equal to    |
| !=                  | Not equal to    |
| <>                   | Not equal to   |
| >                   | Greater than    |
| >=                   | Greater than or equal to    |
| <                   | Less than    |
| <=                   | Less than or equal to    |



***

**NULL Values**

Take note that we cannot use `!=` or `<>` on NULL values.

````sql
SELECT WorkOrderID, ScrappedQty, ScrapReasonID
FROM Production.WorkOrder
WHERE ScrapReasonID IS NOT NULL;
````
***

**ISNULL**

For example, replace NULL values with '99'.
````sql
SELECT WorkOrderID, ScrappedQty, ISNULL(ScrapReasonID, 99) AS ScrapReason
FROM Production.WorkOrder;
````

***

**Match texts using LIKE and Wildcards**

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

| String Functions  | Description                 |
| ----------------- | --------------------------- |
| UPPER()           | Convert value   |
| LOWER()           | Count unique values only    |
| LEN()             |                             |
| TRIM()            | Self-explanatory            |
| LTRIM()           | Self-explanatory            |
| RTRIM()           | Self-explanatory            |
| CONCAT()          | Self-explanatory            |

### Mathematical Functions

### Date Functions

***

## 📌 Window functions

***

## 📌 Condition statement

### IIF

### If Else

### CASE WHEN

***

## 📌 Create Temp Table

***
## 📌 Subquery

***

## 📌 PIVOT

***
## 📌 Result set operators

### Combine results with UNION

### Return distinct rows with EXCEPT

### Return common rows with INTERSECT

***
