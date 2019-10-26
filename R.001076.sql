/*
R.001076

----------

Name: Number of Distinct Patrons served by Date range
Created by: -

----------

Group: Patrons
     Patron Statistics

Created on: 2011-03-24 21:18:00
Modified on: 2018-10-24 12:59:41
Date last run: 2019-10-07 13:54:25

----------

Public: 0
Expiry: 0

----------

Enhanced - Select Run, then enter Date Range and Patron's Libary #patrons

----------
*/

SELECT YEAR(issuedate), MONTH(issuedate), categorycode, COUNT(DISTINCT
borrowernumber)
FROM old_issues
 LEFT JOIN borrowers USING (borrowernumber)
where issuedate between <<Between (yyyy-mm-dd>> and <<and (yyyy-mm-dd>> and
old_issues.branchcode=<<Enter patrons library|branches>>
GROUP BY YEAR(issuedate), MONTH(issuedate), categorycode



