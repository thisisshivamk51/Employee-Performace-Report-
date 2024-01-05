create database hr_analytics;

use hr_analytics;

select * from hr;

alter table hr
change column ï»¿id emp_id varchar(20) null;

describe hr;

select birthdate from hr;

set sql_safe_updates=0;

UPDATE hr
SET hire_date = CASE 
    WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

select birthdate from hr;
select hire_date from hr;

alter table hr modify column hire_date date;
alter table hr modify column birthdate date;

select birthdate from hr;

select termdate from hr;

-- Update rows with valid date strings
UPDATE hr
SET termdate = STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC')
WHERE termdate IS NOT NULL AND termdate != '';

-- Set empty strings to NULL
UPDATE hr
SET termdate = NULL
WHERE termdate = '';

-- Modify the column
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

describe hr;

alter table hr add column age int;

select * from hr;

update hr
set age = timestampdiff(YEAR,birthdate,curdate());

select birthdate,age from hr;

select 
 min(age) as youngest,
 max(age) as eldest 
 from hr ;
 
select count(*) from hr where age<18;









