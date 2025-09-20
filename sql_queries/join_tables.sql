- create final merged table on loan-level granularity
create table loan_analysis as
select 
    c.customerid,
    c.birthdate,
    c.bank_account_type,
    c.longitude_gps,
    c.latitude_gps,
    c.bank_name_clients,
    c.bank_branch_clients,
    c.employment_status_clients,
    c.level_of_education_clients,
    lh.systemloanid,
    lh.loannumber,
    lh.loanamount,
    lh.totaldue,
    lh.termdays,
    lh.approveddate,
    lh.creationdate,
    lh.closeddate,
    lh.referredby,
    lh.firstduedate,
    lh.firstrepaiddate,
    lp.good_bad_flag
from loan_history lh
join customer_info c on lh.customerid = c.customerid
join loan_performance lp 
	on lh.customerid = lp.customerid
		and lh.systemloanid = lp.systemloanid 
			and lh.loannumber = lp.loannumber
				where lp.good_bad_flag is not null
 					 and lh.loanamount is not null
				
/* Empty rows were returned but all the columns were returned*/
/* Debugging step by step */

-- Overlap of customerid (Test 1)
select count(*) 
	from loan_history lh 
		join loan_performance lp 
 			 on lh.customerid = lp.customerid

-- Overlap of customerid + loannumber (Test 2)
select count(*) 
	from loan_history lh 
		join loan_performance lp 
  			on lh.systemloanid = lp.systemloanid
 				and lh.loannumber = lp.loannumber

-- Combined join (Test 3)
select count(*) 
	from loan_history lh 
		join loan_performance lp 
 			 on lh.customerid = lp.customerid
 				and lh.systemloanid = lp.systemloanid
					 and lh.loannumber = lp.loannumber

/* Test 1 (customerid only) = 36,366 plenty of overlap.

Test 2 & 3 (systemloanid + loannumber) = 0, keys don’t line up at all between loan_history and loan_performance.

issue based on findings:
							systemloanid / loannumber in loan_performance are not consistent with loan_history at all 
							3-way joins wont work and i can only rely on customer id as the only valid and authentic means of joins */

-- Join on customerid
drop table if exists loan_analysis

create table loan_analysis as
select 
    c.customerid,
    c.birthdate,
    c.bank_account_type,
    c.longitude_gps,
    c.latitude_gps,
    c.bank_name_clients,
    c.bank_branch_clients,
    c.employment_status_clients,
    c.level_of_education_clients,

    lh.systemloanid,
    lh.loannumber,
    lh.loanamount,
    lh.totaldue,
    lh.termdays,
    lh.approveddate,
    lh.creationdate,
    lh.closeddate,
    lh.referredby,
    lh.firstduedate,
    lh.firstrepaiddate,

    lp.good_bad_flag
from loan_history lh
join customer_info c 
    on lh.customerid = c.customerid
join loan_performance lp 
    on lh.customerid = lp.customerid
where lp.good_bad_flag is not null
  and lh.loanamount is not null

 -- View table 
select * from loan_analysis

-- Sanity check
/* 1. Good vs Bad??? */
select good_bad_flag, count(*) 
	from loan_analysis 
		group by good_bad_flag

/* 2. How many unique Inputs?? */
select count(distinct customerid) from loan_analysis

/* 3. Any nulls here at all?? */
select count(*) 
	from loan_analysis
		where loanamount is null 
  		 	or totaldue is null 
  				 or termdays is null

-- loan_performance = 4368 rows
-- customer = 4334 rows
-- loan_history = 36366 rows
-- After joining all tables, final dataset = 27346 rows
-- Distribution of good_bad_flag: good = 22292, bad = 5054
-- 3264 records had missing matches in customer table
-- 0 duplicates found

-- drop null columns 
-- check null percentage for each column in loan_analysis
