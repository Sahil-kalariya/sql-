-- general queries

--1> creating actors table
create table actors(
    actor_id serial primary key,
    first_name varchar(150),
    last_name varchar(150) not null,
    gender char(1),
    date_of_birth date,
    add_date date,
    update_date date    
);

-- 2> creating directors table
create table directors(
    director_id serial primary key,
    first_name varchar(150),
    last_name varchar(150),
    date_of_birth date,
    nationality varchar(20),
    add_date date,
    update_date date
);


-- 3> creating movies table (movies)
create table movies(
    movie_id serial primary key,
    movie_name varchar(100) not null,
    movie_length int,
    movie_lang varchar(20),
    age_certificate varchar(10),
    release_date date,
    director_id int references directors (director_id)
);

-- 4> creating movie revenues (movies)
create table movies_revenues(
    revenue_id serial primary key,
    movie_id int references movies (movie_id),
    revenues_domestic numeric (10,2),
    revenues_international numeric (10,2)
); 

-- 5> creating movies_actors table (movies)
create table movies_actors(
    movie_id int references movies(movie_id),
    actor_id int references actors(actor_id)
);

-- 6> create a test table called customers (movies)
create table customers(
    customer_id serial primary key,
    first_name varchar(100),
    last_name varchar(100),
    email varchar(250),
    age int 
);

--7> insert into customers (movies)
insert into customers (first_name, last_name,email,age)
values ('sahil', 'kalariya','sk@123.com',12);


--8> insert multiple values in customers (movies)
insert into customers (first_name,last_name)
values ('s2','k2'),('s2','k2'),
('s2','k2'),
('s2','k2');

--9> view row which is inserted using RETURNING (movies)
insert into customers (first_name)
values ('s3') returning *;

--10> update vlaue of any row in customer (movies)
update customers set email = 'updated@g.com' where customer_id = 3

--11> update mulitple values of row in customer (movies) 
update customers set email = 'scndupdate@g.com' , age = 10 where customer_id = 5 

-- alter table customers add is_enable char(-2)
--12> update records in a customer table with where clause (movies) 
update customers set is_enable = 'Y' 

-- 13> update all records in customer table (movies)
update customers set is_enable = 'N' where customer_id = 2

--14> delete from table where columnname = 'value' (movies)
delete from customers where customer_id = 2;

--15> delete all data from cutomer (movies)
delete from customers;

--16> creatin table t_tags (movies)
create table t_tags(
    id serial primary key,
    tag text unique,
    update_date timestamp default now()
);

--17> insert into t_tage (movies)
insert into t_tags(tag) 
values('pen'),('pencil');

--18> conflict in t_tags  (movies)
insert into t_tags(tag) 
values('pen') 
on conflict(tag)
do 
    update set 
    tag = excluded.tag || '1',
    update_date = now();

select * from t_tags;

--19> give alias to column in actors table (movie)
-- as is optional , cant use single quotes
select first_name as "FirstName" from actors;

--20> combine column togehter and give them alias
-- use || to concate columns 
select first_name || last_name as "Full Name" from actors;
select first_name || ' ' || last_name as "Full Name" from actors;

-- asc by default is ascending order    
--21> sort row using order by in movies table (movies)
select * from movies order by release_date asc;

--22> sort row using order by in movies table (movies)
select * from movies order by release_date desc; 

--23> sort all movie recor by thier release_date in dsc and movie_name in asc
select * from movies order by release_date desc , movie_name asc;

--24> sort last name as surname in actors table (movies)
select first_name , last_name as "sur name" from actors order by  "sur name" asc;
select first_name , last_name as surname from actors order by  surname asc;

--25> sort rows by length of first_name in actors table (moives)
select first_name , length(first_name) from actors;
select * from actors order by length(first_name) desc;
select first_name , length(first_name) as fname from actors order by fname;

--26> specify order of NULL values while sorting rows actors table (movies)
-- using NULL first Null last 
select first_name from actors order by first_name nulls first;
select first_name from actors order by first_name nulls last;

--27> get all English language movies from movies table (movies)
select * from movies where movie_lang = 'English';

--28> get all Japanese language movies from movies table (movies)
select movie_id , movie_name , movie_lang from movies where movie_lang = 'Japanese';

--29> get all English movies and age certificate to 18 from movies table (movies)
select movie_name , movie_lang , age_certificate from movies 
where movie_lang = 'English' and age_certificate = '18';

--30> get all English movies or Chinese movies from movies table (movies)
select movie_name , movie_lang from movies where movie_lang in ('English', 'Chinese');
select movie_name , movie_lang from movies where movie_lang = 'English' or movie_lang='Chinese';


--31> get all English movies with directors id 10 from moives table (movies)
select movie_name , director_id , movie_lang from movies where movie_lang ='English' and director_id = '8';


--32> get all Englis or chinese movies with age certificate of 12
select movie_name , movie_lang , age_certificate from movies
 where movie_lang in ('English' , 'Chinese') and age_certificate = '12'


--33> get all movies where movie length is greater than 100 order them \\ movies table (movies)
select * from movies where movie_length > '100' order by movie_length

--33> get all movies where movie length is greater or equal to 104 order them \\ movies table (movies)
select * from movies where movie_length >= '104' order by movie_length

--33> get all movies where movie length is less or equal to 100 order them \\ movies table (movies)
select * from movies where movie_length <= '100' order by movie_length

