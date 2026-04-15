#========================================= Ranking Functions =============================================

-- 1. Find the top 3 highest paid employees in each department using RANK().
with top3 as (
	select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT_ID, 
    rank() over (partition by DEPARTMENT_ID order by SALARY desc) as rn
    from employees
)
select *	
from top3
where rn<=3;

-- 2. Assign a unique row number to each employee within their department using ROW_NUMBER() based on salary descending.
with uniq_row as (
	select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT_ID
    from employees
)
select *,row_number() over (partition by DEPARTMENT_ID order by SALARY desc) as rn	
from uniq_row;

-- 3. List departments where at least two employees share the same salary rank using DENSE_RANK().
with share_sal as (
	select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT_ID, 
    dense_rank() over (partition by DEPARTMENT_ID order by SALARY desc) as rn
    from employees
)
select distinct department_id
from share_sal
group by department_id,rn
having count(*) >= 2;


-- 4. Divide employees into 4 equal salary groups using NTILE(4) and display the group number along with employee details.
with grp as ( 
	select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT_ID
	from employees
)
select *,ntile(4) over (order by SALARY desc) as grp
from grp;

-- 5. Find the top 3 highest paid employees in each department using RANK().
with highest as (
	select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT_ID, 
	rank() over (partition by department_id order by SALARY desc) as rnk
	from employees
)
select *
from highest
where rnk<=3;

-- 6. Assign a unique row number to each employee within their department using ROW_NUMBER() based on salary descending.
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT_ID, 
row_number() over (partition by DEPARTMENT_ID order by SALARY desc) as rn
from employees;

-- 7. List departments where at least two employees share the same salary rank using DENSE_RANK().
with share_sal as (
	select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT_ID, 
    dense_rank() over (partition by DEPARTMENT_ID order by SALARY desc) as rn
    from employees
)
select distinct department_id
from share_sal
group by department_id,rn
having count(*) >= 2;

-- 8. Divide employees into 4 equal salary groups using NTILE(4) and display the group number along with employee details.
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT_ID, 
ntile(4) over (order by SALARY desc) as grp
from employees;

# =================================== Aggregate Window Functions ========================================

-- 1. For each employee, show their salary and the average salary of their department using AVG() as a window function.
select employee_id, first_name, last_name, department_id, salary,
avg(salary) over (partition by department_id) as average_salary
from employees;

-- 2. Show the running total of salaries for each department ordered by hire date using SUM() window function.
select employee_id, first_name, last_name, department_id, salary,hire_date,
sum(salary) over (partition by department_id order by hire_date) as total_salary
from employees;

-- 3. Find the maximum salary in each department and compare it with each employee’s salary.
select employee_id, first_name, last_name, department_id, salary,hire_date,
max(salary) over (partition by department_id) as max_salary
from employees;

-- 4. For each employee, show their salary and the average salary of their department using AVG() as a window function.
with avg_sal as (
	select employee_id, first_name, last_name, department_id, salary
	from employees
)
select *,avg(salary) over (partition by department_id) as average_salary
from avg_sal;

-- 5. Show the running total of salaries for each department ordered by hire date using SUM() window function.
with running_total as (
	select employee_id, first_name, last_name, department_id, salary,hire_date
	from employees
)
select *,sum(salary) over (partition by department_id order by hire_date) as total_salary from running_total;

-- Find the maximum salary in each department and compare it with each employee’s salary.
with max_sal as (
	select employee_id, first_name, last_name, department_id, salary,hire_date
	from employees
)
select *,max(salary) over (partition by department_id) as max_salary from max_sal;


# ===================================== Value Functions ==============================================

-- 1. For each employee, show their salary and the salary of the employee hired just before them using LAG().
select employee_id, first_name, last_name, department_id, salary,hire_date,
lag(salary) over (order by hire_date desc) as before_salary
from employees;

-- 2. Display each employee’s salary and the salary of the next hired employee in the same department using LEAD().
select employee_id, first_name, last_name, department_id, salary,hire_date,
lead(salary) over (order by hire_date) as after_salary
from employees;

-- 3. List each department and show the first and last hired employee using FIRST_VALUE() and LAST_VALUE() functions.
select employee_id, first_name, last_name, department_id, salary,hire_date,
first_value(first_name) over (partition by department_id order by hire_date) as first_hiredate,
last_value(first_name) over (partition by department_id order by hire_date) as last_hiredate
from employees;

-- 4. For each employee, show their salary and the salary of the employee hired just before them using LAG().
with lag_ex as (
	select employee_id, first_name, last_name, department_id, salary,hire_date
	from employees
)
select *,lag(salary) over (order by hire_date desc) as before_salary
from lag_ex;

-- 5. Display each employee’s salary and the salary of the next hired employee in the same department using LEAD().
with lead_ex as (
	select employee_id, first_name, last_name, department_id, salary,hire_date
	from employees
)
select *,lead(salary) over (order by hire_date) as after_salary
from lead_ex;

-- 6. List each department and show the first and last hired employee using FIRST_VALUE() and LAST_VALUE() functions.
with first_last_ex as(
	select employee_id, first_name, last_name, department_id, salary,hire_date
	from employees
)
select *, first_value(first_name) over (partition by department_id order by hire_date) as first_hiredate,
		last_value(first_name) over (partition by department_id order by hire_date) as last_hiredate
from first_last_ex;
