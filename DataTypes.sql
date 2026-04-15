create database feb26;		# database creation

use feb26;		# use database

create table student(		# table creation
	s_id int,				# column creation --> col_name datatype
    s_name char(10)
);

insert into student value(		# inserting value inside table
	1,'Sujal'					# follow same order as mentioned in column_name
); 

insert into student value(
	2,'Sujal Chandrakant Godse'		# Error --> as we have given size of 10 for name.
);

insert into student value(
	3,56786						# it will now give error. Compiler will convert int to char automatically
);

insert into student value(
	4,'1234'					# its char as it is written inside quotes
);

select * from student;			# display all data of table

create table stud_char1(
	s_id int,
    s_name char(300)		 # Error Code: 1074. Column length too big for column 's_name' (max = 255); use BLOB or TEXT instead	0.000 sec
);

#-----------------------------------------------------------------------------------------------------
# inbulit function -- 1) char_length  2) length()
select char_length(s_name) from student;		# count the characters

select length(s_name) from student;				# count the bytes

# ------------------ varchar ---------------------

create table stud_varchar1(
	s_id int,
    s_name varchar(300)		
);
insert into stud_varchar1 value (12,'ABCDEFGHIJKLMNOP');
select * from stud_varchar1;

create table stud_varchar2(
	s_id int,
    s_name varchar(10)		# the max size range of varchar is 65535
);
insert into stud_varchar2 value (22,'afifffhjfjhbkjfbjbefje');		#Error Code: 1406. Data too long for column 's_name' at row 1	0.016 sec
insert into stud_varchar2 value (32,12345678);
insert into stud_varchar2 value (32,'98765');
insert into stud_varchar2 value (22,'Student');
select * from stud_varchar2;

create table stud_varchar3(
	s_id int,
    f_name varchar(35) default 'for varchar',
	l_name varchar(20) default 'for char'
);
insert into stud_varchar3 (s_id,f_name) values (11,'abc');
select * from stud_varchar3;

create table stud_varchar3(
	s_id int,
    f_name varchar(35) default 'for varchar',
	l_name varchar(20) default 'for char',
    descp text default 'a'					# text datatype cant have default value
);		# Error Code: 1101. BLOB, TEXT, GEOMETRY or JSON column 'descp' can't have a default value	0.016 sec
select char_length(f_name),char_length(l_name) from stud_varchar3;

# ------------------------- text -------------------------------

create table stud_text1(
	s_id int,
    f_name varchar(35) default 'for varchar',
	l_name varchar(20) default 'for char',
    about text					
);
insert into stud_text1(s_id,about) values (101,'Albert Einstein[a] (14 March 1879 – 18 April 1955) was a German-born theoretical physicist best known for developing the theory of relativity. Einstein also made important contributions to quantum theory.[1][5] His mass–energy equivalence formula E = mc2, which arises from special relativity, has been called "the worlds most famous equation".[6] He received the 1921 Nobel Prize in Physics for "his services to theoretical physics, and especially for his discovery of the law of the photoelectric effect Born as a subject to the Kingdom of Württemberg, part of the German Empire,[note 1] Einstein moved to Switzerland in 1895, forsaking his citizenship the following year. In 1897, at the age of seventeen, he enrolled in the mathematics and physics teaching diploma program at the Swiss federal polytechnic school in Zurich, graduating in 1900. He acquired Swiss citizenship a year later, which he kept for the rest of his life, and afterwards secured a permanent position at the Swiss Patent Office in Bern. In 1905, he submitted a successful PhD dissertation to the University of Zurich. In 1914, he moved to Berlin to join the Prussian Academy of Sciences and the Humboldt University of Berlin, becoming director of the Kaiser Wilhelm Institute for Physics in 1917; he also became a Prussian and consequently also German citizen again. In 1933, while Einstein was visiting the United States, Adolf Hitler came to power in Germany. Horrified by the Nazi persecution of his fellow Jews,[8] he decided to remain in the US, and was granted American citizenship in 1940.[9] On the eve of World War II, he endorsed a letter to President Franklin D. Roosevelt alerting him to the potential German nuclear weapons program and recommending that the US begin similar research, later carried out as the Manhattan Project.');
select about from stud_text1;

