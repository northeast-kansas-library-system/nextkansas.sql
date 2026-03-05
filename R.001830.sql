/*
R.001830

----------

Name: HB - Circulation by Month, for All Time 
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     All Time

Created on: 2013-05-07 13:22:24
Modified on: 2023-10-16 21:57:27
Date last run: 2026-01-14 14:34:28

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Counts all circulation data in a month at a specified library&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Counts checkouts by month and year&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped and sorted by year and month&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Statistical data is only saved for the last 25 months, so this report cannot count checkouts that happened more than 25 months ago.&lt;/p&gt;
&lt;p&gt;Report created by Heather Braum.  Explanatory notes added and query updated by on 2018.01.08.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1830&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  branches.branchcode,
  stats.YEAR,
  stats.MONTH,
  stats.count
FROM
  branches
  LEFT JOIN (SELECT
        Year(statistics.datetime) AS YEAR,
        Date_Format(statistics.datetime, "%m") AS MONTH,
        count(&ast;) AS count,
        statistics.branch
      FROM
        statistics
      WHERE
        (statistics.type = 'issue' OR
          statistics.type = 'renew')
      GROUP BY
        Year(statistics.datetime),
        Date_Format(statistics.datetime, "%m"),
        statistics.branch) stats ON branches.branchcode = stats.branch
WHERE
  branches.branchcode LIKE &lt;&gt;
GROUP BY
  branches.branchcode,
  stats.YEAR,
  stats.MONTH,
  stats.count
ORDER BY
  stats.YEAR DESC,
  stats.MONTH DESC

























