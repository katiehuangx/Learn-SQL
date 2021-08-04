# 📚 Serious SQL

## 🌎 Data Exploration

### 📌 Select and Sort Data

**What is the name of the category with the highest category_id in the dvd_rentals.category table?**

````sql
SELECT name, category_id
FROM dvd_rentals.category
ORDER BY category_id DESC
LIMIT 1;
````

**For the films with the longest length, what is the title of the “R” rated film with the lowest replacement_cost in dvd_rentals.film table?**

```sql
SELECT title, length, replacement_cost, rating
FROM dvd_rentals.film
WHERE rating = 'R'
ORDER BY length DESC, replacement_cost ASC; -- Returns longest to shortest length, followed by least replacement cost to most replacement cost
````

**Who was the manager of the store with the highest total_sales in the dvd_rentals.sales_by_store table?**

````sql
SELECT manager
FROM dvd_rentals.sales_by_store
ORDER BY total_sales DESC -- To find out highest to lowest total sales
LIMIT 1; - To return 1 row for highest total sales
````

**What is the postal_code of the city with the 5th highest city_id in the dvd_rentals.address table?**

````sql
SELECT postal_code
FROM dvd_rentals.address
ORDER BY city_id DESC
LIMIT 1 OFFSET 4; -- To return 5th row, offset the 1st 4 rows and limit results to 5th row only
````

***

## 📌 Returns Count and Distinct Values
