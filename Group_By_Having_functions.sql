-- 
-- Function (Pre-defined)
-- Aggregate --> sum,max,min,avg,count,groupconcat
-- String --> concat,substr,left/right,etc
-- Window --> rank,lag,lead,rownum,dense_rank
-- maths --> abs,ceil,floor,sqrt
-- contro --> case,if
-- 

-- Aggregate Function
-- count() --> no. of records
select count(*) from products;
select count(id) from employees;
select count(distinct customer_id) from orders;		# distinct --> removes duplicate 

select * from orders;
-- no. of emp assigned customers
select count(distinct employee_id) from orders where customer_id is not null;

-- count no. of customers from new york city
select count(distinct customer_id) from orders where ship_city='New York';

-- sum() --> returns sum of column (works on int)
select sum(shipping_fee) from orders;
select sum(salary) from employees;
select sum(minimum_reorder_quantity) from products;

select * from order_details;
-- find total reve 
select sum(quantity*unit_price) as total_revenue from order_details;

-- avg() --> avg of column
select avg(salary) from employees;
select avg(unit_price) as avg_unit_price from order_details;
select avg(quantity) as avg_order_quantity from order_details;

-- min() and max()
select min(unit_price) as min_unit_price from order_details;
select max(unit_price) as max_unit_price from order_details;

-- -------------------------------------------------------------------------
-- group by clause
# rule 1 --> attribute present in group by clause only those mention in select clause
select count(department_id) as no_of_emp_dept , DEPARTMENT_ID
from employees
group by DEPARTMENT_ID;

# rule 2 --> aggregate function should be used with group by clause
select count(department_id) as no_of_emp_dept , DEPARTMENT_ID
from employees;		#Error Code: 1140. In aggregated query without GROUP BY, expression #2 of SELECT list contains nonaggregated column 'hr.employees.DEPARTMENT_ID'; this is incompatible with sql_mode=only_full_group_by

-- ex1
select salary,count(*) as no_of_emp
from employees
group by salary;

-- ex2
select salary,count(*) as no_of_emp
from employees
where salary=35000
group by salary;

-- ex3
select * from products;
select count(*) no_of_prod_category, category
from products 
where category='Beverages'
group by category
order by no_of_prod_category desc;

-- total no. of order placed by each cusstomer
select count(*) orders_placed_by_cust,customer_id
from orders
group by customer_id
order by orders_placed_by_cust;

-- find the total revenue for each product
select sum(quantity*unit_price) as gross, product_id
from order_details
group by product_id;

-- find no. of emp who has been hired before 1988 for each dept
select count(*) as no_of_emp ,DEPARTMENT_ID
from employees
where year(hire_date) < '1988'
group by DEPARTMENT_ID
order by no_of_emp;

-- max sal in each dept
select max(salary) as max_sal ,DEPARTMENT_ID
from employees
group by DEPARTMENT_ID
order by max_sal desc;

-- min sal in each dept
select min(salary) as min_sal ,DEPARTMENT_ID
from employees
group by DEPARTMENT_ID
order by min_sal ;

-- find min & max sal for each job id where dept_id is 80
select max(salary) as max_sal,min(salary) as min_sal ,DEPARTMENT_ID
from employees
where DEPARTMENT_ID=80;

-- find no. of distinct job role in each dept
select count(distinct job_id) as 'distinct job role'
from employees
group by DEPARTMENT_ID;

-- ex
select manager_id,count(*) as no_of 
from employees
group by MANAGER_ID
having no_of>=5
order by no_of desc;

-- no. of customers who have placed more than 5 orders
select customer_id,count(*) as no_of
from orders
group by customer_id
having no_of >= 5
order by no_of desc;

-- find the shipper who had shipped more than 100 orders in year 1997
select count(*),shipper_id
from orders
where year(shipped_date) = '2006'
group by shipper_id
having count(*)>=10;

-- find the dept whose total sal exceeds 50000
select department_id,sum(salary) as total_sal
from hr.employees
group by department_id
having total_sal>50000;

-- find dept whoes avg sal is between 500 to 10000
select department_id,avg(salary) as avg_sal
from hr.employees
group by department_id
having avg_sal between 5000 and 10000;

-- find dept where diff between min and max sal is greater then 5000
select department_id,min(salary) as min_sal,max(salary) as max_sal
from hr.employees
group by department_id
having max(salary)-min(salary)>5000;


select 
case 
	when salary < 5000 then 'low sal'
    when salary < 10000 then 'mid range sal'
    when salary < 50000 then 'high range sal'  
     else 'high'
end as salary_band, count(*) no_of, min(salary) as min_sal, max(salary) as max_sal
from hr.employees
group by 
case 
	when salary < 5000 then 'low sal'
    when salary < 10000 then 'mid range sal'
    when salary < 50000 then 'high range sal'
    else 'high'
end
order by salary_band desc;

# =====================================================================
# string function
select upper(First_name) from employees;
select lower(First_name) from employees;
select First_name, length(first_name) from employees;
select First_name, concat(first_name,' ',last_name) from employees;
select First_name, concat_ws(' - ',first_name,last_name) from employees;
select First_name, concat_ws(' | ',first_name,last_name,salary,department_id) from employees;
select First_name, concat_ws(first_name,' ',last_name,'   ',department_id) from employees;

# substring
select first_name, substring(first_name,1,3) from employees;		# substring(column_name,start,no_of_char)
select first_name, substring(first_name,3,4) from employees;
select first_name, left(first_name,3) from employees;
select first_name, right(first_name,3) from employees;

# replace
select first_name, replace(first_name,'a','@') from employees;

# instr
select first_name, instr(first_name,'a') from employees;

# reverse
select first_name, reverse(first_name) from employees;

# repeat
select first_name, repeat('*',floor(salary/5000)) as star from employees;
