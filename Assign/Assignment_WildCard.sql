-- 1. write a SQL query to find the details of those salespeople who come from the 'Paris' City or 'Rome' City. Return salesman_id, name, city, commission.
select salesman_id,name,city,commission from salesman where city in ('Paris','Rome');

-- 2.write a SQL query to find the details of the salespeople who come from either 'Paris' or 'Rome'. Return salesman_id, name, city, commission.
select salesman_id,name,city,commission from salesman where city in ('Paris','Rome');

-- 3. write a SQL query to find the details of those salespeople who live in cities other than Paris and Rome. Return salesman_id, name, city, commission.  
select salesman_id,name,city,commission from salesman where city not in ('Paris','Rome');

-- 4. write a SQL query to retrieve the details of all customers whose ID belongs to any of the values 3007, 3008 or 3009. Return customer_id, cust_name, city, grade, and salesman_id.  
select customer_id, cust_name, city, grade, salesman_id from customer where customer_id in (3007,3008,3009);

-- 5. write a SQL query to find salespeople who receive commissions between 0.12 and 0.14 (begin and end values are included). Return salesman_id, name, city, and commission.  
select salesman_id, name, city, commission from salesman where commission between 0.12 and 0.14;

-- 6. write a SQL query to select orders between 500 and 4000 (begin and end values are included). Exclude orders amount 948.50 and 1983.43. Return ord_no, purch_amt, ord_date, customer_id, and salesman_id. 
select ord_no, purch_amt, ord_date, customer_id, salesman_id
from orders
where purch_amt between 500 and 4000 and purch_amt not in (948.50,1983.43);

-- 7. write a SQL query to retrieve the details of the salespeople whose names begin with any letter between 'A' and 'L' (not inclusive). Return salesman_id, name, city, commission. 
select salesman_id,name,city,commission from salesman where name > 'A' and name < 'L';

-- 8.write a SQL query to find the details of all salespeople except those whose names begin with any letter between 'A' and 'L' (not inclusive). Return salesman_id, name, city, commission.  
select salesman_id,name,city,commission from salesman where name > 'L';

-- 9.write a SQL query to retrieve the details of the customers whose names begins with the letter 'B'. Return customer_id, cust_name, city, grade, salesman_id.. 
select customer_id, cust_name, city, grade, salesman_id
from customer
where cust_name like 'B%';

-- 10. write a SQL query to find the details of the customers whose names end with the letter 'n'. Return customer_id, cust_name, city, grade, salesman_id.
select customer_id, cust_name, city, grade, salesman_id
from customer
where cust_name like '%n';

-- 11. write a SQL query to find the details of those salespeople whose names begin with ‘N’ and the fourth character is 'l'. Rests may be any character. Return salesman_id, name, city, commission. 
select salesman_id, name, city, commission
from salesman
where name like 'N__l%';

-- 12.write a SQL query to find those rows where col1 contains the escape character underscore ( _ ). Return col1.
select col1
from test_table
where col1 like '%\_%';

-- 13. write a SQL query to identify those rows where col1 does not contain the escape character underscore ( _ ). Return col1.
select col1
from test_table
where col1 not like '%\_%';

-- 14.write a SQL query to find rows in which col1 contains the forward slash character ( / ). Return col1.
select col1
from test_table
where col1 like '%/%';

-- 15. write a SQL query to identify those rows where col1 does not contain the forward slash character ( / ). Return col1.
select col1
from test_table
where col1 not like '%/%';

-- 16. write a SQL query to find those rows where col1 contains the string ( _/ ). Return col1.
select col1
from test_table
where col1 like '%\_/%';

-- 17. write a SQL query to find those rows where col1 does not contain the string ( _/ ). Return col1.
select col1
from test_table
where col1 not like '%\_/%';

-- 18. write a SQL query to find those rows where col1 contains the character percent ( % ). Return col1.
select col1
from test_table
where col1 like '%\%%';

-- 19. write a SQL query to find those rows where col1 does not contain the character percent ( % ). Return col1.
select col1
from test_table
where col1 not like '%\%%' ;

-- 20. write a SQL query to find all those customers who does not have any grade. Return customer_id, cust_name, city, grade, salesman_id.
select customer_id, cust_name, city, grade, salesman_id
from customer 
where grade is null;

-- 21. write a SQL query to locate all customers with a grade value. Return customer_id, cust_name,city, grade, salesman_id.
select customer_id, cust_name, city, grade, salesman_id
from customer 
where grade is not null;

-- 22. write a SQL query to locate the employees whose last name begins with the letter 'D'. Return emp_idno, emp_fname, emp_lname and emp_dept. 
select emp_idno, emp_fname, emp_lname,emp_dept
from employees
where emp_lname like 'D%';






