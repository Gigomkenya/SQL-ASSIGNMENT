-- 1. Write a query to select all data from the `Customers` table.

select * from Customers;

SELECT * FROM assignment.Products;



SELECT * FROM assignment.Inventory;

-- 2. Write a query to select the total number of products from the `Products` table.

select count(*)  AS total_products
from products p 
;


-- 3. Write a query to select the product name and its price from the `Products` table where the price is greater than 500.

select p.product_name,p.price
from products p
where price > 500;


-- 4. Write a query to find the average price of all products from the `Products` table.

select avg(price)
from products;


-- 5. Write a query to find the total sales amount from the `Sales` table.

select sum(total_amount) as total_sales
from Sales;

-- 6. Write a query to select distinct membership statuses from the `Customers` table.

select distinct membership_status
from customers;


-- 7. Write a query to concatenate first and last names of all customers and show the result as `full_name`.


select concat(first_name,' ',last_name) as full_name
from customers c;


-- 8. Write a query to find all products in the `Products` table where the category is 'Electronics'.


select product_name
from products p
 where category = 'Electronics';

-- 9. Write a query to find the highest price from the `Products` table.


select max(price)as highest_price
 from Products;

-- 10. Write a query to count the number of sales for each product from the `Sales` table.


SELECT product_id, COUNT(*) AS total_sales
FROM Sales
GROUP BY product_id;

-- 11. Write a query to find the total quantity sold for each product from the `Sales` table.

select product_id ,count(*) as quantity_sold
from sales s 
group by product_id;

-- 12. Write a query to find the lowest price of products in the `Products` table.

select min(price) as lowest_price
from products p ;

-- 13. Write a query to find customers who have purchased products with a price greater than 1000.

SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id
JOIN Products p ON s.product_id = p.product_id
WHERE p.price > 1000;

-- 14. Write a query to join the `Sales` and `Products` tables on product_id, and select the product name and total sales amount.

SELECT p.product_name, SUM(s.quantity_sold * p.price) AS total_sales_amount
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name;


-- 15. Write a query to join the `Customers` and `Sales` tables and find the total amount spent by each customer.

select c.customer_id,avg(quantity_sold*total_amount) as amount_spent_each
from customers c 
join sales s on c.customer_id= s.customer_id
group by c.customer_id;

-- 16. Write a query to join the `Customers`, `Sales`, and `Products` tables, and show each customer's first and last name, product name, and quantity sold.

SELECT c.first_name, 
       c.last_name, 
       p.product_name, 
       s.quantity_sold
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id
JOIN Products p ON s.product_id = p.product_id;


-- 17. Write a query to perform a self-join on the `Customers` table and find all pairs of customers who have the same membership status.


SELECT  distinct a.first_name AS customer_name,
       a.last_name AS customer_name,
       b.first_name AS customer2_first_name,
       b.last_name AS customer2_last_name,
       a.membership_status
FROM Customers a, Customers b
WHERE a.membership_status = b.membership_status
  AND a.customer_id < b.customer_id;


-- 18. Write a query to join the `Sales` and `Products` tables, and calculate the total number of sales for each product.


select p.product_name,sum(quantity_sold) as sales_for_each
from products p 
join sales s  on p.product_id = s.product_id
group by p.product_name;

-- 19. Write a query to find the products in the `Products` table where the stock quantity is less than 10.

select product_name
from products p 
where p.stock_quantity <10;


-- 20. Write a query to join the `Sales` table and the `Products` table, and find products with sales greater than 5.
 
select s.product_id ,p.product_name ,
sum(s.quantity_sold)
from sales s 
join products p on s.product_id = p.product_id
GROUP BY s.product_id, p.product_name
having sum (s.quantity_sold) >5;

-- 21. Write a query to select customers who have purchased products that are either in the 'Electronics' or 'Appliances' category.

SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id
JOIN Products p ON s.product_id = p.product_id
WHERE p.category IN ('Electronics', 'Appliances');

-- 22. Write a query to calculate the total sales amount per product and group the result by product name.


select p.product_name,
sum(s.quantity_sold*p.price) as total_sales
from sales s 
join products p on s.product_id= p.product_id 
group by p.product_name ;

-- 23. Write a query to join the `Sales` table with the `Customers` table and select customers who made a purchase in the year 2023.


