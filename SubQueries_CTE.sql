use hr;
select * from locations;
-- write a query to display country_id and number of emp working in each 
-- country that has more than 5 employees

-- empl -- dept_id -- department table -- location_id - 
-- location -- have country id and name 

select country_id, count(*) no_of from employees e 
inner join departments d 
on e.department_id=d.department_id
inner join locations l 
on d.location_id=l.location_id
group by l.country_id
having no_of>5
order by no_of; 

-- from --join -- group by --having-- select -- order by 

-- wrtq to find dept with more than 5 empp and avg sala >5000.

select d.department_id,d.department_name, count(*) no_of 
from employees e 
inner join departments d 
on e.department_id=d.department_id
group by d.department_id
having no_of>5 and avg(e.salary)>5000
order by no_of; 

select d.department_id, count(*) no_of 
from employees e 
inner join employees d 
on e.department_id=d.department_id
group by d.department_id
having no_of>5 and avg(e.salary)>5000
order by no_of;

select department_id from employees where department_id=90;

-- no_of emp and avg salary/dept where department are IT, Finance , sales;
select d.department_id,d.department_name, count(*) no_of ,avg(salary)
from employees e 
inner join departments d 
on e.department_id=d.department_id
where department_name in('IT','Finance','Sales')
group by d.department_id
order by no_of; 

-- from -- where - join -- group -- count-- select -- order by 

-- find all the non executive mang who lead teams of 3 or more emp earning above 4,000
-- where the avg salary exceed 5000 

select e1.manager_id,d.department_id,d.department_name,
concat(e.first_name,' ',e.last_name), count(*) no_of ,avg(e.salary)
from employees e 
inner join employees e1 
on e.employee_id=e1.manager_id
inner join departments d 
on e1.department_id=d.department_id
where d.department_name != 'Executive' and e.salary>4000
group by e1.manager_id,d.department_id
having no_of>=3 and avg(e.salary)>5000
order by no_of; 

select * from departments;
select * from employees;
select e1.manager_id,
concat(e.first_name,' ',e.last_name)
from employees e 
inner join employees e1 
on e.employee_id=e1.manager_id
inner join departments d 
on e1.department_id=d.department_id
where d.department_name != 'Executive' and e.salary>4000;

select e.first_name,r.region_name
from employees e
join regions r;

create table join_un(A int, B int);
insert into join_un values(1,0),(1,1),(0,1),(0,0);

create table join_un1(X int, Y int);
insert into join_un1 values(1,0),(1,1),(0,1),(0,0),(1,1),(1,null);

select * from join_un;
select * from join_un1;

select u.A,u1.X
from join_un u
inner join join_un1 u1
on u.a=u1.x;

-----------------------------------------------------------

create table join_un(A int, B int);
insert into join_un values(1,0),(1,1),(0,1),(0,0);

create table join_un1(X int, Y int);
insert into join_un1 values(1,0),(1,1),(0,1),(0,0),(1,1),(1,null);

select * from join_un;
select * from join_un1;

select u.A,u1.X
from join_un u
inner join join_un1 u1
on u.a=u1.x;

-----------------------------------------------------------

-- as hr -- city level breakdown - job roles -- America region
-- each city in amreica  should have  distinct job roles
-- total nof or emp and avg sal 
-- for city having more than 2 emp and avg sal 5000 + 
-- exculde emp salary less than 3000 

select l.city, r.region_name, count(e.employee_id) no_of,
count(distinct e.job_id),avg(salary) avg_sal
from employees e inner join departments d 
on e.department_id =d.department_id
inner join locations l
on d.location_id= l.location_id
inner join countries c
on c.COUNTRY_ID=l.COUNTRY_ID
inner join regions r
on r.REGION_ID=c.REGION_ID
where r.region_name='Americas\r' and e.SALARY > 3000
group by l.city,r.REGION_NAME
having no_of >2 and avg_sal > 5000
order by no_of;

select * from regions;

-----------------------------------------------------------

-- from 

select department_name from  
(select department_name from departments 
where department_id=100) as dept_table ;

# Error Code: 1248. Every derived table must have its own alias
select department_name from departments 
where department_id=100;

select count(*) from employees
where DEPARTMENT_ID=90;

select first_name ,(select department_name from departments
where DEPARTMENT_ID=90) as no_of_emp_dept
from employees;

-- find employee with same job id as employee id 100
select job_id, salary from employees where employee_id =106;

