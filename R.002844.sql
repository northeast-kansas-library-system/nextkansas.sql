/*
R.002844

----------

Name: GHW - Deleted borrowers count - date range
Created by: George Williams

----------

Group: Borrowers
     Patron Statistics

Created on: 2016-12-02 14:56:53
Modified on: 2024-01-17 11:46:52
Date last run: 2023-09-07 17:00:14

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Count of patrons deleted during the specified date range&lt;br /&gt;(between the beginning of the day on the specified "START DATE" to the end of the day on the specified "END DATE")&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Looks at patrons who were manually deleted - does not include patrons that were deleted in batch processes&lt;/li&gt;
&lt;li&gt;Allows you to specify a patron home branch and patron category if you wish&lt;/li&gt;
&lt;li&gt;grouped by patron home branch and patron category - includes total count by home branch and a total for the entire table&lt;/li&gt;
&lt;li&gt;sorted by patron home branch and patron category&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Report created at the request of Paola Free Library.&lt;/p&gt;
&lt;p&gt;This report can only look back to the previous 60 days because we are purging data from the action logs that is more than 60 days old.&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2844&phase=Run this report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  deletedborrowers.branchcode AS PATRON_HOME_LIBRARY,
  deletedborrowers.categorycode AS PATRON_CATEGORY,
  Count(deletedborrowers.borrowernumber) AS COUNT_OF_PATRONS_DELETED
FROM
  action_logs JOIN
  deletedborrowers
    ON deletedborrowers.borrowernumber = action_logs.object
WHERE
  action_logs.module = 'MEMBERS' AND
  deletedborrowers.branchcode LIKE &lt;&gt; AND
  deletedborrowers.categorycode LIKE &lt;&gt; AND
  (action_logs.timestamp BETWEEN &lt;&gt;  AND (&lt;&gt;+ INTERVAL 1 DAY)) AND
  action_logs.action LIKE 'DELET%'
GROUP BY
  PATRON_HOME_LIBRARY, PATRON_CATEGORY
  WITH ROLLUP

























