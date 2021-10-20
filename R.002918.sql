/*
R.002918

----------

Name: GHW - Overdue count at a library - during the previous calendar month
Created by: George H Williams

----------

Group: Circulation
     Overdues

Created on: 2017-03-02 14:05:56
Modified on: 2018-04-16 11:08:21
Date last run: 2021-08-15 21:21:37

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Counts the number of overdue items that were returned during the previous calendar month grouped by the number of days the item was overdue.</p>
<ul><li>Shows overdue items returned in the previous calendar month.</li>
<li>shows overdue items based on the check-out library you specify.</li>
<li>grouped and sorted by the check-out library and the number of days the item was late when it was checked in</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Starting in January of 2017, all NExpress items that were overdue more than 45 days began to be moved from being checked-out to being checked in with a "Lost (overdue more than 45 days)" status unless the items were checked out to patrons in certain categories (i.e. student/teacher/inhouse, etc).  Please take this into consideration when looking at the number of overdue items that are checked in when they are 46 days overdue.  These items will almost always be items that were automatically changed from overdue to "Lost."</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2918&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  old_issues.branchcode,
  DateDiff(old_issues.returndate, old_issues.date_due) AS DAYS_LATE,
  Count(DISTINCT old_issues.issue_id) AS COUNT
FROM
  old_issues
WHERE
  old_issues.branchcode LIKE <<Select library|ZBRAN>> AND
  Month(old_issues.returndate) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(old_issues.returndate) = Year(Now() - INTERVAL 1 MONTH) AND
  old_issues.date_due < old_issues.returndate
GROUP BY
  old_issues.branchcode, DateDiff(old_issues.returndate, old_issues.date_due)
ORDER BY
  DAYS_LATE,
  COUNT

























