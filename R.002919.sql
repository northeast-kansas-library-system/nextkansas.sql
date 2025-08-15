/*
R.002919

----------

Name: GHW - Overdue count at a library - during a month you specify
Created by: George Williams

----------

Group: Circulation
     Overdues

Created on: 2017-03-02 15:01:10
Modified on: 2024-01-17 11:49:18
Date last run: 2021-12-30 12:39:27

----------

Public: 0
Expiry: 0

----------

 
Counts the number of overdue items that were returned during the month you specify grouped by the number of days the item was overdue.
Shows overdue items returned in the month you specify.
shows overdue items based on the check-out library you specify.
grouped and sorted by the check-out library and the number of days the item was late when it was checked in

Notes:

Starting in January of 2017, all NExpress items that were overdue more than 45 days began to be moved from being checked-out to being checked in with a "Lost (overdue more than 45 days)" status unless the items were checked out to patrons in certain categories (i.e. student/teacher/inhouse, etc).  Please take this into consideration when looking at the number of overdue items that are checked in when they are 46 days overdue.  These items will almost always be items that were automatically changed from overdue to "Lost."

Also note that NExpress old circulation data is purged once it is more than 13 months old.  You will not be able to run accurate reports on any check-ins from more than 13 months ago.

Click here to run in a new window


----------
*/



SELECT
  old_issues.branchcode,
  DateDiff(old_issues.returndate, old_issues.date_due) AS DAYS_LATE,
  Count(DISTINCT old_issues.issue_id) AS COUNT
FROM
  old_issues
WHERE
  old_issues.branchcode LIKE &lt;&gt; AND
  Month(old_issues.returndate) = &lt;&gt; AND
  Year(old_issues.returndate) = &lt;&gt; AND
  old_issues.date_due &lt; old_issues.returndate
GROUP BY
  old_issues.branchcode, DateDiff(old_issues.returndate, old_issues.date_due)
ORDER BY
  old_issues.branchcode,
  DAYS_LATE

























