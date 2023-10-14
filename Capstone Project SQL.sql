-- LEVEL-1 --

-- 1. : Prepare a list of offices sorted by country,state,city

SELECT officeCode, country, state, city from offices
ORDER BY 2,3,4;


-- 2. How many employees are there in the company.

SELECT COUNT(DISTINCT employeeNumber) AS Total_Employee 
FROM employees;


-- 3. What is the total of payments received.

SELECT sum(amount) as "Total_Payment" from payments;


-- 4. List the product lines that contain 'Cars'.

SELECT * from productlines
where productLine like '%cars%';

-- 5. Report total payments for October 28, 2004.

SELECT PaymentDate, amount as Total_Amount from payments
where paymentdate = "2004-10-28";


-- 6. Report those payments greater than $100,000.

SELECT * from payments
where amount > 100000;


-- 7. List the products in each product line.

SELECT productLine, productName from products
ORDER BY 1;


-- 8. How many products in each product line?

SELECT productline, count(productname) as "No of Products"
from products
GROUP BY 1
ORDER BY 2;


-- 9. What is the minimum payment received?

SELECT min(amount) as Minimum_Amount 
from payments;


-- 10. List all payments greater than twice the average payment.

SELECT amount FROM payments where amount > (
SELECT 2 * avg(amount) from payments)
ORDER BY 1;


-- 11. What is the average percentage markup of the MSRP on buyPrice?

SELECT round(avg((MSRP - buyPrice)/buyPrice) * 100, 2) as "Avg_Markup_Percentage" 
from products;


-- 12. How many distinct products does ClassicModels sell?

SELECT count(DISTINCT productCode) as "Total_Products"
FROM products;


-- 13. Report the name and city of customers who don't have sales representatives?

SELECT customerName, city from customers
where salesRepEmployeeNumber is null;


/* 14. What are the names of executives with VP or Manager in their title? 
Use the CONCAT function to combine the employee's first name and last name into a single field for reporting.   */

SELECT firstName, lastName, concat(firstName, " ", lastName) as Full_Name, jobTitle from employees
where jobTitle like '%Vp%' 
or jobTitle like '%Manager%';


-- 15. Which orders have a value greater than $5,000?

SELECT orderNumber, sum(quantityOrdered * priceEach) as Order_value
FROM orderdetails
GROUP BY 1
HAVING order_value > 5000
ORDER BY 2;



-- LEVEL-2

-- 1. Report the account representative for each customer.

SELECT customerNumber, customerName, employeeNumber, concat(e.firstname, " ", e.lastname) as Account_Representative 
FROM customers c
inner join employees e on c.salesRepEmployeeNumber = e.employeeNumber; 


-- 2. Report total payments for Atelier graphique.

SELECT customerNumber, sum(amount) as Total_Payment FROM payments where customerNumber in (
SELECT customerNumber FROM customers
where customerName = "Atelier graphique")
GROUP BY 1;


-- 3. Report the total payments by date

SELECT paymentDate, sum(amount) as Total_Payment FROM payments
GROUP BY 1
ORDER BY 1;


-- 4. Report the products that have not been sold.

SELECT productCode, productName from products WHERE productCode not in (
SELECT DISTINCT productCode FROM orderdetails);


-- 5.List the amount paid by each customer.

SELECT c.customerNumber, c.customerName, round(sum(amount),0) as Amount_Paid FROM customers c
inner join payments p on c.customerNumber = p.customerNumber
GROUP BY 1
ORDER BY 3 desc;


-- 6. How many orders have been placed by Herkku Gifts?

SELECT count(*) as No_of_Orders FROM orders where customerNumber in (
SELECT customerNumber FROM customers
where customerName = 'Herkku Gifts');


-- 7. Who are the employees in Boston?

SELECT concat(firstname, " ", lastname) as Employee_Name FROM employees 
where officeCode = (
SELECT officeCode FROM offices
where city = 'Boston');

SELECT concat(firstname, " ", lastname) as Employee_Name, o.city from employees e 
INNER join offices o on e.officeCode = o.officeCode
where city = 'Boston';


-- 8. Report those payments greater than $100,000. Sort the report so the customer who made the highest payment appears first.

