#==================================== Windows Function ======================================
# Aggregate Function
select employee_id,first_name,DEPARTMENT_ID,salary, sum(salary) over (partition by DEPARTMENT_ID) as result
from employees;

select employee_id,first_name,DEPARTMENT_ID,salary, avg(salary) over (partition by DEPARTMENT_ID) as result
from employees;

select employee_id,first_name,DEPARTMENT_ID,salary, min(salary) over (partition by DEPARTMENT_ID) as result
from employees;

select employee_id,first_name,DEPARTMENT_ID,salary, max(salary) over (partition by DEPARTMENT_ID) as result
from employees;

select employee_id,first_name,DEPARTMENT_ID,salary, count(*) over (partition by DEPARTMENT_ID) as result
from employees;

# ex2
select employee_id,first_name,DEPARTMENT_ID,salary, min(salary) over (order by salary) as result
from employees;

# ex3
select employee_id,first_name,DEPARTMENT_ID,salary, count(*) over (partition by DEPARTMENT_ID order by salary) as result
from employees;

# ---------------------------------------
select employee_id,first_name,DEPARTMENT_ID,salary, row_number() over (order by salary) as result
from employees;

select employee_id,first_name,DEPARTMENT_ID,salary, row_number() over (partition by DEPARTMENT_ID) as result
from employees;

select employee_id,first_name,DEPARTMENT_ID,salary, row_number() over (partition by DEPARTMENT_ID order by salary) as result
from employees;

select employee_id,first_name,DEPARTMENT_ID,salary, row_number() over (partition by DEPARTMENT_ID order by salary desc) as result
from employees;

-- top 2 highest paid employees
with highest as (
	select employee_id,first_name,DEPARTMENT_ID,salary, row_number() over (partition by DEPARTMENT_ID order by salary 	desc) as as_salary
	from employees
)
select * 
from highest
where as_salary <=2;

-- you need to find newly or latest joined employee in each department
with highest as (
	select employee_id,first_name,DEPARTMENT_ID,salary,HIRE_DATE, row_number() over (partition by DEPARTMENT_ID order by HIRE_DATE desc) as joining_year
	from employees
)
select * 
from highest
where joining_year =1;

-- remove employee + department - duplicates () read
with highest as (
	select employee_id,first_name,DEPARTMENT_ID, row_number() over (partition by first_name,DEPARTMENT_ID) as result
	from employees
)
select *
from highest
where result>=2;


# ------------------------ movie_db database
# ex1
select row_number() over (order by r.averageRating desc) as row_num, t.primaryTitle as title, r.averageRating as rating
from imdb_titles t
inner join imdb_ratings r
on t.tconst=r.tconst
where t.titleType='movie' and r.numVotes>=100000
limit 10;

# ex2
with top as (
	select row_number() over (partition by t.genres order by r.averageRating desc) as row_num, t.primaryTitle as title, r.averageRating as rating
	from imdb_titles t
	inner join imdb_ratings r
	on t.tconst=r.tconst
	where t.titleType='movie' and r.averageRating>=8.8
	limit 10
)
select * 
from top 
where row_num=1;	

# rank() & dense_rank()
use hr;
select employee_id,first_name,DEPARTMENT_ID,salary, 
row_number() over (partition by DEPARTMENT_ID order by salary 	desc) as as_row_number,
rank() over (partition by DEPARTMENT_ID order by salary 	desc) as as_rank,
dense_rank() over (partition by DEPARTMENT_ID order by salary 	desc) as as_dense_rank
from employees;

-- rank employeees based on their salaries high to low
select employee_id,first_name,DEPARTMENT_ID, salary,rank() over (order by salary desc) as as_rank
from employees
limit 5;

-- top 3 unique salaries
select employee_id,first_name,DEPARTMENT_ID,salary,dense_rank() over (order by salary desc) as as_rank
from employees
limit 3;

WITH t AS (
    SELECT 
        employee_id,
        first_name,
        salary,
        ROW_NUMBER() OVER(
            PARTITION BY salary 
            ORDER BY employee_id
        ) AS rn
    FROM employees
)
SELECT employee_id, first_name, salary
FROM t
WHERE rn = 1
ORDER BY salary DESC
LIMIT 3;


-- in imdb table rank movies inside genre
use movie_db;


-- first_value & last_value
use hr;
select employee_id,first_name,DEPARTMENT_ID,salary,
first_value(salary) over (partition by department_id) as as_first_value
from employees; 

select employee_id,first_name,DEPARTMENT_ID,salary,
last_value(salary) over (partition by department_id) as as_last_value
from employees;


-- lag() & lead()
select employee_id,first_name, department_id, salary,
lag(salary) over(order by salary) as_last_value
from employees;

select employee_id,first_name, department_id, salary,
lead(salary) over(order by salary) as_next_value
from employees;

with lag_ex as(
	select employee_id,first_name, department_id, salary,
lag(salary) over(order by salary) as_last_emp_sal
from employees
) select *,(salary-as_last_emp_sal) from 
lag_ex where salary>as_last_emp_sal order by salary;