--34> get all movies after year 2000 from movies table (movies)
select * from movies where release_date > '2000-12-31';

--35> get all movies where language is greater than English from movies table (movies)
select * from movies where movie_lang > 'English' order by movie_lang;

--36> get all movies where language is not englis from movies table (movies)
select * from movies where movie_lang <> 'English' order by movie_lang;
select * from movies where movie_lang not in ('English') order by movie_lang;

-- 37> get top 5 movies by length from movies table (movies)
select * from movies order by movie_length desc limit 5select * from movies 
order by movie_length desc 
limit 5;

-- 38> get 5 oldest american directors from directors table (movies)
select first_name , last_name, date_of_birth from directors
where nationality = 'American'
order by date_of_birth
limit 5;

-- 39> get  10 youngest female actress from actors table (movies)
select * from actors;
select * from actors where gender='F'
order by date_of_birth desc 
limit 10

-- 40> get top 10 most profitabel domestic movies from movies_revenues table (movies)
select * from movies_revenues

    select * from movies_revenues
    order by revenues_domestic desc nulls last
    limit 10

--41> get top 10 least profitable domestic movies from movies_revenues table (movies)
select * from movies_revenues 
order by revenues_domestic asc nulls last
limit 10

--42> list top 5 movies after top 5 highest profitable movies from movies_revenue
select * from movies_revenues
order by revenues_domestic desc nulls last
offset 5
limit 5 


--offset start {rows | rows}
--fetch {first | next} {row_count} {ROW | ROWS} only

--43> list top 5 movies 
select * from movies_revenues
order by revenues_domestic desc nulls last
fetch first 5 row only

--44> get top 5 movies by length 
select * from movies
order by movie_length desc nulls last   
fetch first 5 row only

--45> get top 5 oldest american directors
select * from directors
order by date_of_birth 
fetch first 5 row only 

--46> get top 10 youngest female actors
select * from actors
where gender='F'
order by date_of_birth desc
fetch first 10 rows only

--47> get first 5 movies after 5th movie long movie length
select * from movies
order by movie_length desc
offset 5
fetch first 5 rows only

--48> get all movies with english , japanese , chinese lang
select * from movies
where movie_lang in ('English', 'Japanese','Chinese')

--49> get all movies wiht age 13 and PG
select * from movies
where age_certificate in ('12' , 'PG')
order by age_certificate

--50> get all movies where director id is not 13 or 10 
select * from movies
where director_id not in (13 , 10)
order by director_id asc 

--51> get all actors where actors id not in 1,2,3,4

select * from actors
offset 4

select * from actors where actor_id not in (1,2,3,4) order by actor_id


--52> get all actors where birth date btwn 1991 and 1995    
select * from actors
where date_of_birth between '1991-01-01' and '1995-12-31'

--53> get all movies date between 1998 and 2002
select * from movies
where release_date between '1999-01-01' and '2002-12-31'
order by release_date

--54> get all movies where domestic revenues btwn 100 and 300
select * from movies_revenues
where revenues_domestic between 100 and 300

--55> get all movies in english where length btwn 100 and 200
select * from movies
where movie_lang = 'English' and movie_length between 100 and 200

--56> get all actors name wherer first name starting with 'A'
select * from actors
where first_name like 'A%'
order by first_name

--57> get all actors whoes last name end wiht 'a'
select * from actors
where first_name like '%a'
order by first_name

--58> get all actors where first name is 5 characters only
select * from actors
where first_name like '_____'
order by first_name


--59> all actors where l is second place in first_name 
select first_name , last_name from actors
where first_name like '_l%'
order by first_name

--60> find all actors with missing birtth date
select actor_id , first_name , last_name , date_of_birth from actors
where date_of_birth is null 
order by actor_id

--  61> find list of actors with missing birth_date or first_name
select actor_id , first_name , last_name , date_of_birth from actors
where  first_name in ('Null')
order by actor_id


-- 62> get list of movies where domestic revenue in null
select movie_id , revenue_id , revenues_domestic from movies_revenues
where revenues_domestic is null
order by revenue_id

-- 63 get list of movies where either domestic or international revenues are null
select * from movies_revenues
where revenues_domestic is null or revenues_international is null 
order by revenue_id 

--64 list of movies where domestic revenues is not null
select * from movies_revenues
where revenues_domestic is not null

-- 65> combine actors first name and last name as 'Actor name'
select actor_id , concat(first_name , last_name) as "Actor name" from actors
where actor_id=29;

select actor_id , (first_name || last_name) as "Actor name" from actors
where actor_id=29;

-- 66> print first name , last name , date of birth separated by comma 
select concat_ws(' , ' , first_name , last_name , date_of_birth)  from actors

-- 67> uuid 
create extension if not exists "uuid-ossp";
select uuid_generate_v1();


--68> alter table and add column 
select * from person
create table person(
    person_id serial primary key,
    first_namee varchar(20) not null,
    last_name varchar(20) not null
    );


alter table person 
add column email varchar(20) unique ,
add column age int  not null

--69> rename a table 
alter table person 
rename to users

select * from users

-- 70> rename column name
alter table users 
rename column age to person_age

-- 71> change column data type
alter table users
alter column  person_age type int 
using person_age::integer

alter table users
alter column is_enable set default 'Y';

insert into users(person_age , first_namee , last_name)
values (1 , 'shil' , 'kalar') , (92 , 'sa' , 'adf');

select * from users