SELECT c.customerNumber, customerName, sum(amount) as Total_Payment FROM customers c
INNER join payments p on c.customerNumber = p.customerNumber
GROUP BY 1
having Total_Payment > 100000
ORDER BY 3 desc;


-- 9. List the value of 'On Hold' orders.

SELECT sum(quantityOrdered * priceEach) as Total_Value FROM orderdetails
where orderNumber in
(SELECT orderNumber FROM orders
WHERE status = 'On hold');


-- 10. Report the number of orders 'On Hold' for each customer.

SELECT c.customerNumber, c.customerName, count(*) as No_of_orders from orders o 
inner join customers c on o.customerNumber = c.customerNumber
where status = 'on hold'
GROUP BY 1;



-- LEVEL ==> 3


-- 1. List products sold by order date.

SELECT o.orderDate, productName FROM products p
inner join orderdetails od on p.productCode = od.productCode
inner join orders o on od.orderNumber = o.orderNumber
ORDER BY 1;


-- 2. List the order dates in descending order for orders for the 1940 Ford Pickup Truck.

SELECT orderDate from orders o
inner join orderdetails od on o.orderNumber = od.orderNumber
where productCode in (
SELECT productCode FROM products
where productName = '1940 Ford Pickup Truck')
ORDER BY 1 desc;


/* 3. List the names of customers and their corresponding order number where a particular order 
   from that customer has a value greater than $25,000? */

SELECT o.orderNumber, customerName, sum(quantityOrdered * priceEach) as Total_Value FROM customers c
inner join orders o on c.customerNumber = o.customerNumber
inner join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
HAVING Total_Value > 25000;


-- 4. Are there any products that appear on all orders?

SELECT p.productCode, p.productName
FROM products p
INNER JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY 1
HAVING COUNT(DISTINCT od.orderNumber) = (SELECT COUNT(DISTINCT orderNumber) FROM orderdetails);


-- 5. List the names of products sold at less than 80% of the MSRP.

SELECT DISTINCT productName, priceEach, MSRP from orderdetails od
inner join products p
on od.productCode = p.productCode
where priceEach < (0.8 * MSRP);


-- 6. Reports those products that have been sold with a markup of 100% or more (i.e.,  the priceEach is at least twice the buyPrice)

SELECT productName, priceEach, buyPrice
FROM products p
inner join orderdetails od on p.productCode = od.productCode
where priceEach >= 2 * buyPrice;


-- 7. List the products ordered on a Monday.

SELECT DISTINCT p.productCode, productName FROM products p
inner join orderdetails od on p.productCode = od.productCode
where orderNumber in (
SELECT orderNumber FROM orders
where dayname(orderdate) = 'Monday');


-- 8. What is the quantity on hand for products listed on 'On Hold' orders?

SELECT productName, status, quantityOrdered FROM products p
inner join orderdetails od on p.productCode = od.productCode
inner join orders o on o.orderNumber = od.orderNumber
HAVING status = 'On hold';




-- LEVEL ==> 4


-- 1. Find products containing the name 'Ford'.

SELECT productName 
FROM products
WHERE productName REGEXP 'ford';


-- 2. List products ending in 'ship'.

SELECT productName 
FROM products
WHERE productName REGEXP 'ship$';

 
-- 3. Report the number of customers in Denmark, Norway, and Sweden.

SELECT country, count(country) as Number_of_customers FROM customers
where country REGEXP 'Denmark|Norway|sweden'
GROUP BY 1;


-- 4. What are the products with a product code in the range S700_1000 to S700_1499?

SELECT productCode, productName from products
WHERE productCode REGEXP 'S700_1[0-4][0-9]{2}';


-- 5. Which customers have a digit in their name?

SELECT * FROM customers
where customerName REGEXP '[0-9]';


-- 6. List the names of employees called Dianne or Diane.

SELECT firstName 
FROM employees
where firstName REGEXP 'Dian';


-- 7. List the products containing ship or boat in their product name.

SELECT productName FROM products
where productName REGEXP 'Ship|boat';


-- 8. List the products with a product code beginning with S700.

SELECT productCode
from products
where productCode REGEXP '^S700';


-- 9. List the names of employees called Larry or Barry.

