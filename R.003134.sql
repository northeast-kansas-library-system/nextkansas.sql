/*
R.003134

----------

Name: GHW - Monthly stats by date
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-11-01 11:08:27
Modified on: 2018-12-08 22:58:14
Date last run: 2021-12-14 15:21:16

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  dates.DATE,
  dates.DAY,
  Coalesce(ckorenew.branch, Coalesce(returns.branch, Coalesce(uniquepatrons.branch, Coalesce(patronsadded.branchcode, Coalesce(nextshipped.frombranch, Coalesce(nextreceived.tobranch, "-")))))) AS BRANCH,
  ckorenew.CKO_RENEW,
  returns.CKI,
  uniquepatrons.UNIQUE_PATRONS,
  patronsadded.PATRONS_ADDED,
  nextshipped.SHIPPED_TO_NEXT,
  nextreceived.ARRIVED_FROM_NEXT
FROM
    (SELECT
        CurDate() - INTERVAL 65 DAY AS DATE,
        Date_Format(CurDate() - INTERVAL 65 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 64 DAY,
        Date_Format(CurDate() - INTERVAL 64 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 63 DAY,
        Date_Format(CurDate() - INTERVAL 63 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 62 DAY,
        Date_Format(CurDate() - INTERVAL 62 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 61 DAY,
        Date_Format(CurDate() - INTERVAL 61 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 60 DAY,
        Date_Format(CurDate() - INTERVAL 60 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 59 DAY,
        Date_Format(CurDate() - INTERVAL 59 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 58 DAY,
        Date_Format(CurDate() - INTERVAL 58 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 57 DAY,
        Date_Format(CurDate() - INTERVAL 57 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 56 DAY,
        Date_Format(CurDate() - INTERVAL 56 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 55 DAY,
        Date_Format(CurDate() - INTERVAL 55 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 54 DAY,
        Date_Format(CurDate() - INTERVAL 54 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 53 DAY,
        Date_Format(CurDate() - INTERVAL 53 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 52 DAY,
        Date_Format(CurDate() - INTERVAL 52 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 51 DAY,
        Date_Format(CurDate() - INTERVAL 51 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 50 DAY,
        Date_Format(CurDate() - INTERVAL 50 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 49 DAY,
        Date_Format(CurDate() - INTERVAL 49 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 48 DAY,
        Date_Format(CurDate() - INTERVAL 48 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 47 DAY,
        Date_Format(CurDate() - INTERVAL 47 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 46 DAY,
        Date_Format(CurDate() - INTERVAL 46 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 45 DAY,
        Date_Format(CurDate() - INTERVAL 45 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 44 DAY,
        Date_Format(CurDate() - INTERVAL 44 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 43 DAY,
        Date_Format(CurDate() - INTERVAL 43 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 42 DAY,
        Date_Format(CurDate() - INTERVAL 42 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 41 DAY,
        Date_Format(CurDate() - INTERVAL 41 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 40 DAY,
        Date_Format(CurDate() - INTERVAL 40 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 39 DAY,
        Date_Format(CurDate() - INTERVAL 39 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 38 DAY,
        Date_Format(CurDate() - INTERVAL 38 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 37 DAY,
        Date_Format(CurDate() - INTERVAL 37 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 36 DAY,
        Date_Format(CurDate() - INTERVAL 36 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 35 DAY,
        Date_Format(CurDate() - INTERVAL 35 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 34 DAY,
        Date_Format(CurDate() - INTERVAL 34 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 33 DAY,
        Date_Format(CurDate() - INTERVAL 33 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 32 DAY,
        Date_Format(CurDate() - INTERVAL 32 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 31 DAY,
        Date_Format(CurDate() - INTERVAL 31 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 30 DAY,
        Date_Format(CurDate() - INTERVAL 30 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 29 DAY,
        Date_Format(CurDate() - INTERVAL 29 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 28 DAY,
        Date_Format(CurDate() - INTERVAL 28 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 27 DAY,
        Date_Format(CurDate() - INTERVAL 27 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 26 DAY,
        Date_Format(CurDate() - INTERVAL 26 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 25 DAY,
        Date_Format(CurDate() - INTERVAL 25 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 24 DAY,
        Date_Format(CurDate() - INTERVAL 24 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 23 DAY,
        Date_Format(CurDate() - INTERVAL 23 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 22 DAY,
        Date_Format(CurDate() - INTERVAL 22 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 21 DAY,
        Date_Format(CurDate() - INTERVAL 21 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 20 DAY,
        Date_Format(CurDate() - INTERVAL 20 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 19 DAY,
        Date_Format(CurDate() - INTERVAL 19 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 18 DAY,
        Date_Format(CurDate() - INTERVAL 18 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 17 DAY,
        Date_Format(CurDate() - INTERVAL 17 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 16 DAY,
        Date_Format(CurDate() - INTERVAL 16 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 15 DAY,
        Date_Format(CurDate() - INTERVAL 15 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 14 DAY,
        Date_Format(CurDate() - INTERVAL 14 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 13 DAY,
        Date_Format(CurDate() - INTERVAL 13 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 12 DAY,
        Date_Format(CurDate() - INTERVAL 12 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 11 DAY,
        Date_Format(CurDate() - INTERVAL 11 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 10 DAY,
        Date_Format(CurDate() - INTERVAL 10 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 9 DAY,
        Date_Format(CurDate() - INTERVAL 9 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 8 DAY,
        Date_Format(CurDate() - INTERVAL 8 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 7 DAY,
        Date_Format(CurDate() - INTERVAL 7 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 6 DAY,
        Date_Format(CurDate() - INTERVAL 6 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 5 DAY,
        Date_Format(CurDate() - INTERVAL 5 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 4 DAY,
        Date_Format(CurDate() - INTERVAL 4 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 3 DAY,
        Date_Format(CurDate() - INTERVAL 3 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 2 DAY,
        Date_Format(CurDate() - INTERVAL 2 DAY, "%W") AS DAY
      UNION
      SELECT
        CurDate() - INTERVAL 1 DAY,
        Date_Format(CurDate() - INTERVAL 1 DAY, "%W") AS DAY) dates
  LEFT JOIN (SELECT
        statistics.branch,
        CAST(statistics.datetime AS DATE) AS DATE,
        Count(*) AS CKO_RENEW
      FROM
        statistics
      WHERE
        Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
        (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
        (statistics.branch = @brn := <<Choose your library|branches>> COLLATE utf8mb4_unicode_ci)
      GROUP BY
        statistics.branch,
        CAST(statistics.datetime AS DATE)) ckorenew ON dates.DATE = ckorenew.DATE
  LEFT JOIN (SELECT
        statistics.branch,
        CAST(statistics.datetime AS DATE) AS DATE,
        Count(*) AS CKI
      FROM
        statistics
      WHERE
        Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
        statistics.type = 'return' AND
        statistics.branch = @brn
      GROUP BY
        statistics.branch,
        CAST(statistics.datetime AS DATE)) returns ON dates.DATE = returns.DATE
  LEFT JOIN (SELECT
        statistics.branch,
        CAST(statistics.datetime AS DATE) AS DATE,
        Count(DISTINCT statistics.borrowernumber) AS UNIQUE_PATRONS
      FROM
        statistics
      WHERE
        Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
        statistics.branch = @brn AND
        (statistics.type = 'issue' OR
          statistics.type = 'renew')
      GROUP BY
        statistics.branch,
        CAST(statistics.datetime AS DATE)) uniquepatrons ON dates.DATE = uniquepatrons.DATE
  LEFT JOIN (SELECT
        Count(borrowers.borrowernumber) AS PATRONS_ADDED,
        borrowers.branchcode,
        borrowers.dateenrolled
      FROM
        borrowers
      WHERE
        borrowers.branchcode = @brn AND
        Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH)
      GROUP BY
        borrowers.branchcode,
        borrowers.dateenrolled) patronsadded ON dates.DATE = patronsadded.dateenrolled
  LEFT JOIN (SELECT
        branchtransfers.frombranch,
        CAST(branchtransfers.datesent AS DATE) AS datesent,
        Count(branchtransfers.branchtransfer_id) AS SHIPPED_TO_NEXT
      FROM
        branchtransfers
      WHERE
        branchtransfers.frombranch = @brn AND
        Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH)
      GROUP BY
        branchtransfers.frombranch,
        CAST(branchtransfers.datesent AS DATE)) nextshipped ON dates.DATE = nextshipped.datesent
  LEFT JOIN (SELECT
        branchtransfers.tobranch,
        CAST(branchtransfers.datearrived AS DATE) AS datearrived,
        Count(branchtransfers.branchtransfer_id) AS ARRIVED_FROM_NEXT
      FROM
        branchtransfers
      WHERE
        Month(branchtransfers.datearrived) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(branchtransfers.datearrived) = Year(Now() - INTERVAL 1 MONTH) AND
        branchtransfers.tobranch = @brn
      GROUP BY
        branchtransfers.tobranch,
        CAST(branchtransfers.datearrived AS DATE)) nextreceived ON dates.DATE = nextreceived.datearrived
WHERE
  Month(dates.DATE) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(dates.DATE) = Year(Now() - INTERVAL 1 MONTH)
ORDER BY
  dates.DATE
  LIMIT 500

























