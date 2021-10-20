/*
R.003129

----------

Name: Days out-ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-10-16 16:13:35
Modified on: 2018-10-16 16:13:35
Date last run: 2018-10-16 16:13:38

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  old_issues.branchcode,
  Cast(old_issues.returndate as date) AS CKI,
  Cast(old_issues.issuedate as date) AS CKO,
  DATEDIFF(DATE_FORMAT(old_issues.returndate, "%Y-%m-%d"),
  DATE_FORMAT(old_issues.issuedate, "%Y-%m-%d")) AS DAYSOUT 
FROM
  old_issues
WHERE
  Month(old_issues.returndate) = 09 AND
  Year(old_issues.returndate) = 2018
ORDER BY
  old_issues.branchcode,
  CKI

























