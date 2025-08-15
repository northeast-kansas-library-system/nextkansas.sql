/*
R.003904

----------

Name: test
Created by: George Williams

----------

Group: -
     -

Created on: 2025-07-30 17:15:09
Modified on: 2025-07-30 17:15:09
Date last run: 2025-07-30 17:26:47

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
  Concat(ALL_STATS.HOUR_OF_DAY, ":00 - ", ALL_STATS.HOUR_OF_DAY, ":59") AS
  "Hour",
  Coalesce(CKO.COUNT, 0) AS "Checkouts",
  Coalesce(RENEWALS.COUNT, 0) AS "Renewals",
  Coalesce(RETURNS.COUNT, 0) AS "Returns",
  ALL_STATS.COUNT AS "Checkouts + renewals + returns"
FROM
  (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
  ) branchess 
  LEFT JOIN
  (
    SELECT
      statistics.branch,
      DayName(statistics.datetime) AS DAY,
      Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
      Hour(statistics.datetime) AS HOUR_OF_DAY,
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
      Date_Format(statistics.datetime, '%Y-%m-%d'),
      Hour(statistics.datetime)
  ) ALL_STATS 
    ON ALL_STATS.branch = branchess.branchcode 
  LEFT JOIN
  (
    SELECT
      statistics.branch,
      DayName(statistics.datetime) AS DAY,
      Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
      Hour(statistics.datetime) AS HOUR_OF_DAY,
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
      Date_Format(statistics.datetime, '%Y-%m-%d'),
      Hour(statistics.datetime)
  ) RETURNS 
    ON RETURNS.branch = branchess.branchcode AND
    RETURNS.DATE = ALL_STATS.DATE AND
    RETURNS.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
  LEFT JOIN
  (
  SELECT
      statistics.branch,
      DayName(statistics.datetime) AS DAY,
      Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
      Hour(statistics.datetime) AS HOUR_OF_DAY,
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
      Date_Format(statistics.datetime, '%Y-%m-%d'),
      Hour(statistics.datetime)
  ) CKO 
    ON CKO.branch = branchess.branchcode AND
    CKO.DATE = ALL_STATS.DATE AND
    CKO.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY 
  LEFT JOIN
  (
    SELECT
      statistics.branch,
      DayName(statistics.datetime) AS DAY,
      Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
      Hour(statistics.datetime) AS HOUR_OF_DAY,
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
      Date_Format(statistics.datetime, '%Y-%m-%d'),
      Hour(statistics.datetime)
  ) RENEWALS 
    ON RENEWALS.branch = branchess.branchcode AND
    RENEWALS.DATE = ALL_STATS.DATE AND
    RENEWALS.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY
WHERE
  branchess.branchcode LIKE &lt;&gt;
GROUP BY
  branchess.branchname,
  ALL_STATS.DATE,
  ALL_STATS.HOUR_OF_DAY
ORDER BY
  branchess.branchname,
  ALL_STATS.DATE,
  ALL_STATS.HOUR_OF_DAY

























