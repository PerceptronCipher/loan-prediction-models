-- Inspecting data
select * from loan_analysis

-- Adding a new column to store loan duration in days 
alter table loan_analysis add column loan_duration int

-- Populate the column with (closedate - creation date)
update loan_analysis set loan_duration = (closeddate - creationdate)

-- Adding a new column to track loan repayment in days 
alter table loan_analysis add column repayment_delay int

-- Populate the column with (closedate - creation date)
update loan_analysis set repayment_delay = (firstrepaiddate - firstduedate)

-- Early repayment flag 
alter table loan_analysis add column early_repayment_flag boolean
update loan_analysis set early_repayment_flag = case
    when firstrepaiddate is not null 
         and firstduedate is not null 
         	and firstrepaiddate < firstduedate 
    then true
    else false
end

-- Inspecting data
select * from loan_analysis

-- Loan/Total_due ratio
alter table loan_analysis add column loan_to_totaldue_ratio numeric
update loan_analysis set loan_to_totaldue_ratio = case
    when totaldue is not null and totaldue != 0
    	then loanamount / totaldue
    	else null
end

-- Charges expected to repay in % of principal amount borrowed 
alter table loan_analysis add column charges_pct numeric
update loan_analysis set charges_pct = case
    when loanamount is not null and loanamount != 0
    	then ((totaldue - loanamount) / loanamount) * 100
    		else null
end

-- Inspecting data
select * from loan_analysis

-- Creating a new column on approval month 
alter table loan_analysis add column month_of_approval int
update loan_analysis set month_of_approval = extract(month from approveddate)

-- Creating approval year column for trends 
alter table loan_analysis add column year_of_approval int

-- Populating the Year column
update loan_analysis set month_of_approval = extract(month from approveddate),
    year_of_approval  = extract(year from approveddate)

-- Feature Engineering on loan history 
alter table loan_analysis add column loan_count_per_customer int
update loan_analysis set loan_count_per_customer = ( select count(*) from loan_history
    where loan_history.customerid = loan_analysis.customerid)
	
-- Replace nulls = 0
update loan_analysis set loan_count_per_customer = 0 where loan_count_per_customer is null

-- Sanity check on the new column
select count(*), min(loan_count_per_customer), max(loan_count_per_customer)
from loan_analysis

-- Inspecting data
select * from loan_analysis

-- Clean good_bad_flag column 
select distinct good_bad_flag, count(*) from loan_analysis group by good_bad_flag

-- Standardize the column for ML
update loan_analysis set good_bad_flag = lower(trim(good_bad_flag)) where good_bad_flag is not null

-- Flag any inappropriate 
update loan_analysis set good_bad_flag = null where good_bad_flag not in ('good', 'bad')

-- Inspecting data
select * from loan_analysis

-- Verifying what's left
select good_bad_flag, count(*) from loan_analysis group by good_bad_flag


-- Extra ML Consideration before importing to Tableau Prep
alter table loan_analysis add column good_bad_flag_num int
update loan_analysis set good_bad_flag_num = 
    case 
    	when good_bad_flag = 'bad' then 0
        when good_bad_flag = 'good' then 1
        	else null
   	 			end

-- Inspecting data
select * from loan_analysis