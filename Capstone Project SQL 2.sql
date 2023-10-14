-- 1. CUSTOMER TABLE 


-- 1. Number of Customers

SELECT count(DISTINCT customerNumber) as Number_of_Customers 
FROM customers;


-- 2. Number of Cities

SELECT count(DISTINCT city) as Number_of_Cities
FROM customers;


-- 3. Number of Countries

SELECT count(DISTINCT country) as Number_of_Countries
FROM customers;


-- 4. Number of cities as per country

SELECT country,
count(city) as Number_of_countries
FROM customers
GROUP BY 1
ORDER BY 2 desc;

-- 5. Number of Customers as per City

SELECT city,
count(DISTINCT customerNumber) as Total_Customers
FROM customers
GROUP BY 1
ORDER BY 2 desc
limit 5;


-- 6. Number of Customers as per Country

SELECT country,
count(DISTINCT customerNumber) as Total_Customers
FROM customers
GROUP BY 1
ORDER BY 2 desc
limit 5;


-- 7. Number of Cities as per Country

SELECT country,
count(DISTINCT city) as Total_City
FROM customers
GROUP BY 1
ORDER BY 2 desc;


-- 8. Top 5 Customers ranked by Sales

SELECT customerName,
round(sum(quantityOrdered * priceEach),0) as Total_Sale
FROM customers c
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 9. Top 5 Cities ranked by Sales

SELECT city,
round(sum(quantityOrdered * priceEach),0) as Total_Sale
FROM customers c
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 10. Top 5 Countries ranked by Sales

SELECT country,
round(sum(quantityOrdered * priceEach),0) as Total_Sale
FROM customers c
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 11. Top 5 Customers ranked by Amount

SELECT customerName,
round(sum(amount),0) as Amount
FROM customers c
join payments p on c.customerNumber = p.customerNumber
GROUP BY 1
ORDER BY 2 desc
limit 5;


-- 12. Top 5 Cities ranked by Amount

SELECT city,
round(sum(amount),0) as Amount
FROM customers c
join payments p on c.customerNumber = p.customerNumber
GROUP BY 1
ORDER BY 2 desc
limit 5;


-- 13. Top 5 Countries ranked by Amount

SELECT country,
round(sum(amount),0) as Amount
FROM customers c
join payments p on c.customerNumber = p.customerNumber
GROUP BY 1
ORDER BY 2 desc
limit 5;


-- 14. Top 5 Customers ranked by Credit Limit

SELECT customerName,
round(sum(creditLimit),0) as Credit_Limit 
FROM customers
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 15. Top 5 Cities ranked by Credit Limit

SELECT City,
round(sum(creditLimit),0) as Credit_Limit 
FROM customers
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;

-- 16. Top 5 Countries ranked by Credit Limit

SELECT country,
round(sum(creditLimit),0) as Credit_Limit 
FROM customers
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 17. Top 5 Customers ranked by Profit

SELECT customerName, 
round(sum(quantityOrdered * (priceEach - buyPrice)),0) as Profit
FROM customers c
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
join products p on od.productCode = p.productCode
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 18. Top 5 Cities ranked by Profit

SELECT city, 
round(sum(quantityOrdered * (priceEach - buyPrice)),0) as Profit
FROM customers c
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
join products p on od.productCode = p.productCode
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 19. Top 5 Countries ranked by Profit

SELECT country, 
round(sum(quantityOrdered * (priceEach - buyPrice)),0) as Profit
FROM customers c
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
join products p on od.productCode = p.productCode
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 20. Cities with maximum sales as per Country 

SELECT country, city, Total_sale
FROM (
    SELECT country, city, round(sum(quantityordered * priceeach),0) as Total_Sale,
           RANK() OVER (PARTITION BY country ORDER BY sum(quantityordered * priceeach) DESC) AS sales_rank
    FROM customers c
    join orders o on c.customerNumber = o.customerNumber
    join orderdetails od on o.orderNumber = od.orderNumber
    GROUP BY 1,2
    ORDER BY 3 desc
) ranked_sales
WHERE sales_rank = 1;


-- 2. EMPLOYEES TABLE 

-- 1. Number of Employees

