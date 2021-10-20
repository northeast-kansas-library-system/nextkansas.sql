/*
R.002919

----------

Name: GHW - Overdue count at a library - during a month you specify
Created by: George H Williams

----------

Group: Circulation
     Overdues

Created on: 2017-03-02 15:01:10
Modified on: 2018-04-16 11:08:27
Date last run: 2021-08-15 21:22:13

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Counts the number of overdue items that were returned during the month you specify grouped by the number of days the item was overdue.</p>
<ul><li>Shows overdue items returned in the month you specify.</li>
<li>shows overdue items based on the check-out library you specify.</li>
<li>grouped and sorted by the check-out library and the number of days the item was late when it was checked in</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Starting in January of 2017, all NExpress items that were overdue more than 45 days began to be moved from being checked-out to being checked in with a "Lost (overdue more than 45 days)" status unless the items were checked out to patrons in certain categories (i.e. student/teacher/inhouse, etc).  Please take this into consideration when looking at the number of overdue items that are checked in when they are 46 days overdue.  These items will almost always be items that were automatically changed from overdue to "Lost."</p>
<p></p>
<p>Also note that NExpress old circulation data is purged once it is more than 13 months old.  You will not be able to run accurate reports on any check-ins from more than 13 months ago.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2919&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
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
  Month(old_issues.returndate) = <<Choose month|Month>> AND
  Year(old_issues.returndate) = <<Choose year|Year>> AND
  old_issues.date_due < old_issues.returndate
GROUP BY
  old_issues.branchcode, DateDiff(old_issues.returndate, old_issues.date_due)
ORDER BY
  old_issues.branchcode,
  DAYS_LATE

























