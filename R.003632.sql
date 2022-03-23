/*
R.003632

----------

Name: Count of overdues
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-12-29 18:01:14
Modified on: 2021-12-29 18:01:14
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  issues.branchcode,
  Date_Format(issues.date_due, "%Y.%m.%d"),
  issues.issue_id,
  issues.date_due,
  issues.returndate
FROM
  issues
WHERE
  issues.date_due <= Concat(Year(Now() - INTERVAL 1 MONTH), "-", Month(Now() -
  INTERVAL 1 MONTH), "-01")
GROUP BY
  issues.branchcode,
  issues.issue_id
UNION
SELECT
  old_issues.branchcode,
  Date_Format(old_issues.date_due, "%Y.%m.%d"),
  old_issues.issue_id,
  old_issues.date_due,
  old_issues.returndate
FROM
  old_issues
WHERE
  old_issues.date_due <= Concat(Year(Now() - INTERVAL 1 MONTH), "-",
  Month(Now() - INTERVAL 1 MONTH), "-01") AND
  old_issues.returndate > Concat(Year(Now() - INTERVAL 1 MONTH), "-",
  Month(Now() - INTERVAL 1 MONTH), "-01")
GROUP BY
  old_issues.branchcode,
  old_issues.issue_id
ORDER BY
  branchcode

