SELECT firstName from employees
where firstName REGEXP '[bl]arry';


-- 10. List the names of employees with non-alphabetic characters in their names.

SELECT * FROM employees
where firstName REGEXP '[^A-Za-z]';


-- 11. List the vendors whose name ends in Diecast

SELECT DISTINCT productVendor 
FROM products
WHERE productVendor REGEXP 'Diecast$';



 -- LEVEL ==> 5


-- 1. Who is at the top of the organization (i.e.,  reports to no one).

SELECT * FROM employees
where reportsTo is null;


-- 2. Who reports to William Patterson?

SELECT firstName, lastName, employeeNumber FROM employees
where reportsTo = 
(SELECT employeeNumber 
FROM employees
where firstName = 'William' and lastName = 'patterson');


-- 3. List all the products purchased by Herkku Gifts.

SELECT productName FROM products p
inner join orderdetails od on p.productCode = od.productCode
inner join orders o on od.orderNumber = o.orderNumber
where customerNumber = (
SELECT customerNumber 
FROM customers
where customerName = 'Herkku Gifts');


/* 4. Compute the commission for each sales representative, assuming the commission is 5% of the value of an order. 
	  Sort by employee last name and first name. */

SELECT e.lastName, e.firstName, 
round(0.05 * sum(quantityOrdered * priceEach),0) as Commission 
FROM orderdetails od
inner join orders o on od.orderNumber = o.orderNumber
inner JOIN customers c on o.customerNumber = c.customerNumber
inner join employees e on c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY 2,1
ORDER BY 1;


-- 5. What is the difference in days between the most recent and oldest order date in the Orders file?

SELECT max(orderDate) as Last_Order, min(orderDate) as First_Order,
datediff(max(orderDate), min(orderDate)) as Days_Difference FROM orders;


-- 6. Compute the average time between order date and ship date for each customer ordered by the largest difference.

SELECT customerName, 
round(avg(datediff(shippedDate, orderDate)),2) as Avg_Diff_Bet_Ship_And_Order_Date 
FROM orders o
inner join customers c on o.customerNumber = c.customerNumber
GROUP BY 1
ORDER BY 2 desc;


-- 7. What is the value of orders shipped in August 2004? (Hint).

SELECT sum(quantityOrdered * priceEach) as Total_Value FROM orders o
inner join orderdetails od on o.orderNumber = od.orderNumber
where year(shippedDate) = 2004
and month(shippedDate) = 08;


/* 8. Compute the total value ordered, total amount paid, and their difference for 
      each customer for orders placed in 2004 and payments received in 2004 
      (Hint; Create views for the total paid and total ordered). */
	
CREATE View Payment_2004 as 
(   
SELECT c.customerName, sum(amount) as PayTotal from customers c 
join payments p on c.customerNumber = p.customerNumber
where year(paymentDate) = 2004
GROUP BY 1
ORDER BY 1);    

SELECT * FROM payment_2004;

CREATE view Order_2004 as
(
SELECT c.customerName,
sum(quantityOrdered * priceEach) as Order_Total
FROM customers c
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
where year(orderDate) = 2004
GROUP BY 1
ORDER BY 1);

SELECT * FROM order_2004;

SELECT Order_2004.customerName as Customer,
Order_Total,
PayTotal, 
(Order_Total - PayTotal) as Difference
from order_2004
join payment_2004 on order_2004.customerName = payment_2004.customerName
where ABS(PayTotal - Order_Total) > 0;


/* 9. List the employees who report to those employees who report to Diane Murphy. 
   Use the CONCAT function to combine the employee's first name and last name into a single field for reporting. */

SELECT concat(firstname, " ", lastname) as Employee_Name 
FROM employees where reportsTo in
(SELECT employeeNumber FROM employees where reportsTo = 
(SELECT employeeNumber FROM employees
where firstName = 'Diane' 
and lastName = 'murphy'));


-- 10. What is the percentage value of each product in inventory sorted by the highest percentage first. 

SELECT ProductName, 
round(quantityInStock * buyPrice, 0) as Stock,
round(((quantityInStock * buyPrice)/(Total_Value)) * 100, 2) as Percent
FROM products,
(SELECT sum(quantityInStock * buyPrice) as Total_Value FROM products) as T
ORDER BY 2 desc;


