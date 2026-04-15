use feb26;
# ------------------------------------------------ SECTION A: BEGINNER LEVEL ----------------------------------------------------
-- 1. Create a table students_basic with the following columns: 
-- ○ id (integer) 
-- ○ name (varchar 50) 
-- ○ age (integer) 
create table students_basic(
	id int,
	name varchar (50),
	age int
);

-- 2. Insert 5 records into students_basic. 
insert into students_basic(id,name,age) values
	(1,'Sujal Godse',22),
    (2,'Sanket Godse',21),
    (3,'Roshan Kale',24),
    (4,'Devdatta Thorat',15),
    (5,'Chaitanya Saraswat',60);

-- 3. Select all records from the table. 
select * from students_basic;

-- 4. Create a table products_basic with: 
-- ○ product_id (int) 
-- ○ product_name (varchar 100) 
-- ○ price (decimal 8,2) 
create table products_basic(
	product_id int,
    product_name varchar(100),
    price decimal(8,2)
);

-- 5. Insert 3 products and display them. 
insert into products_basic(product_id,product_name,price) 
values (101,'Laptop',50000), (102,'Mobile',20000), (103,'Telivision',30000);

select * from products_basic;

-- 6. Create a table employees_basic with: 
-- ○ emp_id (int) 
-- ○ emp_name (varchar 50) 
-- ○ joining_date (date)
create table employees_basic(
	emp_id int,
    emp_name varchar(50),
    joining_date date
);

-- 7. Insert at least 4 employees and display only names and joining dates. 
insert into employees_basic(emp_id,emp_name,joining_date) 
values (1101,'Sujal Godse','2026-02-25'), (1102,'Omprasad Narkhede','2026-01-11'), (1103,'Aditya Jadhav','2026-03-20'), (1104,'Sudev Gawande','2026-05-15');

select * from employees_basic;

-- 8. Create a table using CHAR and VARCHAR and insert values to observe differences. 
create table observe(
	name_1 char(10),
    name_2 varchar(10)
);
insert into observe(name_1,name_2) values ('ABC','XYZ');
desc observe;
select * from observe;

-- 9. Create table flags with a BOOLEAN column. Insert TRUE/FALSE values and display results.
create table flags(
	flag boolean
);
insert into flags(flag) value(true),(false);
select * from flags;

-- 10. Create a table numbers_test using TINYINT, SMALLINT, and BIGINT. Insert sample values.
create table numbers_test(
	num_1 tinyint,			# 0 - 255
    num_2 smallint,			# 0 - 65,535
    num_3 bigint			# 0 - 18,446,744,073,709,551,615
);
insert into numbers_test values (100,12000,123456789);
select * from numbers_test;


# ---------------------------------------------- SECTION B: INTERMEDIATE LEVEL -----------------------------------------------
-- 11. Create a table students with: 
-- ● id (int primary key) 
-- ● name (varchar 100 not null) 
-- ● marks (float) 
-- ● grade (char 2) 
create table students(
	id int primary key,
    name varchar(100) not null,
    marks float,
    grade char(2)
);

-- 12. Insert at least 6 records with varying marks.
insert into students 
values (101,'Sujal',87,'A'), (102,'Devdatta',80,'A'), (103,'Chaitanya',70,'B'), (104,'Omkar',74,'B'), (105,'Sohum',84,'A'), (106,'Rupendra',50,'C');

-- 13. Select students scoring more than 75 marks. 
select * from students where marks>75;

-- 14. Create a table orders with: 
-- ● order_id (int) 
-- ● order_date (datetime) 
-- ● amount (decimal 10,2) 
create table orders1(
	order_id int,
    order_date datetime,
    amount decimal(10,2)
);

-- 15. Insert records with different timestamps and query only date part.
insert into orders1 values(1,'2026-04-04 10:10:10',1200), (2,'2026-04-04 15:10:20',2500);
select * from orders1;