--72> add unique key constraints
create table web_links(
    link_id serial primary key,
    link_url varchar(200) not null,
    link_target varchar(20) );

select * from web_links

insert into web_links(link_url , link_target)
values('abc.com' , 'abc') , ('123.com' , '123');

alter table web_links
add constraint unique_web_url unique (link_url);


insert into web_links(link_url , link_target)
values('abc1.com' , 'abc') , ('123a.com' , '123');

alter table web_links
add column is_enable varchar(2)


insert into web_links(link_url , link_target)
values('abc2.com' , 'abc') , ('123b.com' , '123');

insert into web_links(link_url , link_target , is_enable)
values('abc2sdf.com' , 'abc' , 'Y') , ('1asdf23b.com' , '123', 'Y');


alter table web_links 
add check (is_enable in ('Y' , 'N'))


insert into web_links(link_url , link_target , is_enable)
values('abasdflc2.com' , 'abc' , 'Y') , ('123sdffasdfb.com' , '123' , 'N');


--  explicit conversion 
-- 73> create a table ratings
create table ratings(
    rating_id serial primary key,
    rating varchar(1) not null 
);

select * from ratings

insert into ratings (rating)
values ('A') , ('B') , ('C');

insert into ratings (rating)
values (1) , (2) , (3);

--74> now requirements changed and  ratings have to be in numeric
 
select rating_id,
case 
    when rating~E'^\\d+$' then 
    cast (rating as integer)
    else 
        0
    end as rating
from ratings

--75> convert an integer to string

select to_char(
    100870,
    '9,99999'
);

--76> movie release date in dd--mm--yyy format
select release_date,
    to_char(release_date , 'DD-MM-YYYY'),
    to_char(release_date , 'Dy , MM , YYYY')
from movies

--78> conevert time stamp literal to a string
select 
to_char(
    timestamp '2020-01-01 10:30:59',
    'HH24:MI:SS'
);

select * from movies
--79> movie revenue to char add $ symbol
select 
 movie_id,
 revenues_domestic,
 to_char(revenues_domestic , '$99999D99')
 from movies_revenues

--80> convert a sting to a number
select to_number(
    '1420.89',
    '9999.9'
);

select to_number(
    '14,20.89-',
    '99G99.99S'
);

select to_number(
    '$1,42,230.89',
    'L9G99g999.99'
);

--81> convert to string to date
select to_date(
    '2020/10/22',
    'YYYY/MM/DD'
);

select to_date(
    '022199',
    'MMDDYY'
);


select to_date(
    '022199',
    'MMDDYY'
);

-- 82> create a address domain data type
create domain addr varchar(100) not null

create table locations(
    address addr
);

insert into locations(address)
values ('alsdf asdf') , ('adf sadf');

select * from locations

--83> create a postive integer domain data type 
create domain positive_numeric int not null check (value > 0)

create table sample(
    sample_id serial primary key, 
    value_num positive_numeric
);

insert into sample (value_num)
values (5) , (4) , (8);

select * from sample


--84> create us postal code domain to check for valid postal code
create domain us_postal_code1 as text 
check (
    value ~ '^\d{5}$'
    or 
    value ~ '^\D{5}-\d{4}$'
);

create table addresses(
    address_id serial primary key,
    postal_code us_postal_code1
);

alter table addresses 
alter column postal_code type us_postal_code1

select * from addresses

insert into addresses(postal_code)
values('50080');

insert into addresses(postal_code)
values('asbdc-7878');

-- 85> create email domain 
create domain prp_email varchar(100) 
check(
    value ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
);

create table clients_name(
    clients_name_id serial primary key,
    email prp_email
);

insert into clients_name(email)
values('abc@gmail.com')

insert into clients_name(email)
values('abcgmail.com')

select * from clients_name

--86> get all domains data types 
select typname
from pg_catalog.pg_type
join pg_catalog.pg_namespace
on pg_namespace.oid = pg_type.typnamespace
where
typtype = 'd' and nspname = 'public'


--87> drop a domain 

drop domain positive_numeric cascade 
select * from sample 

-- change dependent column data type to some other data type 

--88> create a composite data types


create type address as(
   city varchar(50),
   country varchar(20)
); 


create table companies(
    comp_id serial primary key,
    address address
) 

insert into companies (address)
values (row('asd' , 'adsf'))
select  (companies.address).city from companies

--89> create enumerate or set of values
create domain valid_color varchar(10) check ( value in ('red' , 'blue' , 'green'));
create table colors( color valid_color); insert into colors(color) values ('red') insert into colors(color) values ('yeloow') select * from colors 

--90> creating composite inventory
create type inventory_items as (
    product_name varchar(200),
    suplier_id int,
    price numeric
);

create table inventory(
   inventory_id serial primary key,
   item inventory_items);

insert into inventory (item)
values (row('paper',20,10))

-- insert into inventory (item)
-- values (row(price:=20,suplier_id:=10,product_name:='adsf')::inventory_items)

-- INSERT INTO inventory (item)
-- VALUES (ROW(price := 10, supplier_id := 20, product_name := 'paper')::inventory_items);


select * from inventory

-- 91> creat a  type currency as enum
create type currency as enum ('usd' , 'eur' , 'gbp')

select 'usd' ::  currency

alter type currency add value 'chf' after 'eur'
 

create table stocks(
    stock_id serial primary key,
    stock_currency currency
);
 
insert into stocks(stock_currency) 
values ('chf')

