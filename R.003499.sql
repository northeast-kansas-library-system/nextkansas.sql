/*
R.003499

----------

Name: GHW - 9911 Monthly hourly tracker
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-04-30 15:05:03
Modified on: 2021-04-30 15:05:03
Date last run: 2021-05-01 00:55:02

----------

Public: 0
Expiry: 300

----------

Run only on as a scheduled report.  May time out if you attempt to run live.

----------
*/

SELECT
  branchess.branchname,
  ALL_STATS.DATE,
  ALL_STATS.DAY,
  Concat(ALL_STATS.HOUR_OF_DAY, ":00 - ", ALL_STATS.HOUR_OF_DAY, ":59") AS HOUR,
  Coalesce(CKO.COUNT, 0) AS CKO,
  Coalesce(RENEWALS.COUNT, 0) AS RENEW,
  Coalesce(RETURNS.COUNT, 0) AS RETURNS,
  ALL_STATS.COUNT AS TOTAL_CKO_RENEW_RETURN,
  Coalesce(ckoborrowers.Count_borrowernumber, 0) AS CKO_BORROWERS,
  Coalesce(renewborrowers.Count_borrowernumber, 0) AS RENEW_BORROWERS,
  totalborrowers.Count_borrowernumber AS CKO_AND_RENEW_BORROWERS
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
     Hour(statistics.datetime)) ALL_STATS ON ALL_STATS.branch =
      branchess.branchcode LEFT JOIN
  (SELECT
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
     Hour(statistics.datetime)) RETURNS ON RETURNS.branch = branchess.branchcode
      AND
      RETURNS.DATE = ALL_STATS.DATE AND
      RETURNS.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
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
     Hour(statistics.datetime)) CKO ON CKO.branch = branchess.branchcode AND
      CKO.DATE = ALL_STATS.DATE AND
      CKO.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
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
     Hour(statistics.datetime)) RENEWALS ON
      RENEWALS.branch = branchess.branchcode AND
      RENEWALS.DATE = ALL_STATS.DATE AND
      RENEWALS.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
     statistics.branch,
     DayName(statistics.datetime) AS DAY,
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
     Hour(statistics.datetime) AS HOUR_OF_DAY,
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
     Date_Format(statistics.datetime, '%Y-%m-%d'),
     Hour(statistics.datetime)) totalborrowers ON totalborrowers.branch =
      branchess.branchcode AND
      totalborrowers.DATE = ALL_STATS.DATE AND
      totalborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
     statistics.branch,
     DayName(statistics.datetime) AS DAY,
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
     Hour(statistics.datetime) AS HOUR_OF_DAY,
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
     Date_Format(statistics.datetime, '%Y-%m-%d'),
     Hour(statistics.datetime)) ckoborrowers ON ckoborrowers.branch =
      branchess.branchcode AND
      ckoborrowers.DATE = ALL_STATS.DATE AND
      ckoborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY LEFT JOIN
  (SELECT
     statistics.branch,
     DayName(statistics.datetime) AS DAY,
     Date_Format(statistics.datetime, '%Y-%m-%d') AS DATE,
     Hour(statistics.datetime) AS HOUR_OF_DAY,
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
     Date_Format(statistics.datetime, '%Y-%m-%d'),
     Hour(statistics.datetime)) renewborrowers ON renewborrowers.branch =
      branchess.branchcode AND
      renewborrowers.DATE = ALL_STATS.DATE AND
      renewborrowers.HOUR_OF_DAY = ALL_STATS.HOUR_OF_DAY
WHERE
  branchess.branchcode LIKE '%'
GROUP BY
  branchess.branchname,
  ALL_STATS.DATE,
  ALL_STATS.DAY,
  ALL_STATS.HOUR_OF_DAY
ORDER BY
  branchess.branchname,
  ALL_STATS.DATE,
  ALL_STATS.DAY,
  ALL_STATS.HOUR_OF_DAY



