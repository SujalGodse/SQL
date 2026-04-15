use hr;

show tables;
-- 1. Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments.
select * from locations;
select * from countries;

select l.location_id, l.street_address, l.city, l.state_province, n.country_name
from locations l 
inner join countries n
on l.country_id = n.country_id;

-- 2. Write a query to find the name (first_name, last name), department ID and name of all the employees
select first_name, last_name , d.department_id
from employees e
inner join departments d 
on e.department_id = d.department_id;

-- 3. Write a query to find the name (first_name, last_name), job, department ID and name of the employees who works in London.
select first_name, last_name, job_id, d.department_id 
from employees e
inner join departments d 
on e.department_id = d.department_id
inner join locations l 
on d.location_id = l.location_id
where l.city = 'London';

-- 4. Write a query to find the employee id, name (last_name) along with their manager_id and name (last_name).
select * from employees;
select e.employee_id ,e.last_name , e.manager_id, e.last_name
from employees e join employees ep
on e.employee_id = ep.manager_id;

-- 5. Write a query to find the name (first_name, last_name) and hire date of the employees who was hired after 'Jones'.
select employee_id, first_name, last_name, hire_date 
from employees
where hire_date > (
    select hire_date
    from employees
    where last_name = 'Jones'
);


-- 6. Write a query to get the department name and number of employees in the department.
select d.department_name , count(*) as no_of_emp
from employees e
inner join departments d 
on e.department_id = d.department_id
group by d.department_name
order by no_of_emp desc;

-- 7. Write a query to find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90.
select e.employee_id , j.job_title ,timestampdiff(day,jh.start_date, jh.end_date) as day_diff
from employees e
inner join job_history as jh
on e.employee_id = jh.employee_id
inner join jobs j 
on j.job_id = jh.job_id
where jh.department_id = 90 ;

-- 8. Write a query to display the department ID and name and first name of manager.
select d.department_id, d.department_name, e.first_name as manager_name
from departments d
join employees e 
on d.manager_id = e.employee_id;

-- 9. Write a query to display the department name, manager name, and city.
select d.department_name, e.first_name as manager_name, l.city
from employees e
inner join departments d 
on e.department_id = d.department_id
inner join locations l 
on d.location_id = l.location_id ;


-- 10. Write a query to display the job title and average salary of employees.
select j.job_title, avg(e.salary) as avg_sal
from employees e
inner join jobs j 
on e.job_id = j.job_id
group by j.job_title;

-- 11. Write a query to display job title, employee name, and the difference between salary of the employee and minimum salary for the job.
select j.job_title, e.first_name, e.salary - j.min_salary as diff_sal
from employees e
inner join jobs j 
on e.job_id = j.job_id;

-- 12. Write a query to display the job history that were done by any employee who is currently drawing more than 10000 of salary.
select jh.START_DATE, jh.END_DATE, jh.JOB_ID, jh.DEPARTMENT_ID, jh.employee_id
from job_history jh 
inner join employees e 
on e.employee_id = jh.employee_id
where e.salary > 10000 ;

-- 13. Write a query to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years.
select e.first_name, e.last_name, e.hire_date, d.department_name, e.salary
from employees e
inner join departments d 
on e.manager_id = d.manager_id
where year(curdate()) - year(hire_date) > 15 ;
