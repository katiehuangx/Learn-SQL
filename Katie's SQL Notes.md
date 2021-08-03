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
- Basics
- Filtering techniques
  - TOP clause
- Match text with LIKE and wildcards
- JOINS
- Functions
  - Aggregate functions
  - Numerical functions
  - String functions
  - Date time functions
- Create temp table
- Subquery
- Window functions
- Condition statement
  - If else
  - CASE WHEN

***

## 📌 Logical Operators

Insert a table here


**NULL Values**

Take note that we cannot use `!=` or `<>` on NULL values.

````sql
SELECT WorkOrderID, ScrappedQty, ScrapReasonID
FROM Production.WorkOrder
WHERE ScrapReasonID IS NOT NULL;
````

***

## 📌 Comparison Operators

Insert a table here




## 📌 Match texts using LIKE and Wildcards

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

**DISTINCT Clause**

To remove duplicates and retrieve unique values only.
````sql
SELECT DISTINCT City, StateProvinceID
FROM Person.Address
ORDER BY City;
````

***

## 📌 Filtering Techniques

### TOP Clause

**Limit results with TOP**
````sql
SELECT TOP 3 TaxRate
FROM Sales.SalesTaxRate
ORDER BY TaxRate DESC;
````
***

**Limit results with TOP PERCENT**

Specify the number of percentage of results to generate. For example, to generate the first 50% of the results, use `TOP 50 PERCENT`. 

````sql
SELECT TOP 50 PERCENT TaxRate, Name
FROM Sales.SalesTaxRate
ORDER BY TaxRate DESC;
````
***
**Limit results with TOP X WITH TIES**

Results include multiple records of the same values from the last record. 

For example, we are interested to know the Top 5 students in the classroom. Since there are 2 students who have received the same 5th highest score in the classroom, hence there will be a total of 6 rows of records in the results table - 1, 2, 3, 4, 5, 5.

````sql
SELECT TOP 5 WITH TIES student_name, score
FROM classroom
ORDER BY score;
````
