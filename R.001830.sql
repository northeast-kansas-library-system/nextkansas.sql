/*
R.001830

----------

Name: HB - Circulation by Month, for All Time 
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     All Time

Created on: 2013-05-07 13:22:24
Modified on: 2018-04-16 10:48:15
Date last run: 2021-04-12 11:08:36

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Counts all circulation data in a month at a specified library</p>
<ul><li>Counts checkouts by month and year</li>
<li>at the library you specify</li>
<li>grouped and sorted by year and month</li>
</ul><br />
<p></p>
<p>Statistical data is only saved for the last 25 months, so this report cannot count checkouts that happened more than 25 months ago.</p>
<p>Report created by Heather Braum.  Explanatory notes added and query updated by on 2018.01.08.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1830&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

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
        count(*) AS count,
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
  branches.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branches.branchcode,
  stats.YEAR,
  stats.MONTH,
  stats.count
ORDER BY
  stats.YEAR DESC,
  stats.MONTH DESC