insert into stocks(stock_currency) 
values ('usd')

select * from stocks

-- 92> updating enum data in prod server
create type status_enum as 
enum ('queued', 'waiting', 'running' , 'done')

create table jobs (
    job_id serial primary key,
    job_status status_enum
);

insert into jobs(job_status)
values('done') , ('queued') , ('running') , ('done') , ('waiting')

select * from jobs

-- change waiting status to running status 
update jobs set job_status = 'running' where job_status = 'waiting'

alter type status_enum rename to status_enum_old 

create type status_enum as enum('queued' , 'running' , 'done')


alter table jobs alter column job_status type status_enum using job_status :: text :: status_enum

drop type  status_enum_old


-- 93> default enum data type 
create type status as enum('pendin' , 'finished')

create table cron_jobs1(
    cron_job_id int, 
    status status default 'pendin'
);

insert into cron_jobs(cron_job_id)
values (1);  

--94> null constraints 
create table table_nun(
    id serial primary key,
    tag text not null
);
-- valid
insert into table_nun(tag)
values('adf'), (''),('0')


-- alter and add value of not null

create table table_nun2(
    id serial primary key,
    tag text
);

alter table table_nun2 
alter column tag set not null

-- add unique constraint to column 

create table table_uniq(
    id serial primary key,
    email varchar(100) unique
);

-- 95 add default key constraints 

create table employees(
    id serial primary key, 
    first_name varchar(50),
    last_name varchar(50),
    is_enable varchar(2) default  'Y'
);
    
select * from employees

insert into employees(first_name , last_name)
values('aasdf' , 'asdfadsf')
,('akdfhldfdsf' , 'asdfljaldsjfjasdf')


alter table employees 
alter column is_enable 

-- 96 composite key

create table t_grades(
    course_id int not null, 
    student_id int not null,
    grades int not null,
    primary key (course_id , student_id)
);

select * from t_grades

-- drop primary key constraints
alter table t_grades
drop constraint t_grades_pkey 

alter table t_grades
add constraint t_grades_pkey 
primary key (course_id , student_id)

-- 97 foriegin key 
create table t_products(
    product_id int primary key,
    product_name varchar (100) not null,
    supplier_id int not null,
    foreign key (supplier_id) references t_suppliers (supplier_id)
);

create table t_suppliers(
    supplier_id int primary key,
    supplier_name varchar(100) not null
);

insert into t_suppliers (supplier_id , supplier_name)
values (100 , 'supp 3') , (1,'supp 1'),
(2,'supp 2');

insert into t_products (product_id , product_name , supplier_id)
values (3 , 'cmp' , 100) , (1 , 'pen' , 1) , 
(2 , 'paper' , 2)

select * from t_products

delete from t_suppliers where supplier_id = 100

-- drop constraints 
-- 98> check constraints 
create table emp_salary(
    salary int not null check ( salary > 100)
);

alter table emp_salary 
alter salary drop not null

--99> upper lower initcap
select uppeR('asf')
select lower('AsDF')
select ('hey this iis initcap')

--100> left and right
select left('abcdefg',2);
select left('abcdefg',-1);

select right('abcdefg',2);
select right('abcdefg' , -1);

--101> reverse
select reverse('abcdefg')

--102> split_part 
select split_part('a,b,c',',',2);
select split_part('|a|||b||c||', '|' , 7)
select split_part('a|b$c' , '|'  , 2)

-- 103> trim 
select trim (
    leading 
        from '    asdf'
),
trim(
    trailing
        from 'adf      '
),
trim(
    trailing
        from '        adf        '
);

select trim(
    leading '0'
        from '0000984'
);

-- 104> ltrim , rtrim , btrim
select ltrim('   asdlf');
select ltrim('aaaaasdlf','a');
select rtrim('asdlfffffff','f');
select btrim('aaaaasdlfaaaaa','a');

-- 105> lpad , rpad

select lpad('database' , 15 , '*');
select rpad('Database' , 5 , '*');

select 
    mv.movie_name,
    r.revenues_domestic,
    lpad('', cast(trunc(r.revenues_domestic / 10) as int) , '*') chart
from movies mv
inner join movies_revenues r on r.movie_id = mv.movie_id
order by 3 desc
nulls last

select * from movies_revenues
-- 106 length function and length of  actors name

select (first_name || ' ' || last_name)as name  
, length(first_name || ' ' || last_name) as len
from actors
order by 2 desc

-- 107 position in string 
select  position ('ing' in 'amaizing')

--108 substring function
select substring('this is substr' from 1 for 6)

--109 select inital of directors
select first_name , substring(first_name , 1 , 1) from directors
order by 2 

-- 110 repeat function 
select repeat('ab' , 10)

-- 111 replace function 
select replace('abc ddd' , ' ' , '1')
select replace('abc ddd' , 'd' , '1')

-- 112 count function
select count(*) from movies
select * from movies 
select count(movie_length) from movies

--113 distinct function find distinct movie language
select distinct(movie_lang) from movies

select count(distinct(movie_lang)) from movies

-- 114  count distinct directors 
select * from directors
select distinct(first_name || ' ' || last_name) from directors
select count(distinct(first_name || ' ' || last_name)) from directors

-- 115 count all english movies 
select * from movies
select count(movie_lang) from movies where movie_lang = 'English'

-- 116 sum function 
-- all movies revenue records
select * from movies_revenues