SELECT count(employeeNumber) as Number_of_Employees
FROM employees;


-- 2. Number of JobTitle

SELECT count(DISTINCT JobTitle) as Number_of_JobTitle 
FROM employees;


-- 3. Top 5 Employees ranked by Sales

SELECT concat(e.firstName, ' ', e.lastname) as Employees_Name,
round(sum(quantityOrdered * priceEach),0) as Sale FROM employees e
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 4. Top 5 Employees ranked by Profit

SELECT concat(e.firstName, ' ', e.lastname) as Employees_Name,
round(sum(quantityOrdered * (priceEach - buyprice)),0) as Sale FROM employees e
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
join products p on od.productCode = p.productCode
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 5. Top 5 Employees ranked by Amount

SELECT concat(e.firstName, ' ', e.lastname) as Employees_Name,
round(sum(amount),0) as Amount FROM employees e
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
join payments p on c.customerNumber =p.customerNumber
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;   



-- 3. OFFICES TABLE


-- 1. Number of Offices

SELECT count(DISTINCT city) as "Number of Offices"
FROM offices;


-- 2. Number of Country

SELECT count(DISTINCT country) as  "Number of Counties"
FROM offices;


-- 3. Number of Territory

SELECT count(DISTINCT territory) "Number of Territory" 
FROM offices;


-- 4. Number of Offices as per country

SELECT Country,
count(city) as Office
FROM offices
GROUP BY 1;


-- 5. Sales by City (Office) 

SELECT o.City,
round(sum(quantityOrdered * priceEach),0) as Sales FROM offices o
join employees e on o.officeCode = e.officeCode
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
join orders os on c.customerNumber = os.customerNumber
join orderdetails od on os.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 desc;


-- 6. Sales by Country(Office)

SELECT o.country,
round(sum(quantityOrdered * priceEach),0) as Sales FROM offices o
join employees e on o.officeCode = e.officeCode
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
join orders os on c.customerNumber = os.customerNumber
join orderdetails od on os.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 desc;


-- 7. Sales by Territory

SELECT o.Territory,
round(sum(quantityOrdered * priceEach),0) as Sales FROM offices o
join employees e on o.officeCode = e.officeCode
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
join orders os on c.customerNumber = os.customerNumber
join orderdetails od on os.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 desc;


-- 8. Profit by City (Office)

SELECT o.City,
round(sum(quantityOrdered * (priceEach - buyprice)),0) as Sales FROM offices o
join employees e on o.officeCode = e.officeCode
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
join orders os on c.customerNumber = os.customerNumber
join orderdetails od on os.orderNumber = od.orderNumber
join products p on od.productCode = p.productCode
GROUP BY 1
ORDER BY 2 desc;
 
 
-- 9. Profit by Country(Office)

SELECT o.country,
round(sum(quantityOrdered * (priceEach - buyprice)),0) as Sales FROM offices o
join employees e on o.officeCode = e.officeCode
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
join orders os on c.customerNumber = os.customerNumber
join orderdetails od on os.orderNumber = od.orderNumber
join products p on od.productCode = p.productCode
GROUP BY 1
ORDER BY 2 desc;

-- 10. Profit by Territory

SELECT o.territory,
round(sum(quantityOrdered * (priceEach - buyprice)),0) as Sales FROM offices o
join employees e on o.officeCode = e.officeCode
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
join orders os on c.customerNumber = os.customerNumber
join orderdetails od on os.orderNumber = od.orderNumber
join products p on od.productCode = p.productCode
GROUP BY 1
ORDER BY 2 desc;




-- 4. ORDERDETAILS TABLE


-- 1. Number of orderLine

SELECT count(DISTINCT orderLineNumber) as "Number of Orderlinr"
FROM orderdetails;


-- 2. Sales by OrderNumber

SELECT orderNumber,
round(sum(quantityOrdered * priceEach),0) as Sales
FROM orderdetails
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 3. Sales by ProductCode

SELECT productCode,
round(sum(quantityOrdered * priceEach),0) as Sales
FROM orderdetails
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 4. Sales by OrderLine

SELECT orderLineNumber,
round(sum(quantityOrdered * priceEach),0) as Sales
FROM orderdetails
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 5. Profit by OrderNumber

