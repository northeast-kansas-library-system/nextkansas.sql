/*
R.003028

----------

Name: GHW - Circulation Stats - Circulation count by flexible dates
Created by: George Williams

----------

Group: Daily, Monthly, Yearly Stats
     -

Created on: 2018-01-04 09:13:49
Modified on: 2024-01-17 11:52:25
Date last run: 2025-07-21 12:57:19

----------

Public: 0
Expiry: 300

----------

 
Counts circulation (checkouts and renewals) based on flexible date settings
Counts circulation based on the date parameters you set
at the library you choose
grouped and sorted by checkout branch and date of checkout

Notes:

Please note that items renewed via the OPAC are counted as renewals at the library where the item was checked out.  Therefore, if you see a circulation count at a library on a day that the library is normally closed, it is almost certainly due to a renewal initiated by the patron via the OPAC.

This report replaces reports 2396, 2397, 2398, 2399, 2400, 2401, and 2402

Click here to run in a new window


----------
*/



SELECT
  branches.branchcode,
  checkouts.DATE,
  checkouts.DAY_OF_WEEK,
  Coalesce(checkouts.count, 0) AS CKO_COUNT
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
        (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
        Date_Format(statistics.datetime, "%Y") LIKE &lt;&gt; AND
        Date_Format(statistics.datetime, "%m") LIKE &lt;&gt; AND
        Date_Format(statistics.datetime, "%d") LIKE &lt;&gt; AND
        Date_Format(statistics.datetime, "%W") LIKE &lt;&gt;
      GROUP BY
        statistics.branch,
        Date_Format(statistics.datetime, "%Y-%m-%d")) checkouts ON branches.branchcode = checkouts.branch
WHERE
  branches.branchcode LIKE &lt;&gt;
ORDER BY
  branches.branchcode,
  checkouts.DATE

