select DISTINCT c.customer_id,c.first_name,c.last_name
from customers c
join sales s   on c.customer_id = s.customer_id
where EXTRACT( year from s.sale_date )=2023;

-- 24. Write a query to find the customers with the highest total sales in 2023.

select  c.customer_id,c.first_name,c.last_name,
SUM(s.quantity_sold * p.price) AS total_sales
from customers c 
join sales s  on c.customer_id =s.customer_id 
join products p on s.product_id = p.product_id
where extract  (year from s.sale_date)=2023
group by c.customer_id,c.first_name ,c.last_name 
order by total_sales desc
;

-- 25. Write a query to join the `Products` and `Sales` tables and select the most expensive product sold.

select p.product_id,p.product_name,p.price 
from products p
join sales s on s.product_id=p.product_id
order by p.price
limit 1;

-- 26. Write a query to find the total number of customers who have purchased products worth more than 500.

select count(c.customer_id) as total_customers
from customers c
join sales s on c.customer_id = s.customer_id
join products p on s.product_id=p.product_id
where p.price >500;

-- 27. Write a query to join the `Products`, `Sales`, and `Customers` tables and find the total number of sales made by customers who are in the 'Gold' membership tier.

select count(*) as total_sales
from products p 
join sales s on p.product_id = s.product_id
join Customers c  on s.customer_id= c.customer_id 
where c.membership_status = 'Gold';


-- 28. Write a query to join the `Products` and `Inventory` tables and find all products that have low stock (less than 10).

select min(i.stock_quantity) as low_stock
from products p 
join inventory i  on p.product_id = i.product_id
where i.stock_quantity < 10;


-- 29. Write a query to find customers who have purchased more than 5 products and show the total quantity of products they have bought.

SELECT c.customer_id,c.first_name,c.last_name,
SUM(s.quantity_sold) AS total_quantity
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(s.quantity_sold) > 5;


-- 30. Write a query to find the average quantity sold per product.

SELECT product_id,
AVG(quantity_sold) AS average_quantity_sold
FROM Sales s
GROUP BY product_id;

-- 31. Write a query to find the number of sales made in the month of December 2023.

select count(*)  as total_sales
from sales s 
WHERE EXTRACT(YEAR FROM s.sale_date) = 2023
AND EXTRACT(MONTH FROM s.sale_date) = 12;


-- 32. Write a query to find the total amount spent by each customer in 2023 and list the customers in descending order.
 

SELECT c.customer_id,c.first_name,c.last_name,
SUM(s.quantity_sold * p.price) AS total_amount
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id
JOIN Products p ON p.product_id = s.product_id
WHERE EXTRACT(YEAR FROM s.sale_date) = 2023
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_amount DESC;

-- 33. Write a query to find all products that have been sold but have less than 5 units left in stock.

select distinct p.product_id,p.product_name,p.stock_quantity 
from products p 
join Sales s on s.product_id =p.product_id 
GROUP BY p.product_id, p.product_name
having sum (s.quantity_sold) <5;

-- 34. Write a query to find the total sales for each product and order the result by the highest sales.

SELECT p.product_id, p.product_name,
SUM(s.quantity_sold ) AS total_sales
FROM Products p
JOIN Sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC;

-- 35. Write a query to find all customers who bought products within 7 days of their registration date.

SELECT DISTINCT c.customer_id,c.first_name,c.last_name,c.registration_date,s.sale_date
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id
WHERE s.sale_date <= c.registration_date + INTERVAL '7 days';

-- 36. Write a query to join the `Sales` table with the `Products` table and filter the results by products priced between 100 and 500.

select s.product_id, s.sale_id,s.customer_id,p.product_name, p.price,s.quantity_sold 
from sales s 
join products p on s.product_id = p.product_id 
WHERE p.price BETWEEN 100 AND 500;

-- 37. Write a query to find the most frequent customer who made purchases from the `Sales` table.

select c.customer_id,c.first_name,c.last_name,
count(s.sale_id) as total_purchases
from customers c 
join sales s on c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_purchases desc
LIMIT 1;

-- 38. Write a query to find the total quantity of products sold per customer.

select c.customer_id,c.first_name,c.last_name,
count(s.quantity_sold) as total_sold
from customers c 
join sales s on c.customer_id =s.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name
order by total_sold desc;