SELECT orderNumber,
round(sum(quantityOrdered * (priceEach - buyprice)),0) as Sales
FROM orderdetails od 
join products p on od.productCode = p.productCode
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 6. Profit by ProductCode

SELECT p.productCode,
round(sum(quantityOrdered * (priceEach - buyprice)),0) as Sales
FROM orderdetails od 
join products p on od.productCode = p.productCode
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 7. Profit by OrderLine

SELECT orderLineNumber,
round(sum(quantityOrdered * (priceEach - buyprice)),0) as Sales
FROM orderdetails od 
join products p on od.productCode = p.productCode
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 8. Top 5 Order Number ranked by Quantity ordered

SELECT orderNumber,
sum(quantityOrdered) as Quantity_ordered 
FROM orderdetails
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 9. Top 5 Product Code ranked by Quantity ordered

SELECT productCode,
sum(quantityOrdered) as Quantity_ordered
FROM orderdetails
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 10. Top 5 Order Line ranked by Quantity ordered

SELECT orderLineNumber,
sum(quantityOrdered) as Quantity_ordered
FROM orderdetails
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 11. Top 5 Customers ranked by Quantity ordered

SELECT CustomerName,
sum(quantityOrdered) as Quantity_ordered
from customers c
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 12. Top 5 City ranked by Quantity ordered

SELECT City,
sum(quantityOrdered) as Quantity_ordered
from customers c
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 13. Top 5 Country ranked by Quantity ordered

SELECT Country,
sum(quantityOrdered) as Quantity_ordered
from customers c
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 desc
LIMIT 5;


-- 14. Quantity Ordered by Month

SELECT month(orderDate) as MonthNumber, 
monthname(orderDate) as MonthName,
round(sum(quantityOrdered),0) as Quantity_Ordered
FROM orders o
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1,2
ORDER BY 1,3 desc; 


-- 15. Quantity Ordered by Quarter

SELECT quarter(orderDate) as QuarterNumber, 
round(sum(quantityOrdered),0) as Quantity_Ordered
FROM orders o
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 1;


-- 16. Quantity Ordered by Year

SELECT year(orderDate) as Years, 
round(sum(quantityOrdered),0) as Quantity_Ordered
FROM orders o
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 1;



-- 5. ORDERS TABLE

-- 1. Number of Orders

SELECT count(*) as Number_of_Orders 
FROM orders;


-- 2. Status count

SELECT status,
count(status) as Counts 
FROM orders
GROUP BY 1;


-- 3. Sales by Month

SELECT month(orderDate) as MonthNumber,
monthname(orderDate) as MonthName,
round(sum(quantityOrdered * priceEach),0) as Sales 
FROM orders o 
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1,2
ORDER BY 1;


-- 4. Sales by Quarter

SELECT quarter(orderDate) as Quarter,
round(sum(quantityOrdered * priceEach),0) as Sales 
FROM orders o 
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 1; 


-- 5. Sales by Year

SELECT year(orderDate) as Years,
round(sum(quantityOrdered * priceEach),0) as Sales 
FROM orders o 
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 1;


-- 6. Profit by Months

SELECT month(orderDate) as MonthNumber,
monthname(orderDate) as MonthName,
round(sum(quantityOrdered * (priceEach - buyprice)),0) as Profit 
FROM orders o 
join orderdetails od on o.orderNumber = od.orderNumber
join products p on p.productCode = od.productCode
GROUP BY 1,2
ORDER BY 1;


-- 7. Profit by Quarter

SELECT quarter(orderDate) as Quarter,
round(sum(quantityOrdered * (priceEach - buyprice)),0) as Profit 
FROM orders o 
join orderdetails od on o.orderNumber = od.orderNumber
join products p on p.productCode = od.productCode
GROUP BY 1
ORDER BY 1;


-- 8. Profit by Year

SELECT year(orderDate) as Years,
round(sum(quantityOrdered * (priceEach - buyprice)),0) as Profit 
FROM orders o 
join orderdetails od on o.orderNumber = od.orderNumber
join products p on p.productCode = od.productCode
GROUP BY 1
ORDER BY 1;