select job_id, salary from employees where salary =4800;

select concat(first_name,' ',last_name), job_id,department_id 
from employees where (JOB_ID,salary)=
(select job_id,salary from employees where employee_id =106);


select * from employees order by salary;


-- find the employee working in dept located in New york

-- select employee_id, first_name,department_id-- outer 
select * from departments;
select * from locations;

select location_id from locations where STATE_PROVINCE ='Texas';

select department_id from departments where location_id =1400;

select employee_id, first_name,department_id from employees where department_id =60;

select employee_id, first_name,department_id from employees 
where department_id =
(select department_id from departments 
where location_id=
(select location_id from locations where STATE_PROVINCE ='Texas'));

select employee_id, first_name,department_id from employees 
where department_id =
(select d.DEPARTMENT_ID from departments d
inner join  locations l
on d.location_id=l.LOCATION_ID
where STATE_PROVINCE='Texas');

-- find employee working in departmnet located at seatle


select e.employee_id, e.first_name,department_id from employees e
where department_id in
(select d.DEPARTMENT_ID from departments d
inner join  locations l
on d.location_id=l.LOCATION_ID
where city='Seattle');

#Error Code: 1242. Subquery returns more than 1 row

select d.DEPARTMENT_ID from departments d
inner join  locations l
on d.location_id=l.LOCATION_ID
where city='Seattle';


-- find employees who have past job records 
show tables;
select * from job_history;

select employee_id , first_name, department_id
from employees where employee_id in(
select e.employee_id from job_history j
join employees e
on e.employee_id=j.employee_id
);

select employee_id, first_name from employees
where salary = any(select salary from employees);

select employee_id, first_name from employees
where salary > any(select salary from employees);

select employee_id, first_name from employees
where salary < any(select salary from employees);

select employee_id, first_name,salary from employees
where salary = any(select max(salary) from employees);

select employee_id, first_name, salary from employees
where salary > any(select max(salary) from employees);

select employee_id, first_name, salary from employees
where salary < any(select max(salary) from employees);

-----------------------------------------------------------

create database movie_db;
use movie_db;
show tables;

-----------------------------------------------------------

-- find regions where all countries have at least one location 
use hr;
select r.region_id , r.region_name
from regions r
where 0< 
all(select count(l.location_id) from countries c
left join locations l on c.country_id =l.country_id
);

select count(l.location_id) from countries c
left join locations l on c.country_id =l.country_id;

-- employee eraning more thsn all employees in finance dept 

select department_id from departments where department_name ='Finance';


select first_name, salary,department_id from employees where salary
>all(select salary from employees where department_id
=(select department_id from departments where department_name ='Finance'
));


select department_id, department_name from departments d
where exists 
(select 1 from employees e where e.department_id=d.department_id);

select department_id ,avg(salary) avg_sal
from employees
group by department_id 
having avg(salary) > (select avg(salary) from employees );  
 
 
select department_id ,avg(salary) avg_sal
from employees
group by department_id; 

select avg(salary) from employees;
 

-----------------------------------------------------------

select first_name, salary,department_id from employees where salary
>all(select salary from employees where department_id
=(select department_id from departments where department_name ='Finance'
));


with to_check_dept as(
select department_id from departments 
where department_name ='Finance'
)
select first_name,salary 
from employees e ,to_check_dept t
where e.department_id=t.department_id;

with to_check_manager as(
select department_id,location_id,manager_id from departments 
)
select distinct e.MANAGER_ID ,first_name,salary
from employees e ,to_check_manager t
where e.manager_id=t.manager_id;

-----------------------------------------------------------

with emp_grt_total_avg_sal as
(
	select avg(salary) avg_sal from employees
)
select first_name, salary,department_id
from employees , emp_grt_total_avg_sal s where salary > s.avg_sal;

-- dept >5 emp

with more_5_emp as 
(
	select count(employee_id) no_of, DEPARTMENT_ID from employees 
    group by department_id
) select distinct m.department_id, m.no_of
from departments, more_5_emp m 
where m.no_of >5;

-- find the higest salary in each deapt 

with abc as (
select max(salary) mx,department_id from employees 
group by department_id)
select  e.department_id,first_name, salary
from employees e join abc a
on e.department_id=a.department_id
and e.salary=a.mx;