-- total domestic revenue for all movies
select sum(revenues_domestic) from movies_revenues

-- get total domestic revenue where domestic revenue is greater than 200
select sum(revenues_domestic) from movies_revenues 
where revenues_domestic > 200 

-- get total length of all english movies
select sum(movie_length) from movies
where movie_lang = 'English'

-- can i sum all movie name 
select sum(movie_name) from movies


--117 min ,max functions
--longest length movie 
select max(movie_length) from movies 
-- shotest movie by length 
select min(movie_length) from movies

-- longest english movie
select max(movie_length) from movies where movie_lang = 'English'


-- latest released movie in englis
select max(release_date) from movies where movie_lang = 'English'

select release_date from movies 
where movie_lang = 'English'
order by release_date desc

-- what was first movie in chinese lang
select * 
from movies
where release_date = (select  min(release_date) from movies where movie_lang = 'Chinese') 
and movie_lang = 'Chinese'

--min and max on movie name
select min(movie_name) from movies
select max(movie_name) from movies


-- greatest and least revenue from domestic and international for each movie
select revenues_domestic ,
revenues_international,
greatest(revenues_domestic  , revenues_international) as great,
least(revenues_domestic , revenues_international) as least
from movies_revenues

-- 118 average movie length for all movies
select avg(movie_length) from movies

-- get avg length of all english movies
select avg(movie_length) from movies where movie_lang = 'English'

--119 mathemetical opertaion 
-- get total revenue for each movies order by highest revenue
select * from movies_revenues
select revenues_domestic , revenues_international ,
(revenues_domestic + revenues_international) as total_revenue
from movies_revenues
order by 3 desc
nulls last
select current_timestamp


-- 120 group by 
select * from movies
select movie_lang ,  count(*)  from movies group by movie_lang

-- 121 avg movie length group by movies language
select movie_lang , avg(movie_length) from movies 
group by movie_lang
order by 2

select age_certificate , sum(movie_length)from movies group by age_certificate

select movie_lang , min(movie_length) , max(movie_length)  from movies group by movie_lang

-- 122 get avg movie length group by movie lang and age certifiaction 
select age_certificate , movie_lang , avg(movie_length) from movies group by movie_lang , age_certificate


-- 123 get avg movie length group by movie lang and age certifiaction where movie length is greater than 100
select movie_lang , age_certificate , avg(movie_length) from movies
where movie_length > 100
group by movie_lang , age_certificate
order by 

-- 124 get avg movie len grp by age cerificate where age certificate = 10
select age_certificate , avg(movie_length) from movies
where age_certificate = 'PG'
group by age_certificate

select * from movies

-- 125 how many directors per each nationality
select * from directors

select nationality  , count(*) from directors
group by nationality
order by 2 desc

--126 get tot sum of movie length for each age certification and movie language combination
select movie_lang  , age_certificate , sum(movie_length) from movies
group by age_certificate , movie_lang 
order by 3 desc

--127 list movie lang where sum total length of the movies is greater than 200
select movie_lang , sum(movie_length) from movies
group by movie_lang
having sum(movie_length) > 200
order by 2

--128 list all directors where sum total of movie length is > 200
select director_id , sum(movie_length) from movies
group by director_id
having sum(movie_length) > 200
order by 1

select * from directors
select * from movies

--129 group by with null values
create table employees_test(
    employee_id serial primary key,
    employee_name varchar(100),
    department varchar(100),
    salary int
);     

insert into employees_test(employee_name , department , salary)
values ('John' , 'finance' , 25000), 
('Mary' , null , 3000),
('Adam' , null , 4000),
('Bruce' ,'finance', 4000 ),
('Linda' , 'IT' ,  5000),
('Megan' , 'IT', 4000)


select * from employees_test

-- how many employee for each department
select department , count(employee_id) from employees_test 
group by department 

-- handling null values
--use coalesce
select coalesce(department,'not assigned') , count(employee_id) from employees_test 
group by department 

-- 130 joins 
-- connecting movies and directors
select * from movies;
select * from directors

select 
t2.movie_id ,  
t2.movie_name , 
t1.director_id , 
t1.first_name 
from 
directors as t1 inner join movies as t2 
on t1.director_id = t2.director_id
order by t1.first_name


-- connecting movies and movies_revenue
select * from movies;
select * from movies_revenues;

select 
m.movie_name,
mr.revenues_domestic,
mr.revenues_international
from 
movies as m inner join movies_revenues as mr 
-- on m.movie_id = mr.movie_id
using (movie_id)
order by mr.revenues_domestic desc
nulls last

-- connecting movies , movies_revenues , directors table
select 
m.movie_name,
mr.revenues_domestic,
d.first_name,
d.last_name
from 
(movies as m inner join movies_revenues as mr
using (movie_id)) inner join directors d using (director_id)


-- 131 select movie name , director name , domestic revnue for all japanese movie
select 
m.movie_name,
m.movie_lang,
(d.first_name || ' ' || d.last_name) as Directors_name , 
mr.revenues_domestic
from 
(movies as m inner join movies_revenues as mr
using (movie_id)) inner join directors d using (director_id)
where m.movie_lang = 'Japanese'

select (first_name || last_name) as d from directors


--132 select movie name , directors name for all english , chinese , japanses movie 
-- where domestiv revenue is greater than 100

