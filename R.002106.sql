/*
R.002106

----------

Name: Count of Borrowers per branch with over 100 accountlines
Created by: Heather Braum

----------

Group: Administrative Reports
     Slow Patrons - admin

Created on: 2013-11-19 10:45:10
Modified on: 2014-08-09 00:46:47
Date last run: -

----------

Public: 0
Expiry: 0

----------

broken. needs tweaking hb 11/19/13. 

----------
*/

SELECT borrowers.branchcode, (SELECT count(accountlines.borrowernumber) FROM accountlines, borrowers WHERE accountlines.borrowernumber=borrowers.borrowernumber GROUP BY accountlines.borrowernumber HAVING count(accountlines.accountlines_id) > 100) as count FROM borrowers GROUP BY borrowers.branchcode



