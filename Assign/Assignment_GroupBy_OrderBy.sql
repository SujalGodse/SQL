-- 1. Write a SQL query to find the number of employees hired in each year.
select year(hire_date),count(*) no_of_emp
from employees
group by year(hire_date);

-- 2. Write a SQL query to find the number of employees in each department.
select department_id, count(*) no_of_emp
from employees
group by department_id;

-- 3. Write a SQL query to find the department with the highest total salary.
select department_id, sum(salary) total_salary
from employees
group by department_id
order by total_salary desc
limit 1;

-- 4. Write a query to list the number of jobs available in the employees table.
select job_id, count(*) no_of_jobs
from employees
group by job_id;

-- 5. Write a query to get the total salaries payable to employees.
select sum(salary) as total_salary
from employees;

-- 6. Write a query to get the minimum salary from the employees table.
select min(salary) as minimum_salary
from employees;

-- 7. Write a query to get the maximum salary of an employee working as a Programmer.
select max_salary
from jobs
where job_title='programmer';

-- 8. Write a query to get the average salary and number of employees working the department 90. 
select avg(salary),count(*) no_of_emp,department_id
from employees
where department_id=90
group by DEPARTMENT_ID;

-- 9. Write a query to get the highest, lowest, sum, and average salary of all employees. 
select max(salary) max_sal, min(salary) min_sal, sum(salary) sum_sal, avg(salary) avg_sal
from employees;

-- 10. Write a query to get the number of employees with the same job
select job_id,count(*) no_of_emp
from employees
group by job_id;

-- 11. Write a query to get the difference between the highest and lowest salaries. 
select max(salary)-min(salary) as difference
from employees;

-- 12. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager. 
select manager_id,min(salary) min_salary
from employees
group by manager_id;

-- 13. Write a query to get the department ID and the total salary payable in each department.
select department_id,sum(salary) total_salary
from employees
group by department_id;

-- 14. Write a query to get the average salary for each job ID excluding programmer. 
select job_id, avg(salary)
from employees
where job_id != 'IT_PROG'
group by job_id;

-- 15. Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only. 
select sum(salary) total_salary, max(salary) max_salary, min(salary) min_salary, avg(salary) avg_salary
from employees
where department_id=90;

-- 16. Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.
select job_id, max_salary
from jobs
where max_salary >= 4000;

-- 17. Write a query to get the average salary for all departments employing more than 10 employees. 
select avg(salary) avg_sal, department_id
from employees
group by department_id
having count(*)>10;