-- 16. Create a table users with ENUM for roles ("admin", "user", "guest"). Insert records.
create table users(
	u_id int,
    u_name varchar(10),
    roles enum("admin", "user", "guest")
);
insert into users values(1,'Sujal','admin'),(2,'ABC','guest');
select * from users;

-- 17. Try inserting a value outside ENUM and observe behavior. 
insert into users values(3,'XYZ','service');	# Error Code: 1265. Data truncated for column 'roles' at row 1

-- 18. Create a table binary_test using BLOB and TEXT. Insert sample data.
create table binary_tests (
    data_text text,
    data_blob longblob
);
insert into binary_test values('Hii, My name is Sujal. I\'m from Nashik.',load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/1.png'));

-- 19. Create a table salary_test using DECIMAL and FLOAT. Insert same values and compare.
create table salary_test(
	num_1 float,
    num_2 decimal(10,2)
);
insert into salary_test values(12345,12345);
select * from salary_test;

-- 20. Write a query to select records where amount is between 1000 and 5000. 
create table salary(
	emp_id int,
	sal decimal(10,2)
);
insert into salary values(1,2000),(1,4000),(1,900),(1,5000);
select * from salary where sal between 1000 and 5000;

#--------------------------------------------------- SECTION C: ADVANCED LEVEL --------------------------------------------------
-- 21. Create a table complex_types with: 
-- ● id (int) 
-- ● json_data (JSON) 
create table complex_types(
	id int,
    json_data json
);

-- 22. Insert structured JSON data and query specific keys. 
insert into complex_types values(1,'{"name":"Sujal","skill":"Python"}');
select json_data ->> '$.name' as name, json_data ->> '$.skill' as subject from complex_types;

-- 23. Create a table date_test with DATE, TIME, DATETIME, TIMESTAMP. Insert values and compare outputs. 
create table date_test(
	d date,
    t time,
    dt datetime,
    ts timestamp 
);
insert into date_test values('2026-02-25','10:10:10','2026-03-30 11:11:11',now());
select * from date_test;

-- 24. Create a table auto_test with AUTO_INCREMENT primary key. Insert records without specifying id. 
create table auto_test(
	id int auto_increment primary key,
    name varchar(10)
);
insert into auto_test(name) values ('Sujal'),('Sanket');
select * from auto_test;

-- 25. Create a table precision_test and test overflow in DECIMAL. 
create table precision_test(
	d decimal(5,2)
);
insert into precision_test values(999.99);
insert into precision_test values(9999.99);		# (overflow) Error Code: 1264. Out of range value for column 'd' at row 1

-- 26. Create a table string_test and test max length for VARCHAR.
create table string_test(
	str varchar(5)
); 
insert into string_test values('Sujal');
insert into string_test values('SujalG');		# Error Code: 1406. Data too long for column 'str' at row 1

-- 27. Create a table null_test with NOT NULL constraint. Try inserting NULL values.
create table null_test(
	id int not null
);
insert into null_test values(1);
insert into null_test values(null);		# Error Code: 1048. Column 'id' cannot be null

-- 28.Create a table default_test with DEFAULT values and test insert behavior.
create table default_test(
	name varchar(10),
	course varchar(10) default 'BDA'
);
insert into default_test(name) values('Sujal');
insert into default_test(name) values('Sanket');
select * from default_test;

-- 29. Create a table mixed_types combining INT, FLOAT, VARCHAR, DATE, and BOOLEAN. Insert and query based on multiple conditions.
create table mixed_types(
	prod_id int,
    prod_name varchar(10),
    prod_price float,
    prod_pur_date date,
    prod_ava boolean
);
insert into mixed_types values(101,'Laptop',500.00,'2026-04-06',true);
select * from mixed_types;

-- 30. Create a table where incorrect datatype insertion is attempted (e.g., string in INT). Observe and document behavior.
create table incorrect(
	id int,
    name varchar(10)
);
insert into incorrect values(1,'Sujal');
insert into incorrect values(2,2);
insert into incorrect values('ABC',3);		# Error Code: 1366. Incorrect integer value: 'ABC' for column 'id' at row 1
select * from incorrect;