select 
m.movie_name,
d.first_name,
d.last_name,
mr.revenues_domestic
from 
(movies as m inner join movies_revenues as mr using (movie_id))
inner join directors d using (director_id)
where m.movie_lang in ('English' , 'Chinese', 'Japanese') 
and mr.revenues_domestic > 100
order by 4 desc;

-- 133 select movie name , director name , movie lang total revenue for top 5 movies
select 
m.movie_name,
d.first_name,
d.last_name,
(mr.revenues_domestic + mr.revenues_international) as total_revenue
from 
(movies as m inner join movies_revenues as mr using (movie_id))
inner join directors d using (director_id)
order by 4 desc
nulls last
limit 5

--134 select top 10 profitable movies btwn 2005 and 2008 print movie name , movie director , revenue

select 
m.movie_name,
d.first_name,
d.last_name,
mr.revenues_domestic,
mr.revenues_international,
(mr.revenues_domestic + mr.revenues_international) as total_revenue
from 
(movies as m inner join movies_revenues as mr using (movie_id))
inner join directors d using (director_id)
where release_date between '2005-01-01' and '2008-12-31'
order by  total_revenue desc 
limit 10

-- 135 select all movies with directors first name and last name 
select
*
from 
directors as d  left join  movies as m using (director_id)

select * from movies
select * from directors

insert into directors(first_name,last_name , date_of_birth , nationality)
values ('James', 'David' , '2010-01-01' , 'American')

-- 136 count all movies for each directors
select
*
from 
directors as d left join movies as m using (director_id)
-- group by first_name , last_name
order by 1

select 
d.director_id,
d.first_name,
d.last_name,
d.nationality
from 
directors as d left join movies as m using (director_id)
group by director_id
order by director_id

select * from directors


-- -137 get all movies  with age certification  for all directors where nationalities in 'American' , 'English' , 'Chinese'

select 
d.first_name,
d.last_name,
m.movie_name,
m.age_certificate
from
directors as d left join movies as m using (director_id)
where d.nationality in  ('American' , 'English' , 'Chinese')
group by d.director_id , m.movie_id

-- 138 get all total revenues done by each films for each directors
select
d.first_name,
d.last_name,
sum(mr.revenues_domestic + mr.revenues_international)
from
directors as d left join movies as m using (director_id) left join movies_revenues as mr using (movie_id)
group by d.first_name , d.last_name
order by 3

-- 139 get all movies with directors first and last name , and movie name

select 
m.movie_name,
d.first_name,
d.last_name 
from 
directors as d right join movies as m using (director_id)

select 
m.movie_name,
d.first_name,
d.last_name 
from 
directors as d left join movies as m using (director_id)

-- 139 get all movies with directors first and last name , and movie name where lang in english , chinese only 

select 
m.movie_name,
d.first_name,
d.last_name,
m.movie_lang
from 
directors as d right join movies as m using (director_id)
where m.movie_lang in ('English' , 'Chinese')
order by 4

-- 140 count all movies for each directors

select 
d.first_name,
d.last_name,
coalesce(count(m.movie_id), 0)
from 
directors as d right join movies as m using(director_id)
group by d.first_name , d.last_name
order by 3


select 
d.first_name,
d.last_name,
d.director_id,
m.movie_name
from 
directors as d left join movies as m using(director_id)
order by 3


select 
d.first_name,
d.last_name,
d.director_id,
m.movie_name
from 
movies as m right join directors as d using (director_id)
-- directors as d left join movies as m using(director_id)
order by 3


-- 141 find all pairs of movie that have same movie length
select  m1.movie_id , m1.movie_length , m1.movie_name , 
m2.movie_id , m2.movie_name , m2.movie_length
from movies as m1 inner join movies as m2 using (movie_length)
where m1.movie_id <> m2.movie_id
order by movie_length

-- 142 natural join on moviesa and directors tables
select * 
from 
movies natural join directors
order by director_id


-- 143 union , union all

create table t1(
    fn varchar(100),
    ln varchar(100)
);

create table t2(
    fn varchar(100),
    ln varchar(100)
)
insert into t1 (fn , ln)
values('sahil' , 'kalariya')

insert into t2(fn , ln)
values('sahil' , 'kalariya')
values ('krish' , 'kalariya')
select fn, ln from t1
intersect
select fn , ln  from t2

-- 144 combine all directors where nationality are american , chinese , japanese  with all female actors
select 
 (first_name || ' ' || last_name) as NAME
 from directors
 where nationality in ('American' , 'Chinese' , 'Japanese')
 union 
 select 
 first_name
 from actors
 where gender = 'F'

-- 145 actors and directors with same last name and first name  j
select 
 first_name,
 last_name
 from actors
 intersect 
select 
    first_name,
    last_name
    from directors


-- 146 create schema human resources
create schema humanresourses

select * from hr.humanresourses.employee


--147 move a table to a new schema

alter table humanresours

-- 148 show search path
show search_path


--149 arrays 

select 
 array[1,2,3] || array[4,5,6]    

select 
array_cat(array[1,2,3] , array[4,5,6])    

select 
  4 || array[1,2,3]

select 
array_prepend(4 , array[1,2,3])


select 
array_append(array[1,2,3],4)

select 
    array_ndims(array[[1,2,3],[1,5,6]])
-- array[1,2,3]

--150 array search functions
select 
    array_position(array[1,2,3],3);

select 
    array_position(array['jan','feb','mar'],'feb')

select 
    array_position(array[1,2,2,3],2)

select 
    array_position(array[1,2,2,3],2,3)

