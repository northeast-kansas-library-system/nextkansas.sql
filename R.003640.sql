/*
R.003640

----------

Name: COPY - GHW - Overdue count at a library - during the previous calendar month - LEAVENWRTH
Created by: Bywater bwssupport

----------

Group: -
     -

Created on: 2022-01-05 13:46:54
Modified on: 2024-01-17 11:29:18
Date last run: 2022-01-05 13:47:34

----------

Public: 0
Expiry: 300

----------

 
Counts the number of overdue items that were returned during the previous calendar month grouped by the number of days the item was overdue.
Shows overdue items returned in the previous calendar month.
shows overdue items checked out at LEAVENWRTH.
grouped and sorted by the check-out library and the number of days the item was late when it was checked in

Notes:

Starting in January of 2017, all NExpress items that were overdue more than 45 days began to be moved from being checked-out to being checked in with a "Lost (overdue more than 45 days)" status unless the items were checked out to patrons in certain categories (i.e. student/teacher/inhouse, etc).  Please take this into consideration when looking at the number of overdue items that are checked in when they are 46 days overdue.  These items will almost always be items that were automatically changed from overdue to "Lost."

Click here to run in a new window


----------
*/



SELECT
  old_issues.branchcode,
  LPad(DateDiff(old_issues.returndate, old_issues.date_due), 3, 0) AS DAYS_LATE,
  Count(DISTINCT old_issues.issue_id) AS COUNT
FROM
  old_issues
WHERE
  old_issues.branchcode LIKE "LEAVENWRTH" AND
  Month(old_issues.returndate) = Month(&lt;&gt;) - INTERVAL 1 MONTH) AND
  Year(old_issues.returndate) = Year(&lt;&gt;) - INTERVAL 1 MONTH) AND
  old_issues.date_due &lt; old_issues.returndate
GROUP BY
  old_issues.branchcode,
  DateDiff(old_issues.returndate, old_issues.date_due)
UNION
SELECT
  " Month" AS Column1,
  Concat(Year(&lt;&gt;) - INTERVAL 1 MONTH), " - ", Month(&lt;&gt;) - INTERVAL 1 MONTH)) AS Column2,
  NULL AS Column3
ORDER BY
  branchcode,
  DAYS_LATE,
  COUNT

























