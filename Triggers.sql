# ========================================= Triggers ===========================================
# (Preserve,validate data in before)

CREATE TABLE salary_history (
    emp_id INT,
    first_name VARCHAR(50),
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    department_id INT
);


CREATE TABLE employee (
  employee_id INT,
  name VARCHAR(50),
  salary FLOAT,
  department_id INT
);


INSERT INTO employee (employee_id, name, salary, department_id)
VALUES
  (1, 'John Smith', 50000.0, 101),
  (2, 'Jane Doe', 60000.0, 102),
  (3, 'Bob Johnson', 55000.0, 101),
  (4, 'Mary Brown', 65000.0, 103),
  (5, 'Tom Davis', 70000.0, 102);

-- before insert 
-- ----------------------------------------------------------------------------------------
# ex1
delimiter $$ 
create trigger before_insert_emp
before insert on employee
for each row
begin
	if new.salary is null then 
    set new.salary=15000.0;    
    end if;
end;;
$$ delimiter ;

INSERT INTO employee (employee_id, name,  department_id)
VALUES(101, 'Pitya', 404);
select * from employee;

# ex2
delimiter $$ 
create trigger before_insert_emp_ex2
before insert on employee
for each row
begin
	if new.department_id is null then 
    set new.department_id=100;
    end if;
end;;
$$ delimiter ;

INSERT INTO employee (employee_id, name,  salary)
VALUES(77, 'ABC', 10000);
select * from employee;

# ex3
INSERT INTO employee (employee_id, name)
VALUES(8, 'XYZ');
select * from employee;

# ex4
alter table employee add column email varchar(20);
delimiter $$ 
create trigger before_insert_emp_ex3
before insert on employee
for each row
begin
	if new.email not like '%@%' then 
		signal sqlstate '45000'				# It is used to raise a custom error inside a stored procedure, function, or trigger.
			set message_text='Invalid email type';	#Error Code: 1644. Invalid email type

    end if;
end;;
$$ delimiter ;

INSERT INTO employee (employee_id, name,  email)
VALUES(8, 'PQR', 'pqr');
select * from employee;

-- after insert
-- ------------------------------------------------------------------------
-- create a trigger to log message after employee insertion
create table employee_log(
	log_id int auto_increment primary key,
    log_message varchar(250),
    log_timestamp timestamp default current_timestamp
);

delimiter $$ 
create trigger after_employee_insert
after insert on employee
for each row
begin
	insert into employee_log(log_message) values(concat('A new employee has been inserted with ID : ',new.employee_id));
end;;
$$ delimiter ;    

insert into employee(employee_id,name,salary) values (1230,'Sanket',50000.0);
select * from employee;
select * from employee_log;    

-- ----------------------------------------------------------
# ex2
create table employee_emails(
	emp_id int auto_increment primary key,
    email varchar(20),
    email_timestamp timestamp default current_timestamp
);

delimiter $$
create trigger email_generate
after insert on employee
for each row
begin
	insert into employee_emails(emp_id,email)
    values(new.employee_id,concat(lower(replace(new.name,' ','.')),'@company.com'));
end$$ 
delimiter ;

insert into employee(employee_id,name,salary,department_id) values (777,'Roshan',10000.0,111);
select * from employee;
select * from employee_emails;

-- before delete
-- -------------------------------------------------------
create table deleted_employees(
	employee_id int,
    name varchar(50),
    salary int,
    deparment_id int,
    deleted_by varchar(100)
);

delimiter $$
create trigger delete_employee
before delete on employee
for each row
begin
	insert into deleted_employees(employee_id,name,salary,deparment_id,deleted_by)
    values(old.employee_id,old.name,old.salary,old.department_id,user());
end$$
delimiter ;

select * from employee;
select * from deleted_employees;
delete from employee where employee_id=8;

-- ---------------------------------------------------------
delimiter $$
create trigger before_employee_delete
before delete on employees
for each row
begin
	if datediff(now(),old.hire_date) > 3650 then 
		signal sqlstate '45000'
			set message_text='Cannot Delete Employee : Has been working for more than 10 years';
	end if;
end;;
$$ delimiter ;

delete from employees where HIRE_DATE='1987-06-20';	# Error Code: 1644. Cannot Delete Employee : Has been working for more than 10 years

-- after delete
-- ---------------------------------------------------------------------------------
-- create admin notification table
create table admin_notifications(
	notification_id int auto_increment primary key,
    message varchar(255),
    notification_type varchar(50),
    created_at timestamp default current_timestamp
);

delimiter $$
create trigger trg_notify_after_delete
after delete on employee
for each row
begin
	insert into admin_notifications(message,notification_type)
    values(concat('Employee ',old.name,' (ID : ',old.employee_id,') has been removed from the system '),'Employee_deleted');
end;;
$$ delimiter ;

delete from employee where employee_id=1230;
select * from employee;
select * from admin_notifications;

-- before update
-- --------------------------------------------------------
delimiter $$ 
create trigger before_update_trg
before update on employee
for each row
begin
	if new.salary<old.salary then 
		signal sqlstate '45000' 
			set message_text='Error : salary cannot be decreased!';
	end if;
    
    if new.salary>(old.salary*1.20) then 
		signal sqlstate '45000'
			set message_text = 'Error : salary increased cannot exceed 20%';
	end if;
    
end;;
$$ delimiter ;

update employee set salary=5000 where employee_id=6;	# Error Code: 1644. Error : salary cannot be decreased!
update employee set salary=50000 where employee_id=6;	# Error Code: 1644. Error : salary increased cannot exceed 20%
select * from employee;

-- after update
-- --------------------------------------------------------
create table salary_history (
	emp_id int,
    full_name varchar(50),
    old_salary decimal(10,2),
    new_salary decimal(10,2),
    department_id int
);

delimiter $$ 
create trigger after_update_trg
after update on employee
for each row
begin
	if old.salary <> new.salary then 
    insert into salary_history (emp_id,full_name,old_salary,new_salary,department_id)
    values (old.employee_id,old.full_name,old.salary,new.salary,old.department_id);
    end if;
end$$ 
delimiter ;

update employee set salary=5000 where employee_id=8;


DROP TRIGGER IF EXISTS before_insert_emp;
DROP TRIGGER IF EXISTS before_insert_emp_ex2;
DROP TRIGGER IF EXISTS before_insert_emp_ex3;
DROP TRIGGER IF EXISTS after_employee_insert;
DROP TRIGGER IF EXISTS email_generate;
DROP TRIGGER IF EXISTS before_update_trg;
DROP TRIGGER IF EXISTS delete_employee;
DROP TRIGGER IF EXISTS trg_notify_after_delete;
DROP TRIGGER IF EXISTS before_employee_delete;