-- 151 array modification prblm

select 
     array_remove(array[1,2,2,3] , 2)

select 
    array_replace(array[1,2,2,3] ,2 , 5)

-- 152 array comaprison 

select 
    2 in (2,3)

select 
    2 not in (1,3)

select 
    25 = all(array[1,2])
    
select 
    2 = all(array[2,2])


select 
    2 = any(array[1,2,3]) 

select 
    2 = any(array[1,3])

select 
    2 = any(array[1,2,null])

select 
    2 <> any(array[1,2])


-- 153 formating array 
select 
    string_to_array('1,2,3,4' , '|')    

select 
    string_to_array('1,2,3,,,4' , ',' , '')    

select 
    string_to_array('1,afd,3,,5,4' , ',' , 'afd') 

select 
    array_to_string(array[1,2,4] , '&')

select 
    array_to_string(array[1,2,4,null] , ',' , 'Emptydata')

--154 using array in tables
create table teachers1(
    teacher_id serial primary key,
    name varchar(150),
    phones text []
)

insert into teachers1(name , phones)
values (
    'adam' , array['(111)-222-333' , '(555)-666-777']
),
( 'linda', '{"(111)-123-4567"}' ),
( 'jeff', '{"(222)-555-9999", "(444)-786-12345"}' ) 


select name,phones[1]
from teachers1

-- search  number  (111)-123-4567
select * from teachers1
where 
'(111)-123-4567' = any(phones)


-- add phone number (800)-123-4567
update teachers1 
set phones[2] = '(800)-123-4567'
where teacher_id = 2 


-- 155 displaying all arr element in diffrent rows
select 
teacher_id,
name,
unnest(phones)
from teachers1
order by 3

-- 156 create multidimational array
create table students(
    student_id serial primary key,
    student_name varchar(100),
    student_grade integer [][]
);

insert into students (student_name,student_grade)
values('s1' , '{90,2020}'),
      ('s2' , '{80,2020}'),
      ('s3' , '{70,2019}'),
      ('s4' , '{60,2019}');

-- search all studens with grades greater than 80
select *  from students
where student_grade[1] > 70

--156 json
select '{
"t":   "this"
}':: json

create table book(
    book_id serial primary key,
    book_info jsonb
)

insert into book(book_info)
values('
{
"title":"book title1",
"author":"author1"
}')

select * from book

insert into book(book_info)
values('
{
"title":"book title2",
"author":"author2"
}'),
('
{"title":"book title3",
"author":"author3"
}'),
('{"title":"book title4",
"author":"author4"
}
'
)

select book_info->'title' from book
select book_info->>'title' from book


-- 157 filter 
select * from book
where
book_info->>'title' = 'book title1'

-- 158 update author 4

update book
set book_info = book_info || '{"author" : "sahil"}'
where book_info ->> 'author' = 'author4'


-- add additional value like best seller wiht boolean value

update book 
set book_info = book_info || '{"best sellet" : true}'
where book_info ->> 'author' = 'sahil'

-- delete best seller

update book  
set book_info = book_info - 'best sellet'
where book_info->>'author' = 'sahil'

-- add nested array data in json  availability location
update book 
set book_info = book_info || '{"availability_locations":[
"New york",
"Newjersey"]}'
where book_info ->>'author'= 'sahil'

select *from book

-- output directors table into json format
select row_to_json(directors) from directors

-- convrting firstname lastname 
select row_to_json(t) from (
    select 
        first_name,
        last_name
    from directors
) as  t


-- 159 select all movies in json for each directors
select * ,
(
    select json_agg(t) from (
    select  movie_name
    from movies
    where director_id = directors.director_id
) as t
)

from directors


--160 json array
select json_build_array(1,2,3,'Hi')

select json_build_array('name','sahil','email','abc')


-- 161 json inseret data
create  table docs(
    doc_id serial  primary key,
    doc jsonb)

insert into docs(doc)
select row_to_json(a)from (
select 
    first_name,
    last_name,
    nationality,
    (
        select json_agg(t) from (
        select movie_name
        from movies
        where director_id=directors.director_id
    )as  t
    )
    from directors
)as a


-- 162 create view for movie name with its director

create or replace view v_movies_directors_all as
select 
m.movie_name,
m.release_date,
d.first_name,
d.last_name,
d.nationality
from 
movies as m inner join directors as d using (director_id)

select * from v_movies_directors_all

-- 163 altering view name
alter view v_movies_directors_all rename to v_m_d_all

select * from v_m_d_all

-- 164 delete/drop a view 
drop view v_m_d_all

--  165 create view to list all movies released after 1997
create or replace view v_movie_release_after_1997 as
select * from movies
where release_date > '1997-12-31'

select * from v_movie_release_after_1997
where movie_lang = 'English'

--166 select movies  with directors with nationalities 'American', Japanses
select * from v_movies_directors_all
where nationality in ('American' , 'Japanese')

--167 select all people like actors and directors
create or replace view v_all_actors_directors as
select first_name , 
last_name,
'actors' as People_Type
from actors
union 
select first_name , last_name ,
'directors' as People_Type
from directors  

select * from v_all_actors_directors

-- 168 join all  tables and create a view
create or replace view v_movie_director_revenue as  
select 
m.movie_id,
m.movie_length,
m.movie_name,
m.movie_lang,
m.release_date,
m.age_certificate,
d.director_id,
d.first_name,
d.last_name,
mr.revenues_domestic,
mr.revenues_international
from 
movies as m inner join directors as d using (director_id)
inner join movies_revenues as mr using (movie_id)

