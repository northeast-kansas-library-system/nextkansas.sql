/*
R.002364

----------

Name: unknown
Created by: Heather Braum

----------

Group: -
     -

Created on: 2014-09-08 11:15:12
Modified on: 2015-12-09 15:30:07
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT IFNULL(c.description, 'All') as "patron category", IFNULL(it.description, 'All') as "item type", IFNULL(i.maxissueqty, 'Unlimited') as "checkout limit", i.issuelength as "checkout days", ROUND(i.fine,2) as "fine per day", i.chargeperiod as "fine period", i.firstremind as "fines grace", i.renewalsallowed as "renewals allowed", i.renewalperiod as "renewal days" 
FROM issuingrules i LEFT JOIN categories c USING(categorycode) LEFT JOIN itemtypes it USING(itemtype) 
WHERE ORDER BY "patron category", "item type" LIMIT 500