-- 7. PRODUCTLINES TABLE

-- 1. Sales by ProductLine

SELECT p.productLine,
round(sum(quantityOrdered * priceEach),0) as Sale 
FROM productlines pl
join products p on pl.productLine = p.productLine
join orderdetails od on p.productCode = od.productCode
GROUP BY 1
ORDER BY 2 desc;


-- 2. Profit by ProductLine

SELECT p.productLine,
round(sum(quantityOrdered * (priceEach - buyprice)),0) as Profit
FROM productlines pl
join products p on pl.productLine = p.productLine
join orderdetails od on p.productCode = od.productCode
GROUP BY 1
ORDER BY 2 desc;


-- 3. Quantity Ordered by Product Line

SELECT p.productLine,
sum(quantityOrdered) as Quantity_ordered
FROM products p 
join orderdetails od on p.productCode = od.productCode
GROUP BY 1
ORDER BY 2 desc;


-- 8. PRODUCTS TABLE

-- 1. Number of Products

SELECT count(productCode) as Number_of_Product 
FROM products;


-- 2. Top 5 product Code ranked by sales

SELECT p.productCode,
round(sum(quantityOrdered * priceEach),0) as Sale
FROM products p
join orderdetails od on p.productCode = od.productCode
GROUP BY 1
ORDER BY 2 desc;


-- 3. Top 5 product Code ranked by profit

SELECT p.productCode,
round(sum(quantityOrdered * (priceEach - buyprice)),0) as Profit
FROM products p
join orderdetails od on p.productCode = od.productCode
GROUP BY 1
ORDER BY 2 desc;


-- 4. Sales by product Vendors

SELECT productVendor,
round(sum(quantityOrdered * priceEach),0) as Sale
FROM products p
join orderdetails od on p.productCode = od.productCode
GROUP BY 1
ORDER BY 2 desc; 


-- 5. Profit by Product Vendors

SELECT productVendor,
round(sum(quantityOrdered * (priceEach - buyprice)),0) as Profit
FROM products p
join orderdetails od on p.productCode = od.productCode
GROUP BY 1
ORDER BY 2 desc; 


-- 6. Quantity in Stock by Product Name

SELECT productName,
sum(quantityInStock) as Quantity_in_stock
FROM products
GROUP BY 1
ORDER BY 2 DESC;


-- 7. Quantity in Stock by Product Line

SELECT productLine,
sum(quantityInStock) as Quantity_in_stock
FROM products
GROUP BY 1
ORDER BY 2 DESC;


-- 8. Quantity in Stock by Product Vendors

SELECT productVendor,
sum(quantityInStock) as Quantity_in_stock
FROM products
GROUP BY 1
ORDER BY 2 DESC;



-- EXTRA

-- 1. Number of employees as per country

SELECT Country,
count(employeeNumber) as "Number of Employee"
FROM employees e
join offices o on e.officeCode = o.officeCode
GROUP BY 1;


-- 2. Number of orders per country

SELECT country,
count(orderNumber) as "Number od Orders"
FROM customers c
join orders o on o.customerNumber = c.customerNumber
GROUP BY 1
ORDER BY 2 DESC; 


-- 3. Number of orders per City

SELECT city,
count(orderNumber) as "Number of Orders"
FROM customers c
join orders o on o.customerNumber = c.customerNumber
GROUP BY 1
ORDER BY 2 DESC; 


-- 4. Number of Quantity ordered per Country

SELECT country,
sum(quantityOrdered) as "Number of Orders"
FROM customers c
join orders o on o.customerNumber = c.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 DESC; 


-- 5. Number of Quantity ordered per City

SELECT city,
sum(quantityOrdered) as "Number of Orders"
FROM customers c
join orders o on o.customerNumber = c.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 DESC; 


-- 6. Number of products by Product Line

SELECT productLine,
count(productCode) as "Number of Products"
FROM products
GROUP BY 1
ORDER BY 2 desc;

-- 7. Quantity ordered by Product Line

SELECT productLine,
sum(quantityOrdered) as "Ordered Quantity" 
FROM products p
join orderdetails od on p.productCode = od.productCode
GROUP BY 1
ORDER BY 2 desc;

