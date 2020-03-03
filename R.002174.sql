/*
R.002174

----------

Name: Circulation Rules at Your Library, By Patron Category
Created by: Heather Braum

----------

Group: Circulation
     -

Created on: 2014-01-27 15:55:04
Modified on: 2014-05-07 14:09:39
Date last run: 2020-01-07 11:45:18

----------

Public: 0
Expiry: 0

----------

Choose your branch

----------
*/

SELECT IFNULL(c.description, 'All') as "patron category", IFNULL(it.description, 'All') as "item type", IFNULL(i.maxissueqty, 'Unlimited') as "checkout limit", i.issuelength as "checkout days", ROUND(i.fine,2) as "fine per day", i.chargeperiod as "fine period", i.firstremind as "fines grace", i.renewalsallowed as "renewals allowed", i.renewalperiod as "renewal days" 
FROM issuingrules i LEFT JOIN categories c USING(categorycode) LEFT JOIN itemtypes it USING(itemtype) 
WHERE i.branchcode=<<branchcode|branches>> ORDER BY "patron category", "item type" LIMIT 500