-- 39. Write a query to find the products with the highest stock and lowest stock, and display them together in a single result set.

(SELECT product_id, product_name, stock_quantity, 'Highest Stock' AS stock_type
 FROM Products
 ORDER BY stock_quantity DESC
 LIMIT 1)
UNION
(SELECT product_id, product_name, stock_quantity, 'Lowest Stock' AS stock_type
 FROM Products
 ORDER BY stock_quantity ASC
 LIMIT 1);


-- 40. Write a query to find products whose names contain the word 'Phone' and their total sales.

SELECT p.product_id,p.product_name,
SUM(s.quantity_sold) AS total_sales
FROM Products p
JOIN Sales s ON p.product_id = s.product_id
WHERE p.product_name ILIKE '%Phone%'
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC;

-- 41. Write a query to perform an `INNER JOIN` between `Customers` and `Sales`, then display the total sales amount and the product names for customers in the 'Gold' membership status.

select c.customer_id,c.first_name,c.last_name,p.product_name,
sum(s.quantity_sold*p.price) as Total_sales
from Customers c
inner join sales s on c.customer_id=s.customer_id
inner join Products p on s.product_id=p.product_id
where c.membership_status ='Gold'
GROUP BY c.customer_id, c.first_name, c.last_name, p.product_name
ORDER BY Total_sales DESC;

-- 42. Write a query to find the total sales of products by category.

select p.category,
sum(s.quantity_sold * p.price) as total_sales
from Products p
join sales S on s.product_id =p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- 43. Write a query to join the `Products` table with the `Sales` table, and calculate the total sales for each product, grouped by month and year.

SELECT p.product_name,
EXTRACT(YEAR FROM s.sale_date) AS year,
EXTRACT(MONTH FROM s.sale_date) AS month,
SUM(s.quantity_sold * p.price) AS total_sales
FROM Products p
JOIN Sales s ON p.product_id = s.product_id
GROUP BY p.product_name,
EXTRACT(YEAR FROM s.sale_date),
EXTRACT(MONTH FROM s.sale_date)
ORDER BY year, month;


-- 44. Write a query to join the `Sales` and `Inventory` tables and find products that have been sold but still have stock remaining.

SELECT s.product_id
FROM Sales s
JOIN Inventory i ON s.product_id = i.product_id
WHERE i.stock_quantity > 0;


-- 45. Write a query to find the top 5 customers who have made the highest purchases.

select c.customer_id,c.first_name,c.last_name,
SUM(s.quantity_sold * p.price) AS total_purchase
from customers c 
join sales s on s.customer_id =c.customer_id 
JOIN Products p ON s.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_purchase DESC
LIMIT 5;


-- 46. Write a query to calculate the total number of unique products sold in 2023.

SELECT COUNT(DISTINCT product_id)
FROM Sales s
WHERE EXTRACT(YEAR FROM sale_date) = 2023;


-- 47. Write a query to find the products that have not been sold in the last 6 months.
select p.product_id,p.product_name
from products p
left join sales s on p.product_id = s.product_id 
And s.sale_date >= CURRENT_DATE - INTERVAL '6 months'
Where s.product_id IS NULL;


-- 48. Write a query to select the products with a price range between $200 and $800, and find the total quantity sold for each.

SELECT p.product_id, p.product_name,
SUM(s.quantity_sold) AS total_sold
FROM products p
JOIN sales s ON p.product_id = s.product_id
WHERE p.price BETWEEN 200 AND 800
GROUP BY p.product_id, p.product_name;


-- 49. Write a query to find the customers who spent the most money in the year 2023.

select C.customer_id,c.first_name,c.last_name,
sum(s.quantity_sold*p.price) as most_spent
from customers c 
join sales s on c.customer_id = s.customer_id
join products p on p.product_id =s.product_id 
where extract (year from sale_date)=2023 
group by c.customer_id ,c.first_name ,c.last_name 
order by most_spent desc
limit 1;

-- 50. Write a query to select the products that have been sold more than 100 times and have a price greater than 200.

SELECT p.product_id, p.product_name,
SUM(s.quantity_sold) AS total_sold
FROM Products p
JOIN Sales s ON p.product_id = s.product_id
WHERE p.price > 200
GROUP BY p.product_id, p.product_name
HAVING SUM(s.quantity_sold) > 100;

