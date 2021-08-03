# 📝 Katie's SQL Notes

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
