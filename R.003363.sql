/*
R.003363

----------

Name: Sandbox - ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2020-11-09 22:24:51
Modified on: 2025-10-23 11:39:31
Date last run: 2025-10-23 12:00:53

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branchess.branchname AS "Library name",
  ALL_STATS.DATE AS "Date",
  ALL_STATS.DAY AS "Day",
  Coalesce(CKO.COUNT, 0) AS "Checkouts",
  Coalesce(RENEWALS.COUNT, 0) AS "Renewals",
  Coalesce(RETURNS.COUNT, 0) AS "Returns",
  ALL_STATS.COUNT AS "Checkouts + renewals + returns",
  Coalesce(ckoborrowers.Count_borrowernumber, 0) AS "Check out borrower count",
  Coalesce(renewborrowers.Count_borrowernumber, 0) AS "Renewal borrower count",
  totalborrowers.Count_borrowernumber AS "Check out + renewal borrower count"
FROM
  (SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches) branchess LEFT JOIN
  (SELECT
      statistics.branch,
      DayName(statistics.datetime) AS DAY,
      Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
      count(*) AS COUNT
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew' OR
        statistics.type = 'return') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch,
      DayName(statistics.datetime),
      Date_Format(statistics.datetime, '%Y-%m-%d')) ALL_STATS ON
      ALL_STATS.branch = branchess.branchcode LEFT JOIN
  (SELECT
      statistics.branch,
      DayName(statistics.datetime) AS DAY,
      Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
      count(*) AS COUNT
    FROM
      statistics
    WHERE
      statistics.type = 'return' AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch,
      DayName(statistics.datetime),
      Date_Format(statistics.datetime, '%Y-%m-%d')) RETURNS ON
      RETURNS.branch = branchess.branchcode AND
      RETURNS.DATE = ALL_STATS.DATE LEFT JOIN
  (SELECT
      statistics.branch,
      DayName(statistics.datetime) AS DAY,
      Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
      count(*) AS COUNT
    FROM
      statistics
    WHERE
      statistics.type = 'issue' AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch,
      DayName(statistics.datetime),
      Date_Format(statistics.datetime, '%Y-%m-%d')) CKO ON CKO.branch =
      branchess.branchcode AND
      CKO.DATE = ALL_STATS.DATE LEFT JOIN
  (SELECT
      statistics.branch,
      DayName(statistics.datetime) AS DAY,
      Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
      count(*) AS COUNT
    FROM
      statistics
    WHERE
      statistics.type = 'renew' AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch,
      DayName(statistics.datetime),
      Date_Format(statistics.datetime, '%Y-%m-%d')) RENEWALS ON
      RENEWALS.branch = branchess.branchcode AND
      RENEWALS.DATE = ALL_STATS.DATE LEFT JOIN
  (SELECT
      statistics.branch,
      DayName(statistics.datetime) AS DAY,
      Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber
    FROM
      statistics
    WHERE
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew')
    GROUP BY
      statistics.branch,
      DayName(statistics.datetime),
      Date_Format(statistics.datetime, '%Y-%m-%d')) totalborrowers ON
      totalborrowers.branch = branchess.branchcode AND
      totalborrowers.DATE = ALL_STATS.DATE LEFT JOIN
  (SELECT
      statistics.branch,
      DayName(statistics.datetime) AS DAY,
      Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber
    FROM
      statistics
    WHERE
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      statistics.type = 'issue'
    GROUP BY
      statistics.branch,
      DayName(statistics.datetime),
      Date_Format(statistics.datetime, '%Y-%m-%d')) ckoborrowers ON
      ckoborrowers.branch = branchess.branchcode AND
      ckoborrowers.DATE = ALL_STATS.DATE LEFT JOIN
  (SELECT
      statistics.branch,
      DayName(statistics.datetime) AS DAY,
      Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber
    FROM
      statistics
    WHERE
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      statistics.type = 'renew'
    GROUP BY
      statistics.branch,
      DayName(statistics.datetime),
      Date_Format(statistics.datetime, '%Y-%m-%d')) renewborrowers ON
      renewborrowers.branch = branchess.branchcode AND
      renewborrowers.DATE = ALL_STATS.DATE
WHERE
  branchess.branchcode LIKE &lt;&gt;
GROUP BY
  branchess.branchname,
  ALL_STATS.DATE

