select * from v_movie_director_revenue


-- 168 re aranging / delecte columns in view
--  delet and create new one

-- 169 add a column , we can add using replace view

create or replace view v_new as
select 
first_name,
last_name
from directors

-- 170 regular view does give updated data 


-- 171 using view to update tables

insert into v_new  (first_name) 
values ('dir1'),('dir2')

select * from v_new

-- 171 delete from view
delete from v_new
where first_name = 'dir1'

-- 172 create a view with check option
create table country(
    country_id serial primary key,
    name varchar(100)
)

insert into country(name)
values('US'),('Uk'),('India'),('US')


create or replace view v_country as
select * from country 
where  name = 'US'
with check option

insert into v_country(name)
values ('a')


-- 173 materialized view

create materialized view mv_directors as
select * from directors
with data

create materialized view mv_directors_2 as
select * from directors
with no data

select * from mv_directors
select * from mv_directors_2
 
refresh materialized view mv_directors_2


-- 174 drop a materialize view

drop materialized view mv_directors_2

-- 175 change  mv
-- cannot change materialized table 

-- 176 how to check if materialized view is populated or not
create materialized view mv_directors_2 as
select * from directors
with no data

select  * from mv_directors_2

select relispopulated from pg_class where relname = 'mv_directors_2'


-- 177 referesh data in materialized view
refresh materialized concurently view mv_directors

-- 178 index on orders 
select * from orders
create index idx_or_date on orders(order_date)
create index idx_or_cusid_ordid on orders(customer_id , order_id)

-- 179 unique ind
create unique  index idx_u_em_id on employees(employee_id)
create unique  index idx_u_em_id_hdate on employees(employee_id , hire_date)

--  180 list all indexes
select * from pg_indexes

-- 181 list sizze of indexes
select 
pg_size_pretty(pg_indexes_size('orders'))

-- 182 count all indexes
select 
*
from pg_stat_all_indexes

-- 183 creating hash index
create index i_od on orders
using hash (order_date)

-- 184 explain
explain select * from suppliers where supplier_id = 2    

-- 185 explain analyze
explain analyze select * from suppliers where supplier_id = 2    


-- 186 indexs are not free
select pg_size_pretty(pg_indexes_size('products'))

select  pg_size_pretty(
    pg_total_relation_size('products')
);

explain analyze select *  from  products where product_id = 10

create index ind_pid on products(product_id)

explain analyze select *  from  products where product_id = 10



-- 187 orders shipping to usa or france 
select * from orders
where ship_country in ('USA' , 'France')
order by ship_country

-- 187 count total no of orders shipping to usa or france 
select ship_country  , count(*) from orders
where ship_country in ('USA' , 'France')
group by ship_country

--188 select orders from latiln country
SELECT * FROM orders order by ship_region
SELECT * FROM orders
WHERE ship_country IN ('Brazil','Mexico','Argentina','Venezuela') ORDER BY ship_country

-- 189 show order total amount per each order line 
select * from order_details

select (unit_price * quantity) as Total from order_details

-- 190 select first and last order date
select min(order_date) as oldest , max(order_date) as latest 
from orders

-- 191 total products in each categpryad
select * from products
select * from categories
select 
c.category_id , 
c.category_name,
count(product_id)
from products as p
inner join categories as c using (category_id)
group by c.category_id

-- 192 list products that need rearanging
select * from products
where units_in_stock <= reorder_level

-- 193 list top 5 county with freight charges
select 
ship_country,
max(freight)
from orders 
group by ship_country
order by 2 desc
limit 5

-- 194 customer with no orders
select * from customers;
select * from orders

select 
*
from 
customers  as c left join orders as o using (customer_id)
where o.order_id  is null

-- 195 customer with total order amount

select 
customer_id,
count(order_id)
from 
customers  as c inner join orders as o using (customer_id)
group by customer_id
order by 2 desc


--- 196 orders with many line of items
select order_id , count(product_id)
 from order_details
group by order_id

-- 197 orders with double entry line 
select * from orders
where order_id = 10269 

select order_id,
quantity
from order_details
where quantity > 60 
group by 
    order_id,
    quantity
having 
 count(*) > 1
order by 2 desc

-- 198 select late shipped orders
select * from orders
where required_date < shipped_date


-- 199 select employee with late shipped orders
WITH late_orders AS 
(
SELECT employee_id,
COUNT(*) AS total_late_orders
FROM  orders
WHERE
shipped_date>required_date
GROUP by employee_id
),
all_orders AS
(
SELECT
employee_id,
COUNT(*) as total_orders
FROM orders
GROUP BY
employee_id
)
select * from employees 
SELECT
e.employee_id,
e.first_name,
a.total_orders,
l.total_late_orders
FROM employees e
JOIN all_orders a USING(employee_id)
JOIN late_orders l USING(employee_id)

-- 200  countries with customer or supplier 
SELECT country FROM customers
UNION
SELECT country FROM suppliers

-- 201 stock
select * from stocks_prices
where symbol_id = 1
order by price_date
limit 10

-- 202 
select symbol_id, 
min(price_date)
from stocks_prices
group by symbol_id

-- 203 cubrt 
select 
    close_price,
    cbrt(close_price)
from 
    stocks_prices
    where 
    symbol_id = 1
order by price_date 

