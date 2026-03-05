/*
R.002950

----------

Name: GHW - Overdue count at a library - during the previous calendar month - LEAVENWRTH
Created by: George Williams

----------

Group:  LEAVENWRTH
     -

Created on: 2017-05-23 15:31:22
Modified on: 2024-01-17 11:49:41
Date last run: 2026-01-01 06:15:03

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Counts the number of overdue items that were returned during the previous calendar month grouped by the number of days the item was overdue.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows overdue items returned in the previous calendar month.&lt;/li&gt;
&lt;li&gt;shows overdue items checked out at LEAVENWRTH.&lt;/li&gt;
&lt;li&gt;grouped and sorted by the check-out library and the number of days the item was late when it was checked in&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Starting in January of 2017, all NExpress items that were overdue more than 45 days began to be moved from being checked-out to being checked in with a "Lost (overdue more than 45 days)" status unless the items were checked out to patrons in certain categories (i.e. student/teacher/inhouse, etc).  Please take this into consideration when looking at the number of overdue items that are checked in when they are 46 days overdue.  These items will almost always be items that were automatically changed from overdue to "Lost."&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2950&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

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
  Month(old_issues.returndate) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(old_issues.returndate) = Year(Now() - INTERVAL 1 MONTH) AND
  old_issues.date_due &lt; old_issues.returndate
GROUP BY
  old_issues.branchcode,
  DateDiff(old_issues.returndate, old_issues.date_due)
UNION
SELECT
  " Month" AS Column1,
  Concat(Year(Now() - INTERVAL 1 MONTH), " - ", Month(Now() - INTERVAL 1 MONTH)) AS Column2,
  NULL AS Column3
ORDER BY
  branchcode,
  DAYS_LATE,
  COUNT

