with sal_band as (
	select first_name, salary,
    case 
		when salary <10000 then 'Low Salary'
        when salary >=10000 and salary < 15000 then 'mid range Salary'
        when salary >=15000 and salary < 30000 then 'high range Salary'
	else 'other'
	end as salary_band
    from employees
)
select count(*), salary_band
from sal_band
group by salary_band;


-- find the employees who are earning more than their manager 
-- cte - manager /salary 
-- emp salar>manager salary

with mang_sal as (
	select EMPLOYEE_ID mng_id,first_name, salary,manager_id from employees
)
select e.first_name, e.salary , concat(m.first_name) as manger_name,m.salary manger_salary
from employees e 
join mang_sal m
on m.mng_id=e.MANAGER_ID
where e.salary>m.salary;

-- find employee who earn more than vag sala 
-- and have been in the company more than the avh tenure 
with avg_sal as
(select first_name ,employee_id, avg(salary) as sal_avg from employees),

yrs_exp as (
	 select EMPLOYEE_ID, year(hire_date) h_date, hire_date,salary from employees 
)
select first_name, sal_avg , h_date from 
avg_sal  s join  yrs_exp y
on s.EMPLOYEE_ID=y.EMPLOYEE_ID
where y.salary >s. sal_avg and 
timestampdiff(year,y.hire_date,curdate()) >20;

-----------------------------------------------------------


select timestampdiff(year,hire_date,curdate()) as exp  from employees;



select avg(now()- hire_date) from employees;
-- floor((now()- hire_date)/timestampdiff(year,hire_date,curdate()))


-----------------------------------------------------------


use north;
# you need to find all prod where unit price < recorded level. Show product name , stock, how many units short they have
select * from products;
select * from order_details;

with prod as (
	select product_id,product_name,units_in_stock,units_on_order,unit_price,reorder_level,quantity
    from products 
), 
ord_d  as (
	select unit_price, product_id,quantity
    from order_details
)
select p.product_id,p.product_name,(o.quantity-p.reorder_level) shortage
from prod p inner join ord_d o
on p.product_id=o.product_id
where o.unit_price < p.reorder_level;


-- compute total revenue per month and then compute each month to previous month, flag the months when the revenue decline
with revenue as (
	select concat(monthname(o.order_date),"-",year(o.order_date)) month_yrs,round(sum((od.quantity*od.unit_price)),2) total_revenue 
    from order_details od 
	inner join orders o 
    on o.id=od.id
    group by month_yrs
) 
select month_yrs, total_revenue,
case 
	when total_revenue >=10000 then 'Target Reached'
    else 'Target not Reached'
end as target_status
from revenue
order by month_yrs;

#----------------------------------------------------------------

-- u need to find all products where unit_price < record level 
-- and u need to show product name ,stock,how many units short they have

use northwind;
show tables;

select * from order_details;
select * from products;

with ord as
(
select product_id,unit_price,id,quantity from order_details
),

pro as
(
select id,product_name,reorder_level from products
)

select p.product_name,p.reorder_level,o.unit_price,o.quantity, o.quantity-p.reorder_level as shortage
from ord o inner join pro p
on p.id=o.product_id
where p.reorder_level > o.unit_price
order by reorder_level,quantity;


# ----------------------------------------------------------------
with emp as (
	select employee_id,first_name,salary,department_id,job_id
    from employees
)
select (select count(*) as no_of_emp from emp) as no_emp,
		(select	avg(salary) as avg_sal from emp) as avg_sal,
        (select sum(salary) as total_sal from emp) as sum_sal;

# -------------------------------------------------------------------------------------

WITH RECURSIVE rec AS (
    -- Start date (min date from orders)
    SELECT MIN(DATE(order_date)) AS dt
    FROM orders

    UNION ALL

    -- Generate next dates
    SELECT dt + INTERVAL 1 DAY
    FROM rec
    WHERE dt < (SELECT MAX(DATE(order_date)) FROM orders)
),
order_day AS (
    SELECT DATE(o.order_date) AS od_da, COUNT(*) AS no_od_da
    FROM order_details od
    join orders o
    on o.id=od.id
    WHERE YEAR(order_date) = 2006
    GROUP BY DATE(order_date)
)

SELECT 
    r.dt,
    DAYNAME(r.dt) AS day_name,
    COALESCE(od.no_od_da, 0) AS total_orders
FROM rec r
LEFT JOIN order_day od 
    ON r.dt = od.od_da
ORDER BY total_orders desc;






















