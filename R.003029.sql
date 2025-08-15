/*
R.003029

----------

Name: GHW - Circulation Stats - Checkin count by flexible dates
Created by: George Williams

----------

Group: Daily, Monthly, Yearly Stats
     -

Created on: 2018-01-04 09:58:40
Modified on: 2024-01-17 11:52:28
Date last run: 2023-03-08 11:45:41

----------

Public: 0
Expiry: 300

----------

 
Counts checkins based on flexible date settings
Counts checkins based on the date parameters you set
at the library you choose
grouped and sorted by checkin branch and date of checkin

Notes:

This report replaces reports 2404, 2405, 2406, 2407, 2408, 2409, 2410

Click here to run in a new window


----------
*/



SELECT
  branches.branchcode,
  checkins.DATE,
  checkins.DAY_OF_WEEK,
  Coalesce(checkins.count, 0) AS CKI_COUNT
FROM
  branches
  LEFT JOIN (SELECT
        statistics.branch,
        Date_Format(statistics.datetime, "%Y-%m-%d") AS DATE,
        Date_Format(statistics.datetime, "%Y") AS YEAR,
        Date_Format(statistics.datetime, "%m") AS MONTH,
        Date_Format(statistics.datetime, "%d") AS DATEX,
        Date_Format(statistics.datetime, "%W") AS DAY_OF_WEEK,
        Count(*) AS count
      FROM
        statistics
      WHERE
        statistics.type = 'return' AND
        Date_Format(statistics.datetime, "%Y") LIKE &lt;&gt; AND
        Date_Format(statistics.datetime, "%m") LIKE &lt;&gt; AND
        Date_Format(statistics.datetime, "%d") LIKE &lt;&gt; AND
        Date_Format(statistics.datetime, "%W") LIKE &lt;&gt;
      GROUP BY
        statistics.branch,
        Date_Format(statistics.datetime, "%Y-%m-%d")) checkins ON branches.branchcode = checkins.branch
WHERE
  branches.branchcode LIKE &lt;&gt;
GROUP BY
  branches.branchcode,
  checkins.DATE
ORDER BY
  branches.branchcode,
  checkins.DATE

























