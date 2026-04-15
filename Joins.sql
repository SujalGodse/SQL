# ================= NORMALIZATION ==============
-- TO HANDLE DIFFERENT ANOMALIES THAT OCCUR DUE TO INSERT,UPDATE AND DELETE OF DATA WE USE NORMALIZATION.
-- Anomalies in DBMS are referred to as inconsistencies or errors that occur while manipulating any query in a Database. These anomalies can lead incorrect and inconsistencies of data 
-- TYPES OF ANOMALY --> 1.Insert Anomaly 2. Update Anomaly 3.Delete Anomaly

# Normalization  --> 
# 1NF --> 	A relationship is said to be 1st normal form if it has only single value attribute
-- 			1. It should always have atomic value in an attribute or in a column 
-- 			2. Value stored in a column should be of the same domain. 
-- 			3. All the columns in the table should have a unique name. 
-- 			4. The order in which data is stored does not matter. 

-- 2NF --> A relation is said to be in 2nd normal form if it is in 1st normal form. 
-- Every non prime attribute should be fully dependent on a prime attribute. 
-- Functional dependency - It is a concept in data normalization that indicates the relationship between attributes

-- 3NF --> A relation is said to be in third normal form when it is in  - second normal form 
-- When we remove the transitive dependency  
-- Transitive dependency in a database is an indirect relationship between values in 
-- the same table. In other word dependency that exits between two attribute to the 
-- third attribute

# ================================ JOINS ===================================

CREATE TABLE Department_jn (
    dept_id INT PRIMARY KEY,
    manager_id INT,
    department_name VARCHAR(50)
);

CREATE TABLE Employee_jn (
    emp_id INT PRIMARY KEY,
    e_name VARCHAR(50),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department_jn(dept_id)
);


INSERT INTO Department_jn (dept_id, manager_id, department_name) 
VALUES
    (1, 101, 'Engineering'),
    (2, 102, 'Sales'),
    (3, 103, 'Marketing'),
    (4, 104, 'Other'),
	(5, null, null);

INSERT INTO Employee_jn (emp_id, e_name, salary, department_id) 
VALUES
    (201, 'John Doe', 60000.00, 1),
    (202, 'Jane Smith', 55000.00, 1),
    (203, 'Michael Johnson', 62000.00, 2),
    (204, 'Emily Davis', 58000.00, 2),
    (205, 'Chris Brown', 63000.00, 3),
    (206, 'Amanda Wilson', 60000.00, 3),
	(207, 'Wilson', 50000.00, null);

# ====================== INNER JOIN =============================

select e.emp_id,e.e_name,e.department_id,d.department_name
from employee_jn e inner join department_jn d
on e.department_id = d.dept_id;
select * from employee_jn;
select * from department_jn;

-- --------------------------------------------------------
select c.first_name, c.city,o.shipped_date,o.order_date
from orders o inner join customers c
on c.id = o.customer_id;

-- --------------------------------------------------------
select e.first_name, concat_ws("-",e.city,e.country_region) address,o.shipped_date,o.order_date
from orders o inner join employees e
on o.employee_id = e.id
order by e.first_name;

-- ---------------------------------------------------------
select * from departments;
select * from locations;
select * from country_new;
select * from regions;

select d.DEPARTMENT_ID,d.DEPARTMENT_NAME,l.LOCATION_ID,l.POSTAL_CODE,c.COUNTRY_ID,c.COUNTRY_NAME,r.REGION_ID,r.REGION_NAME
from departments d 
inner join locations l on d.location_id = l.location_id 
inner join country_new c on l.country_id = c.country_id
inner join regions r on c.region_id = r.region_id;

-- ---------------------------------------------------------------
select e.employee_id,e.first_name,d.DEPARTMENT_ID,d.DEPARTMENT_NAME,l.LOCATION_ID,l.POSTAL_CODE,c.COUNTRY_ID,c.COUNTRY_NAME,r.REGION_ID,r.REGION_NAME
from employees e 
inner join departments d on e.department_id = d.department_id
inner join locations l on d.location_id = l.location_id 
inner join country_new c on l.country_id = c.country_id
inner join regions r on c.region_id = r.region_id;

#======================= LEFT OUTER JOIN =================================
select e.emp_id,e.e_name,e.department_id,d.department_name
from employee_jn e left outer join department_jn d
on e.department_id = d.dept_id;
select * from employee_jn;
select * from department_jn;

#======================= RIGHT OUTER JOIN =================================
select e.emp_id,e.e_name,e.department_id,d.department_name
from employee_jn e right outer join department_jn d
on e.department_id = d.dept_id;
select * from employee_jn;
select * from department_jn;
