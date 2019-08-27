/*
R.002351

----------

Name: Total Charges paid at your branch per month
Created by: Heather Braum

----------

Group: Circulation
     Charges

Created on: 2014-09-03 16:58:46
Modified on: 2014-09-03 17:01:26
Date last run: 2019-06-24 18:09:56

----------

Public: 0
Expiry: 0

----------

Gives total of payments in Koha each month (listed as negative amount in the accountlines table); branch is based on staff accounts listed in manager_id recorded when fines are paid. 

----------
*/

SELECT month(a.date) as month, year(a.date) as year, ROUND(ABS(SUM(a.amount)),2) as total FROM accountlines a WHERE manager_id IN (SELECT borrowernumber FROM borrowers WHERE categorycode='STAFF' AND branchcode=<<choose branch|branches>>) AND a.accounttype="Pay" AND a.amount < 0 GROUP BY month(a.date), year(a.date) ORDER BY year, month



