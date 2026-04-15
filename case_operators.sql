use north;
--
-- case statements --> for multiple options/conditions
-- 1. single --> work on = 
-- 2. searched --> work with operators
--

select * from orders;
select customer_id,order_date,
case
	when ship_via=1 then 'shipped from port 1'
    when ship_via=2 then 'shipped from port 2'
    when ship_via=3 then 'shipped from port 3'
end as status_of_port
from orders;


select * from hr.employees;
SELECT e.employee_id, e.department_id,
CASE 
    WHEN e.DEPARTMENT_ID = 90 THEN 'IT'
    WHEN e.DEPARTMENT_ID = 100 THEN 'Admin'
    WHEN e.DEPARTMENT_ID = 40 THEN 'HR'
END AS dept_name
FROM hr.employees e;

select * from orders;
select customer_id,order_date,
case 
	when employee_id=1 then 'ordered by 1'
    when employee_id=2 then 'ordered by 2'
    when employee_id=3 then 'ordered by 3'
    when employee_id=4 then 'ordered by 4'
    else 'not known'
end as employees_ordered
from orders;


select * from products;
select product_name,category_id,
case 
	when category_id=1 then 'category 1'
    when category_id=2 then 'category 2'
    when category_id=3 then 'category 3'
    else 'other'
end as cat_product
from products order by category_id;

select product_name,category_id,
case 
	when reorder_level between 0 and 10 then 'stop putting in the inventory'
    when reorder_level between 11 and 30 then 'make a medium stock'
    when reorder_level between 50 and 150 then 'make a high stock'
    else 'to be discuss'
end as reorder_product
from products;

# -----------------------------------------------------------------------------------
select product_name,standard_cost,list_price,
case
	when standard_cost=3.00 and list_price=3.500 then 'Dried Plums'
    when standard_cost=2.00 and list_price=4.00 then 'Garnola'
    else 'to be discussed'
end 
from products;

select * from orders;
select customer_id,order_date,payment_type,status_id,paid_date,
case 
	when payment_type is null and paid_date is null and status_id=3 then 'stop the shipping'
    when payment_type='cash' and status_id=0 then 'process order'
    when payment_type is null and paid_date is null then 'stop'
    else 'process the shipping'
end as status_of_order
from orders;

#------------------------------------------------
select * from orders;
select id,paid_date,
case
	when payment_type is null and timestampdiff(day,order_date,now()) > 30 then 'Overdue'
    when payment_type is null and timestampdiff(day,order_date,now()) < 30 then 'Due Soon'
    when payment_type is not null then 'Cleared'
    else 'processing data'
end as payment_status
from orders;

# -------------------------------------------------------------------
select * from purchase_orders;
select 
case
	when expected_date is null then 'no data set'
    when submitted_date > expected_date then 'Over Due'
    when timestampdiff(day,expected_date,now()) <= 7 then 'urgent'
    when timestampdiff(day,expected_date,now()) <= 30 then 'upcoming'
    when timestampdiff(day,expected_date,now()) > 30 then 'planned'
end as urgency_level
from purchase_orders;



select employee_id,
count(case when status_id=2 then 1 end) as shipped_orders,
count(case when status_id<2 then 1 end) as pending_orders
from orders
group by employee_id;


select * from products;
update products 
set list_price = 
	case category 
		when 'Beverages' then list_price*0.90
        when 'Condiments' then list_price*0.95
        when 'Seafood' then list_price*0.85
        else list_price
	end
where discontinued=0;


#-----------------------------------------------------------------------------------------------------
--
-- if statement
-- syntax -->  if(condition,if_block,else_block)
--
select product_name, discontinued, 
if (discontinued=0,'Disscontinued','Available') as status
from products;

select id, shipping_fee,
if (shipping_fee=0,'free','paid') as shipping_type
from orders;

select id,shipped_date,
if (shipped_date is null,'not shipped','shipped') as delivery_status
from orders;

select * from orders;
select id,paid_date,
if(paid_date is null,'not paid','paid') as payment_status
from orders;

select product_name, reorder_level,
if(reorder_level>10,'reorder required','not required') as reorder_status
from products;

select id,unit_price,discount,
if(discount > 1,unit_price*discount,0) as discount_amount
from order_details;

--
-- Operators
--

-- even employee_id
select id,first_name,
case when id % 2 = 0 then 'even'
	else 'odd'
end as status
from employees;
select * from employees;

-- =
use hr;
select employee_id,first_name,salary,hire_date
from employees where hire_date = '1987-06-17';

select employee_id,first_name,department_id
from employees
where department_id!=90;

select employee_id,first_name,department_id
from employees
where department_id<>90;

select employee_id,first_name,department_id
from employees
where department_id<=>90;

select employee_id,first_name,department_id
from employees
where department_id=90;


# find emp who were not hired in year 1987
select employee_id,first_name,hire_date
from employees
where year(hire_date) != '1987';

-- between
select employee_id,first_name,hire_date
from employees
where first_name between 'A' and 'E'		# str excludes last value
order by first_name;

select employee_id,first_name,hire_date
from employees
where employee_id between '100' and '105'
order by first_name;

select employee_id,first_name,hire_date
from employees
where hire_date between '1987-06-17' and '1987-06-21';

# comparison betweeen bitwise & and operators
select employee_id,first_name,hire_date,salary
from employees
where salary between 30000 and 31000;

select employee_id,first_name,hire_date,salary
from employees
where salary>= 30000 and salary<=31000;

use north;
select * from employees;
select employee_id,first_name,hire_date,salary
from employees
where salary not between 1000 and 2000;

select employee_id,first_name,hire_date,salary
from employees
where salary>= 1000 or salary<=2000;

# ---------------------------------------------
use northwind;
select * from products;
select minimum_reorder_quantity from products where minimum_reorder_quantity between 5 and 30;

-- hired from 1987-07-01 87-08-31
use hr;
select * from employees;
select * from employees where hire_date between '1987-07-01' and '1987-08-31';

select * from employees where salary > 10000 and DEPARTMENT_ID not in (80,90,100) order by salary desc;

# ----------------------------------------------------
select minimum_reorder_quantity 
from products 
where minimum_reorder_quantity=null;	

# when we campare anything or any datatype with null output is always null
select 5=null;
select 'ab'=null;
select true=null;
select null=null;
select '' and null;
select concat('hi',null);






