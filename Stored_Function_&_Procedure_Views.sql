# ================================== Stored Function ==========================================

delimiter $$
create function to_get_emp_details(emp_id int)
returns varchar(100)
deterministic									
begin
	declare f_name varchar(100);
    select concat(first_name," ",last_name) into f_name
    from employees
    where employee_id=emp_id;
    return f_name;
end;;
$$ delimiter ;
select to_get_emp_details(101);

-- annual income of employee
delimiter $$
create function get_annual_inc(emp_id int)
returns decimal(10,2)
deterministic
begin
	declare ann_inc decimal(10,2);
    select salary*12 into ann_inc
    from employees
    where employee_id=emp_id;
    return ann_inc;
end;;
$$ delimiter ;
select get_annual_inc(101);

-- find no_emp by dept_id
delimiter $$
create function to_get_no_emp(dept_id int)
returns int
deterministic
begin 
	declare no_of int;
    select count(*) into no_of
    from employees
    where department_id=dept_id
    group by department_id;
    return no_of;
end;;
$$ delimiter ;
select to_get_no_emp(80);
select to_get_no_emp(90);
select to_get_no_emp(100);

-- pass emp_id and increment in the salary
delimiter $$ 
create function to_get_inc_sal(emp_id int,increment decimal(8,2))
returns decimal(10,2)
deterministic
begin
	declare incr_sal decimal(10,2);
    select salary+(salary*increment) into incr_sal
    from employees 
    where employee_id=emp_id;
    return incr_sal;
end;;
$$ delimiter ;
select to_get_inc_sal(101,0.20);

drop function to_get_inc_sal;  

select employee_id,first_name,salary,to_get_inc_sal(101,0.20) as incremented_salary
from employees
where employee_id=101;

-- --------------------------------------------------------
-- pass the empl-id and increment in the salary , fetch salary 
delimiter $$
create function to_get_emp_id_expr(join_date date)
returns varchar(100)
deterministic
begin
    declare yr_ex int;
    set yr_ex = timestampdiff(year, join_date, curdate());
    if yr_ex >= 10 then
        return concat(yr_ex, ' senior emp');
    elseif yr_ex >= 5 then
        return concat(yr_ex, ' mid level exp');
    else
        return concat(yr_ex, ' new join');
    end if;
end$$
delimiter ;
select to_get_emp_id_expr('1987-09-9');

select department_id, group_concat(to_get_emp_id_expr(hire_date) separator ' - ') as hire_band
from employees
group by department_id;

-- Error Code: 1418. 
-- This function has none of DETERMINISTIC, 
-- NO SQL, or READS SQL DATA in 
-- its declaration and binary logging is 
-- enabled (you *might* want to use the less 
-- safe log_bin_trust_function_creators variable)
drop function to_get_emp_id_expr;

select hire_date into hire_dt from employees;


-- get department current budget
delimiter $$ 
create function get_dept_budget(dept_id int)
returns decimal(10,2)
deterministic
begin
	declare budget decimal(10,2);
    select sum(salary) into budget
    from employees
    where department_id=dept_id;
    return budget;
end;;
$$ delimiter ;
select get_dept_budget(80);
select get_dept_budget(90);
select get_dept_budget(100);
select department_id,get_dept_budget(department_id) 
from employees;
select distinct department_id,get_dept_budget(department_id) 
from employees
where department_id in (80,90,100);

# get department names and employee name
delimiter $$ 
create function get_dept_emp_name(emp_name varchar(50), dept_name varchar(50))
returns varchar(100)
deterministic
begin
	declare result varchar(100);
    select concat(e.first_name," - ",d.department_name) into result
    from employees e 
    inner join departments d
    on e.department_id=d.department_id
    where e.first_name=emp_name and d.department_name=dept_name;
    return result;
end;;
$$ delimiter ;

drop function get_dept_emp_name;

select get_dept_emp_name('Neena','Executive');

select * from employees;
select * from departments;


#======================================== Stored Procedure =======================================
delimiter $$ 
create procedure read_all()
deterministic
begin 
	select * from employees;
end$$
delimiter ;
call read_all();

-- ---------------------------------------------
delimiter $$ 
create procedure get_dept_emp_name()
deterministic
begin
    select e.first_name,d.department_name
    from employees e 
    inner join departments d
    on e.department_id=d.department_id;
end$$ delimiter ;
call get_dept_emp_name();

-- ------------------------------------------
delimiter $$ 
create procedure get_data(in emp_id int)
begin
	select *
    from employees
    where employee_id=emp_id;
end$$ delimiter ;
call get_data(101);

-- ----------------------------------
delimiter $$ 
create procedure get_dept_data(in dept_id int)
begin
	select *
    from employees
    where department_id=dept_id;
end$$ delimiter ;
call get_dept_data(80);
call get_dept_data(90);

-- -------------------------------------------------
select * from employee_jn;
delimiter $$
create procedure insert_into(in id int,in name varchar(20),in sal decimal(10,2),in dept int)
begin
	insert into employee_jn values(id,name,sal,dept);
end$$ delimiter ;
call insert_into(208,'Sujal',100000,1);

delimiter $$
create procedure update_into(in emp int)
begin
	update employee_jn set salary=200000 where emp_id=emp;
end$$ delimiter ;
call update_into(208);

delimiter $$
create procedure delete_into(in emp int)
begin
	delete from employee_jn where emp_id=emp;
end$$ delimiter ;
call delete_into(208);

# -----------------------------------------------------
delimiter $$
create procedure emp_details(in emp_id int, out full_name varchar(20), out sal decimal(10,2), out dept_name varchar(20))
begin
	select concat(e.first_name,' ',e.last_name),e.salary,d.department_name into full_name,sal,dept_name
    from employees e
    inner join departments d
    on e.department_id=d.department_id
    where e.employee_id=emp_id;
end$$ delimiter ;
call emp_details(101,@full_name,@sal,@dept_name);
select @full_name full_name,@sal salary,@dept_name dept_name;


delimiter $$
create procedure dept_details(in dept_id int, out s_name varchar(20), out dept_name varchar(20))
begin
	select l.state,d.department_name into s_name,dept_name
    from locations l
    inner join departments d
    on l.location_id=d.location_id
    where d.department_id=dept_id;
end$$ delimiter ;
call dept_details(20,@s_name,@dept_name);
select @s_name state_name,@dept_name dept_name;


delimiter $$
create procedure emp_inout(inout emp_id int, out dept_id int, out full_name varchar(20))
begin
	select concat(first_name,' ',last_name),department_id into full_name,dept_id
    from employees
    where employee_id=emp_id;
end$$ delimiter ;
set @emp_id = 101;
call emp_inout(@emp_id,@dept_id,@full_name);
select @emp_id employee_id,@dept_id department_id,@full_name full_name;

# ==================================== Views ==============================================
create view first_view as 
select first_name,last_name,salary,department_id
from employees;
select * from first_view;

# distinct doesn't apply in view
create view second_view as 
select distinct department_id,first_name,last_name,salary
from employees;
select * from second_view;

# if we do any update or modification in view table then original table is also affected and vica versa
create view emp as 
select emp_id,e_name,salary,department_id
from employee_jn;

select * from emp;
select * from employee_jn;
update employee_jn set salary=65000 where emp_id=205;
update emp set salary=64000 where emp_id=203;



