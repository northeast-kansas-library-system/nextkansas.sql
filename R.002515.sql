/*
R.002515

----------

Name: Monthly Fines Report
Created by: Robin Hastings

----------

Group: Circulation
     Charges

Created on: 2015-05-28 09:46:50
Modified on: 2015-05-28 10:41:01
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT ROUND(ABS(a.amount),2), a.accounttype as AMOUNT FROM accountlines a WHERE manager_id IN (SELECT borrowernumber FROM borrowers WHERE categorycode='STAFF' AND branchcode=<<choose branch|branches>>) AND  a.accounttype="L" AND year(a.date)=<<enter four digit year>> AND month(a.date)=<<enter two digit month>> AND a.amount < 0 