-- 11. What is the value of payments received in July 2004?

SELECT round(sum(amount),0) as Payment_received FROM payments
where year(paymentDate) = 2004
and month(paymentDate) = 07;

       		
-- 12. What is the difference in the amount received for each month of 2004 compared to 2003?
    
SELECT
    EXTRACT(MONTH FROM paymentdate) AS month,
    SUM(CASE WHEN YEAR(paymentdate) = 2003 THEN amount ELSE 0 END) AS amount_2003,
    SUM(CASE WHEN YEAR(paymentdate) = 2004 THEN amount ELSE 0 END) AS amount_2004,
    SUM(CASE WHEN YEAR(paymentdate) = 2004 THEN amount ELSE 0 END) -
    SUM(CASE WHEN YEAR(paymentdate) = 2003 THEN amount ELSE 0 END) AS difference
FROM payments
WHERE YEAR(paymentdate) IN (2003, 2004)
GROUP BY 1
ORDER BY 1;


/* 13. ABC reporting: Compute the revenue generated by each customer based on their orders. 
       Also, show each customer's revenue as a percentage of total revenue. Sort by customer name. */
       
SELECT customerName,
round(sum(quantityOrdered * priceEach),0) as Total_Revenue,
round((sum(quantityOrdered * priceEach)/(SELECT sum(quantityOrdered * priceEach) FROM orderdetails)) * 100,2) 
as Percent
FROM customers c
inner join orders o on c.customerNumber = o.customerNumber
inner join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 1;

       
/* 14. Compute the profit generated by each customer based on their orders.
       Also, show each customer's profit as a percentage of total profit. Sort by profit descending. */
       
SELECT c.customerName, 
sum(quantityOrdered * (priceEach - buyPrice)) as Profit,
round(sum(quantityOrdered * (priceEach - buyPrice))/(select sum(quantityOrdered * (priceEach - buyPrice)) 
from orderdetails od
inner join products p on od.productCode = p.productCode)*100,2) as Percent
from customers c
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
join products p on od.productCode = p.productCode
GROUP BY 1
ORDER BY 2 desc;


/* 15. Compute the revenue generated by each sales representative 
       based on the orders from the customers they serve. */
       
SELECT concat(e.firstname, " ", e.lastname) as Employee_Name,
round(sum(quantityOrdered * priceEach),0) as Employee_Revenue
FROM employees e
join customers c on c.salesRepEmployeeNumber = e.employeeNumber
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 desc;


/* 16. Compute the profit generated by each sales representative based 
       on the orders from the customers they serve. Sort by profit generated descending.*/
       
SELECT concat(e.firstname, " " ,e.lastname) as Employee_Name,
round(sum(quantityOrdered * (priceEach - buyPrice)),0) as Employee_Profit from employees e
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
join products p on od.productCode = p.productCode
GROUP BY 1
ORDER BY 2 desc;


-- 17. Compute the revenue generated by each product, sorted by product name.

SELECT productName, 
round(sum(quantityOrdered * priceEach),0) as Revenue FROM products p
join orderdetails od on p.productCode = od.productCode
GROUP BY 1
ORDER BY 1;


-- 18. Compute the profit generated by each product line, sorted by profit descending.

SELECT productLine,
round(sum(quantityOrdered * (priceEach - buyPrice)),0) as Profit 
FROM products p
join orderdetails od on p.productCode = od.productCode
GROUP BY 1
ORDER BY 2 desc;


-- 19. Find the products sold in 2003 but not 2004.

SELECT * FROM orderdetails od 
join orders o on od.orderNumber = o.orderNumber
where year(orderdate) = 2003 
AND od.productCode not in (
SELECT productCode FROM orderdetails od
join orders o on od.orderNumber = o.orderNumber
where year(orderdate) = 2004);


-- 20. Find the customers without payments in 2003.

SELECT DISTINCT c.customerNumber, customerName FROM customers c
inner join payments p on c.customerNumber = p.customerNumber
where c.customerNumber not in 
(
SELECT customerNumber FROM payments
where year(paymentdate) = 2003
);