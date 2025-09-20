--- Create Database 
Create database loan_analysis 

-- Importing first table 
create table loan_performance(customerid varchar primary key,
	systemloanid int,
	loannumber int,
	approveddate date,
	creationdate date,
	loanamount float,
	totaldue float,
	termdays int,
	referredby varchar,
	good_bad_flag varchar)

-- load loan_performance table
copy loan_performance from 'localfilepath\loan_performance.csv' with delimiter ',' csv header;

-- Checking the new table 
select * from loan_performance

/* Verify the datatype by initially inspecting the datasets with excel or a spreadsheet to prevent
errors while loading */

-- Importing second table
create table customer_info(customerid varchar primary key,
	birthdate date,
	bank_account_type varchar,
	longitude_gps numeric,
	latitude_gps numeric,
	bank_name_clients varchar,
	bank_branch_clients varchar,
	employment_status_clients varchar,
	level_of_education_clients varchar)

-- load loan_performance table
copy customer_info from 'C:\localfilepath\customer_info.csv' with delimiter ',' csv header;

/* ERROR:  duplicate key value violates unique constraint "customer_info_pkey"
Key (customerid)=(8a858fca5c35df2c015c39ad8695343e) already exists.*/

-- Import all without constraints 
create table temp_customer_info(customerid varchar,
	birthdate date,
	bank_account_type varchar,
	longitude_gps numeric,
	latitude_gps numeric,
	bank_name_clients varchar,
	bank_branch_clients varchar,
	employment_status_clients varchar,
	level_of_education_clients varchar)

-- Load table
copy temp_customer_info from 'C:\localfilepath\customer_info.csv' with delimiter ',' csv header

-- Create Table
create table customer_info as select * from temp_customer_info

-- Check table and drop the temporary table
select * from temp_customer_info
select * from customer_info
drop table temp_customer_info

-- View all present tables 
select table_name from information_schema.tables where table_schema = 'public';

-- Importing third table 
create table loan_history(customerid varchar,
	systemloanid numeric,
	loannumber numeric,
	approveddate date,
	creationdate date,
	loanamount numeric,
	totaldue numeric,
	termdays numeric,
	closeddate date,
	referredby varchar,
	firstduedate date,
	firstrepaiddate date)
	
-- load third table
copy loan_history from 'C:\localfilepath\loan_history.csv' with delimiter ',' csv header

-- View all tables 
select * from loan_history
select * from customer_info
select * from loan_performance

-- Check if loan_performance customers exist in customer_info
select count(*) as missing_customers from loan_performance lp left join 
customer_info c on lp.customerid = c.customerid where c.customerid is null

-- Check unique customers in loan_history vs loan_performance
select (select count(distinct customerid) from loan_history) as unique_customers_history,
    (select count(*) from loan_performance) as customers_performance

-- Check if loan_history has multiple loans per customer
select customerid, count(*) as loan_count from loan_history  group by customerid 
having count(*) > 1 limit 10;
