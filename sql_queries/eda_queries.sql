-- checking for duplicates 
select customerid, count(*) from temp_customer_info
	group by customerid having count(*) > 1
	
-- Counting duplicates
select count(*) - count(distinct customerid) as duplicate_count 
from temp_customer_info

-- Authenticating Data 
select * from temp_customer_info where customerid in (
    select customerid 
    from temp_customer_info 
    group by customerid 
    having count(*) > 1)
order by customerid; /* confirming whether its really a duplicate or different transactions
with the same customer id */

-- Removing duplicate 
select * from temp_customer_info where ctid not in (
select min(ctid) from temp_customer_info
group by customerid)

delete from temp_customer_info where ctid not in (
select min(ctid) from temp_customer_info
group by customerid)

-- checking for duplicates again
select customerid, count(*) from temp_customer_info
	group by customerid having count(*) > 1
	/* NONE */
