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
Date last run: 2025-10-17 11:53:51

----------

Public: 0
Expiry: 0

----------

 
Counts all circulation data in a month at a specified library
Counts checkouts by month and year
at the library you specify
grouped and sorted by year and month


Statistical data is only saved for the last 25 months, so this report cannot count checkouts that happened more than 25 months ago.
Report created by Heather Braum.  Explanatory notes added and query updated by on 2018.01.08.

Click here to run in a new window


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
  branches.branchcode LIKE &lt;&gt;
GROUP BY
  branches.branchcode,
  stats.YEAR,
  stats.MONTH,
  stats.count
ORDER BY
  stats.YEAR DESC,
  stats.MONTH DESC

