#----------------------------- TINYTEXT ----------------------------------

CREATE TABLE products (
  product_id   INT AUTO_INCREMENT PRIMARY KEY,
  name         VARCHAR(150) NOT NULL,
  tagline      TINYTEXT,       -- short catchy line, max 255 bytes
  category     VARCHAR(50)
);

INSERT INTO products (name, tagline, category)
VALUES
  ('Laptop Pro', 'Fastest laptop for developers', 'Electronics'),
  ('Water Bottle', 'Stay hydrated all day', 'Sports');

SELECT name, tagline FROM products;

# -------------------- TEXTmax 64 KB ----------------------------

CREATE TABLE blog_comments (
  comment_id  INT AUTO_INCREMENT PRIMARY KEY,
  post_id     INT NOT NULL,
  user_id     INT NOT NULL,
  content     TEXT NOT NULL,      -- the comment body
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO blog_comments (post_id, user_id, content)
VALUES
  (1, 101, 'Great article! Really helped me understand MySQL TEXT types. The examples were very clear and easy to follow.'),
  (1, 102, 'I had the same issue with VARCHAR limits last week. This explanation saves a lot of time!');

SELECT user_id,
       LEFT(content, 50) AS preview,   -- show first 50 chars
       LENGTH(content)    AS char_count
FROM   blog_comments;

# --------------------------- MEDIUMTEXT   max 16 MB ---------------------------------
CREATE TABLE articles (
  article_id   INT AUTO_INCREMENT PRIMARY KEY,
  title        VARCHAR(200) NOT NULL,
  body         MEDIUMTEXT NOT NULL,  -- full article content
  html_version MEDIUMTEXT,            -- rendered HTML version
  published_at DATETIME
);

INSERT INTO articles (title, body, published_at)
VALUES (
  'Introduction to MySQL',
  'MySQL is an open-source relational database management system... [thousands of words]',
  '2024-06-01 10:00:00'
);

-- Search inside TEXT using LIKE
SELECT title,body
FROM   articles
WHERE  body LIKE '%relational database%';



# ---------------------------------------------- blob ---------------------------------------------------
create table stud_blob(
	s_id int,
    about text,
    photo blob
);
insert into stud_blob(s_id, about, photo) values (102,'I am Sujal Godse. Studying in CDAC, Mumbai.','C:/Users/sujal/OneDrive/Gambar/chatgpt image feb 12, 2026, 11_37_41 pm.png');
select * from stud_blob;

#----------------------------------------------------------------------------------------------------

SHOW VARIABLES LIKE 'secure_file_priv';

create table stud_blob2(
	s_id int,
    about text,
    photo longblob
);

INSERT INTO stud_blob2 VALUES(11,'I am Sujal Godse. Studying in CDAC, Mumbai.',load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/1.png'));
select * from stud_blob2;

# -------------------------------------------- set ----------------------------------------------------

create table stud_set1(
	s_id int,
    f_name varchar(35) default 'for varchar',
	l_name varchar(20) default 'for char',
    about text,
    photo longblob,
    assignment longblob,
    elc set('ML','SPM','CC','IOT','IR','CG','AI','DS')
);
desc stud_set1;
insert into stud_set1(s_id,elc) values (101,'ML');
insert into stud_set1(s_id,elc) values (102,'ML,DS');
insert into stud_set1(s_id,elc) values (102,'ML,IOT,CG,AI,DS');
insert into stud_set1(s_id,elc) values (103,'ML,CG,AI,IOT');
select * from stud_set1;
#------------------------------------------------------------------------------
create table candidate_set(
	c_id int,
    c_name varchar(35),
	educ char(20),
    exp int,
    skills set('Python','Java','SQL','R','Linux','AWS')
);
insert into candidate_set values (101,'Sujal','BE CS',1,'Python,SQL');
select * from candidate_set;
#---------------------------------------------------------------------------------------

create table candidate_set2(
	c_id int,
    c_name varchar(35),
	educ char(20),
    exp int,
    skills set('Python','Java','SQL','R','Linux','AWS'),
    job_roles set('ML Engineer','Data Analyst','Business Analyst','Data Science','Cloud Engineer')
);
insert into candidate_set2 values (101,'Sujal','BE CS',1,'Python,SQL','Data Analyst,Business Analyst,Data Science,Cloud Engineer');
select * from candidate_set2;


# ----------------------------------------- enum -----------------------------------------------

create table candidate_enum(
	c_id int,
    c_name varchar(35),
	educ char(20),
    exp int,
    skills set('Python','Java','SQL','R','Linux','AWS'),
    job_roles set('ML Engineer','Data Analyst','Business Analyst','Data Science','Cloud Engineer'),
    gender enum('M','F','O','NP')
);
insert into candidate_enum(c_id,gender) values(10,'F');
insert into candidate_enum(c_id,gender) values(11,'M,F');	# Data truncated for column 'gender' at row1
select * from candidate_enum;

create table candidate_enum1(
	c_id int,
    c_name varchar(35),
	educ char(20),
    exp int,
    skills set('Python','Java','SQL','R','Linux','AWS'),
    job_roles set('ML Engineer','Data Analyst','Business Analyst','Data Science','Cloud Engineer'),
    gender enum('M','F','O','NP'),
    payment_method enum('UPI','NET B','Cash','CC','DC','Bitcoin','Wallet')
);
insert into candidate_enum1(c_id,gender) values(10,'F');
insert into candidate_enum1(c_id,gender,payment_method) values(11,'M','UPI');	
select * from candidate_enum1;

# ----------------------------------------- Day 2 ------------------------------------------------

create table employee_num(
	emp_id int,
    emp_name varchar(10),
    salary float,
    bonus decimal
);
insert into employee_num value (1,'Sujal',60000,10000.0);
select * from employee_num;
select length(salary),length(bonus) from employee_num;
insert into employee_num value (-10,'ABC',-60000,10000.0);

create table employee_num1(
	emp_id int,
    emp_name varchar(10),
    salary float(5,2),
    bonus decimal(4,1)
);
insert into employee_num1 value (-10,'ABC',-60000,10000.0);	#Error Code: 1264. Out of range value for column 'salary' at row 1
insert into employee_num1 value (-10,'ABC',60000,1000.0);	#Error Code: 1264. Out of range value for column 'salary' at row 1
insert into employee_num1 value (-10,'ABC',600,100.0);
select * from employee_num1;

select salary,salary/0 from employee_num1;		# it will not give an error, it will store null


# -------------------------------------------- date and time --------------------------------------------
create table emp_date(
	emp_id int,
    emp_name varchar(30),
    dob date,
    doj datetime,
    login_time timestamp,
    logout_time timestamp,
    exp_years year
);
insert into emp_date value (101,'Sujal','2003-08-04','2026-02-25 08:02:00',now(),now(),2026);
select * from emp_date;

select now();			# current date and time
select curdate();		# current date
select curtime();		# crrent time
select utc_time();		# universal time
select utc_date();		# universal date
select utc_timestamp();	# universal date and time

select year(dob),month(dob),day(dob), yearweek(dob),monthname(dob), dayname(dob),dayofweek(dob)  from emp_date;

select hour(doj),minute(doj),second(doj) from emp_date; 

#--------------------------------------------------- datediff ------------------------------------------------
select datediff(curdate(),dob)/365 as age from emp_date;

select timestampdiff(day,dob,now()) from emp_date;
select timestampdiff(week,dob,now()) from emp_date;
select timestampdiff(year,dob,now()) from emp_date;

# ------------------------------------------------------------------------------------------------------------------
# virtuual
create table to_check_virtual(
	fname varchar(30),
    lname varchar(30),
    fullname varchar(100) generated always as (concat(fname,' ',lname)) virtual
);
insert into to_check_virtual(fname,lname) values ('Sujal','Godse');
select * from to_check_virtual;

create table to_check_virtual1(
	fname varchar(30),
    lname varchar(30),
    dob date,
    doj date,
    fullname varchar(100) generated always as (concat(fname,' ',lname)) virtual,
    age int generated always as (datediff(doj,dob)) virtual
);
insert into to_check_virtual1(fname,lname,dob,doj) values ('Sujal','Godse','2003-08-04','2026-04-04');
select * from to_check_virtual1;

#----------------------------------------------------------------------------------------------------------------
create table to_check_virtual2(
	fname varchar(30),
    lname varchar(30),
    dob date,
    doj date,
    fullname varchar(100) generated always as (concat(fname,' ',lname)) virtual,
    age int generated always as (datediff(doj,dob)/365) virtual,
    salary int,
    bonus int,
    increment decimal(4,2),
    new_salary int generated always as (salary+((salary+bonus)*increment)) virtual
);
insert into to_check_virtual2(fname,lname,dob,doj,salary,bonus,increment) value('Sujal','Godse','2003-08-04','2026-02-04',65000,2000,0.15);
select * from to_check_virtual2;

#-----------------------------------------------------------------------------------------------------------
#
create table to_check_virtual3(
	fname varchar(30),
    lname varchar(30),
    dob date,
    doj date,
    fullname varchar(100) generated always as (concat(fname,' ',lname)) virtual,		# The column is not physically stored in the tableIts value is calculated dynamically whenever you query it
    age int generated always as (datediff(doj,dob)/365) virtual,
    salary int,
    bonus int,
    increment decimal(4,2),
    new_salary int generated always as (salary+((salary+bonus)*increment)) virtual,
    skill_set json
);
insert into to_check_virtual3(fname,lname,skill_set) values('Sujal','Godse','{"skill":["python  asdfghj","java"],"certificates":["AWS","Python"],"edu":"CDAC"}');
select * from to_check_virtual3;

select fullname, skill_set ->> '$.skill[1]', skill_set ->> '$.edu' as education from to_check_virtual3;

# -------------------------------------------------------------------------------------------------------------------------
create table practice_json(
	fname varchar(30),
    lname varchar(30),
    marks_set json
);
insert into practice_json values('Sujal','Godse','{"stud1":[80,90,77],"stud2":[67,68,54]}');
select * from practice_json;
select fname,lname,marks_set ->> '$.stud1[0]' as stud1_marks, marks_set ->> '$.stud2[0]' as stud2_marks from practice_json;


# --------------------------------------------------------- Constraints -----------------------------------------------------------------
create table cons_ex(
	s_id int primary key,
    s_name varchar(30) not null
);
insert into cons_ex values(121,'Sujal');
insert into cons_ex values(2);			# Error Code: 1136. Column count doesn't match value count at row 1

# default
create table cons_ex1(
	s_id int auto_increment primary key,
    s_name varchar(30) not null,
    cname varchar(50) default "PG Certificate"
);
insert into cons_ex1(s_name) values('Sujal');
select * from cons_ex1;

create table cons_ex2(
	s_id int auto_increment primary key,
    s_name varchar(30) not null,
    cname varchar(50) default "PG Certificate",
    course_start date default '2026-02-25',
    login_time timestamp default current_timestamp
);
insert into cons_ex2(s_name) values('Sujal');
select * from cons_ex2;


create table cons_ex3(
	s_id int auto_increment primary key,
    s_name varchar(30) not null,
    cname varchar(50) default "PG Certificate",
    course_start date default '2026-02-25',
    login_time timestamp default current_timestamp,
    mark int default 0
);
insert into cons_ex3(s_name) values('Sujal'),('XYZ');
select * from cons_ex3;

# unique
create table check_ex1(
	s_id int auto_increment primary key,
    s_name varchar(30) not null,
    cname varchar(50) default "PG Certificate",
    course_start date default '2026-02-25',
    login_time timestamp default current_timestamp,
    mark int default 0,
    m_num int unique
);
insert into check_ex1(s_name,m_num) values ('Sujal',1234);
insert into check_ex1(s_name,m_num) values ('asdfghj',1234);	#Error Code: 1062. Duplicate entry '1234' for key 'check_ex1.m_num'

create table check_ex2(
	s_id int auto_increment primary key,
    s_name varchar(30) not null,
    cname varchar(50) default "PG Certificate",
    course_start date default '2026-02-25',
    login_time timestamp default current_timestamp,
    mark int default 0,
    m_num int,
    email varchar(100),
    unique(m_num,email)
);
insert into check_ex2(s_name,m_num,email) values('Sujal',12345,'sujal@gmail.com');
insert into check_ex2(s_name,m_num,email) values('Sujal',123,'sujal@gmail.com');
insert into check_ex2(s_name,m_num,email) values('XYZ',12345,'sujal@gmail.com');	#Error Code: 1062. Duplicate entry '12345-sujal@gmail.com' for key 'check_ex2.m_num'
insert into check_ex2(s_name,m_num,email) values('Sujal',123,'sujal5117@gmail.com');
select * from check_ex2;

# use unique() when we want either value like or . use unique keyword to get unique values
create table check_ex3(
	s_id int auto_increment primary key,
    s_name varchar(30) not null,
    cname varchar(50) default "PG Certificate",
    course_start date default '2026-02-25',
    login_time timestamp default current_timestamp,
    mark int default 0,
    m_num int unique not null,
    email varchar(100) unique not null
);
insert into check_ex3(s_name,m_num,email) values('Sujal',123,'sujal5117@gmail.com');
insert into check_ex3(s_name,m_num,email) values('Sujal',12,'suj@gmail.com');
desc check_ex3;

show indexes from check_ex2;

# check
create table check_ex4(
	s_id int auto_increment primary key,
    s_name varchar(30) not null,
    age int not null check(age>21)
);
insert into check_ex4 values(10,'Sujal',22);
insert into check_ex4 values(20,'XYZ',18);		# Error Code: 3819. Check constraint 'check_ex4_chk_1' is violated.

create table check_ex5(
	s_id int auto_increment primary key,
    s_name varchar(30) not null,
    age int not null check(age>21),
    gender char(10) check(gender in ('m','f','o'))
);
insert into check_ex5(s_name,age,gender) values('Sujal',23,'m');
insert into check_ex5(s_name,age,gender) values('Sujal',23,'aa');	#Error Code: 3819. Check constraint 'check_ex5_chk_2' is violated.
select * from check_ex5;

create table check_ex6(
	s_id int auto_increment primary key,
    s_name varchar(30) not null,
    age int not null,
    gender char(10) check(gender in ('m','f','o')),
    check(char_length(s_name)>2 and age>21)
);
insert into check_ex6(s_name,age,gender) values('S',23,'m');


create table check_ex7(
	s_id int auto_increment primary key,
    s_name varchar(30) not null,
    age int not null,
    m_num int,
    gender char(10) check(gender in ('m','f','o')),
    check(char_length(s_name)>1 and age>21),
    check(m_num regexp '[0-9]')
);
insert into check_ex7(s_name,age,m_num,gender) values('Sujal',23,23876543,'m');
insert into check_ex7(s_name,age,m_num,gender) values('Sujal',23,'2387dfg','m');	#Error Code: 1265. Data truncated for column 'm_num' at row 1

# ----------------------------------------------------- Composite KEY ----------------------------------------------------------------
create table prim(
	zip_code int,
    s_name varchar(30) not null,
    address varchar(100),
    primary key(zip_code,address)		# Composite key
);
desc prim;
show index from prim;
insert into prim values(422401,'Sujal','Nashik');
insert into prim values(422401,'Sanket','Pune');
insert into prim values(411402,'Sujal','Nashik');
insert into prim values(422401,'Sujal',null);
select * from prim;

#------------------------------------------------------- Foriegn Key -----------------------------------------------------------------
create table dept(
	dept_id int auto_increment primary key,
    dept_name varchar(10),
    emp_id int,
    project_id varchar(10)
);

create table emp(
	emp_id int auto_increment primary key,
    emp_name varchar(20),
    project_id varchar(10),
    dept_id int,
    foreign key (dept_id) references dept(dept_id)
);

desc dept;
desc emp;		# MUL stands for foreign key

show indexes from dept;
show indexes from emp;

# -----------------------------------------------------------------
create table department(
	dept_id int auto_increment primary key,
    dept_name varchar(10),
    dept_HOD varchar(10)
);

create table stud(
	stud_id int auto_increment primary key,
    stud_name varchar(10),
    dept_id int,
    foreign key (dept_id) references department(dept_id)
);
insert into department(dept_name,dept_HOD) values ('Computer','XYZ'),('EnTC','ABC'),('Mechanical','PQR');

insert into stud(stud_name,dept_id) values('sujal',1),('Aditya',2),('Om',1),('Sudev',3);
select * from stud;
select * from department;

insert into stud(stud_name,dept_id) values('sanket',4);		# Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`feb26`.`stud`, CONSTRAINT `stud_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`))

delete from stud where dept_id=2; 	#
delete from department where dept_id=1;		# Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`feb26`.`stud`, CONSTRAINT `stud_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`)) 
# we are enable to delete row because child table row is refering to parent table row

# on delete cascade --> # When a row in the parent table is deleted. All related rows in the child table are automatically deleted
create table department2(
	dept_id int auto_increment primary key,
    dept_name varchar(10),
    dept_HOD varchar(10)
);

create table stud2(
	stud_id int auto_increment primary key,
    stud_name varchar(10),
    dept_id int,
    foreign key (dept_id) references department(dept_id)
    on delete cascade	
);
insert into department2(dept_name,dept_HOD) values ('Computer','XYZ'),('EnTC','ABC'),('Mechanical','PQR');
insert into stud2(stud_name,dept_id) values('sujal',1),('Aditya',2),('Om',1),('Sudev',3);
select * from department2;
select * from stud2;
delete from department2 where dept_id=2;	# now able to delete row from parent table and all related rows in child table are automatically deleted.

# on update cascade --> When the parent table’s key is updated. The child table automatically updates its corresponding foreign key values
create table department3(
	dept_id int auto_increment primary key,
    dept_name varchar(10),
    dept_HOD varchar(10)
);

create table stud4(
	stud_id int auto_increment primary key,
    stud_name varchar(10),
    dept_id int,
    foreign key (dept_id) references department3(dept_id)
    on update cascade
);
insert into department3(dept_name,dept_HOD) values ('Computer','XYZ'),('EnTC','ABC'),('Mechanical','PQR');
insert into stud4(stud_name,dept_id) values('sujal',1),('Aditya',2),('Om',1),('Sudev',3);
select * from department3;
select * from stud4;
update stud4 set dept_id =3  where dept_id = 200;

-- --------------------------------------------------------------------------------------------------------------------------------------
-- drop table dept_using_cu_fk_ex;
create table dept_using_cud_fk_ex(
	dept_id int auto_increment primary key,
    dept_name varchar(50),
    emp_id int,
    project_id varchar(20)
);

create table emp_using_cud_fk_ex(
	emp_id int auto_increment primary key,
    emp_name varchar(30),
    p_id varchar(30),
    department_id int,
    foreign key (department_id) references dept_using_cud_fk_ex(dept_id) 
    on update cascade
    on delete cascade
);

insert into dept_using_cud_fk_ex(dept_name,emp_id ,project_id) value('IT',103,'P_01'),
('Admin',104,'P_02'),('HR',105,'P_011');

insert into emp_using_cud_fk_ex(emp_name,p_id ,department_id)
values
('A','P_02',3),
('B','P_02',1),
('AA','P_03',1),
('BB','P_03',3);

select * from dept_using_cud_fk_ex;
select * from emp_using_cud_fk_ex;

delete from dept_using_cud_fk_ex where dept_id =3;
update dept_using_cud_fk_ex set dept_id =100 where dept_id=1;
insert into dept_using_cud_fk_ex(dept_name,emp_id ,project_id) 
value('AI',106,'P_016');
insert into emp_using_cud_fk_ex(emp_name,p_id ,department_id)
values ('AO','P_02',101);

update emp_using_cud_fk_ex set department_id =4 where department_id=101;

#Error Code: 1452. Cannot add or update a child row: 
#a foreign key constraint fails 
#(`feb26`.`emp_using_cud_fk_ex`, CONSTRAINT `emp_using_cud_fk_ex_ibfk_1` 
#FOREIGN KEY (`department_id`) REFERENCES `dept_using_cud_fk_ex` (`dept_id`) 
#ON DELETE CASCADE ON UPDATE CASCADE)
-- reason you are trying to assign a value (4) to the column department_id in the child table. However, this value does not exist in the parent table (dept_using_cud_fk_ex).

delete from emp_using_cud_fk_ex where department_id=101;

update emp_using_cud_fk_ex set department_id=2 where department_id=100;
-- This will work because department id =2 is present is parent table 
update emp_using_cud_fk_ex set department_id =2 where department_id=100;

use feb26;

# on delete set null --> When a row in the parent table is deleted, the corresponding foreign key in the child table is set to NULL.
create table dept_2(
	dept_id int auto_increment primary key,
    dept_name varchar(50),
    emp_id int,
    project_id varchar(20)
);

create table emp_2(
	emp_id int auto_increment primary key,
    emp_name varchar(30),
    p_id varchar(30),
    department_id int,
    foreign key (department_id) references dept_2(dept_id) 
    on delete set null
);

insert into dept_2(dept_name,emp_id ,project_id) value('IT',103,'P_01'),('Admin',104,'P_02'),('HR',105,'P_011');
insert into emp_2(emp_name,p_id ,department_id) values ('A','P_02',3),('B','P_02',1),('AA','P_03',1),('BB','P_03',3);
select * from dept_2;
select * from emp_2;
delete from dept_2 where dept_id=3;

# on delete restrict --> Prevents deletion of a parent row if it is being used in the child table.
create table dept_3(
	dept_id int auto_increment primary key,
    dept_name varchar(50),
    emp_id int,
    project_id varchar(20)
);
create table emp_3(
	emp_id int auto_increment primary key,
    emp_name varchar(30),
    p_id varchar(30),
    department_id int,
    foreign key (department_id) references dept_3(dept_id) 
    on delete restrict
);
insert into dept_3(dept_name,emp_id ,project_id) value('IT',103,'P_01'),('Admin',104,'P_02'),('HR',105,'P_011');
insert into emp_3(emp_name,p_id ,department_id) values ('A','P_02',3),('B','P_02',1),('AA','P_03',1),('BB','P_03',3);
select * from dept_3;
select * from emp_3;
delete from dept_3 where dept_id=3;		# Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`feb26`.`emp_3`, CONSTRAINT `emp_3_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `dept_3` (`dept_id`) ON DELETE RESTRICT)

# on update set null --> When the primary key in the parent table is updated, the corresponding foreign key in the child table is set to NULL.
# on update restrict --> Prevents updating the parent key if it is being referenced in the child table.
















