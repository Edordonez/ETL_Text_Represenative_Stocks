---------
----------
--Data Wrangling getting rid of useless rows and preparing the dataset for queries

select * from ptr_transactions

select asset
from ptr_transactions

alter table ptr_transactions
drop column source

select * 
from ptr_transactions
where asset ilike '%Filing ID%'

DELETE FROM ptr_transactions
WHERE asset ILIKE '%Filing ID%';



ALTER TABLE ptr_transactions
ALTER COLUMN minimum TYPE numeric USING minimum::numeric,
ALTER COLUMN maximum TYPE numeric USING maximum::numeric;

-------------------------------------------------------------------------
-------------------------------------------------------------------------
------------------------------------------------------------------------

------- Business queries
select distinct(transaction_type) from ptr_transactions

--- selling metrics for may 


SELECT asset, minimum, maximum, COUNT(*) AS count, date
FROM ptr_transactions
WHERE transaction_type = 'S'
  AND date LIKE '05/%/2025'
GROUP BY asset, minimum, maximum, date
ORDER BY count DESC;



--- buying metrics for may 
select asset,minimum, maximum, count(*) as count, date
from ptr_transactions
where transaction_type = 'P'  and date ilike '05/%/2025'
group by asset, minimum, maximum, date
order by count desc


-----------------------------------------------------------
----------------------------------------------------------

--- potentially suspicious timing
SELECT asset, date, notification_date,
       (TO_DATE(notification_date, 'MM/DD/YYYY') - TO_DATE(date, 'MM/DD/YYYY')) AS days_delayed
FROM ptr_transactions
WHERE (TO_DATE(notification_date, 'MM/DD/YYYY') - TO_DATE(date, 'MM/DD/YYYY')) > 3
ORDER BY days_delayed DESC;


--------------------------------------------
--------------------------------------------
--------------------------------------------

----asset popularity by transaction type
SELECT asset, transaction_type, COUNT(*) AS count
FROM ptr_transactions
GROUP BY asset, transaction_type
ORDER BY count DESC
LIMIT 15;



