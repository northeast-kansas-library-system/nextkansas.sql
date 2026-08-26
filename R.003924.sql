/*
R.003924

----------

Name: GHW - Looker Studio 01 - test
Created by: George Williams

----------

Group: -
     -

Created on: 2025-11-11 13:06:24
Modified on: 2025-11-12 22:43:43
Date last run: 2026-08-25 10:30:24

----------

Public: 1
Expiry: 900

----------



----------
*/



SELECT
  branches.branchname,
  Concat(Year(CurDate() - INTERVAL 1 MONTH), ' - ', MonthName(CurDate() -
  INTERVAL 1 MONTH), ' statistics') AS DATE,
  Coalesce(circulation_counts.TOTAL, 0) AS TOTAL,
  Coalesce(circulation_counts.CKO, 0) AS CKO,
  Coalesce(circulation_counts.RENEW, 0) AS RENEW,
  Coalesce(circ_by_location.ADULT, 0) AS CIRC_ADULT,
  Coalesce(circ_by_location.YOUTH, 0) AS CIRC_YOUTH,
  active_borrowers.BORROWERS_TOTAL,
  active_borrowers.BORROWERS_ADDED_LM,
  active_borrowers.BORROWERS_RENEWED_LM,
  deleted_borrowers.BORROWERS_DELETED_LAST_MONTH
FROM
  branches LEFT JOIN
  (SELECT
      statistics.branch,
      Count(CASE
        WHEN
          statistics.type = 'issue' OR statistics.type = 'renew'
        THEN 1
      END) AS TOTAL,
      Count(CASE
        WHEN
          statistics.type = 'issue'
        THEN 1
      END) AS CKO,
      Count(CASE
        WHEN
          statistics.type = 'renew'
        THEN 1
      END) AS RENEW
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch) circulation_counts ON circulation_counts.branch =
      branches.branchcode LEFT JOIN
  (SELECT
      statistics.branch,
      Count(CASE
        WHEN
          statistics.location LIKE '%AD%'
        THEN 1
      END) AS ADULT,
      Count(CASE
        WHEN
          statistics.location NOT LIKE '%AD%'
        THEN 1
      END) AS YOUTH
    FROM
      statistics
    WHERE
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew')
    GROUP BY
      statistics.branch) circ_by_location ON circ_by_location.branch =
      branches.branchcode LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(CASE
        WHEN
          borrowers.dateenrolled < AddDate(Last_Day(SubDate(Now(), INTERVAL 1
          MONTH)), 1)
        THEN 1
      END) AS BORROWERS_TOTAL,
      Count(CASE
        WHEN
          Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH) AND
          Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH)
        THEN 1
      END) AS BORROWERS_ADDED_LM,
      Count(CASE
        WHEN
          Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH) AND
          Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH)
        THEN 1
      END) AS BORROWERS_RENEWED_LM
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode) active_borrowers ON active_borrowers.branchcode =
      branches.branchcode LEFT JOIN
  (SELECT
      deletedborrowers.branchcode,
      Count(CASE
        WHEN
          Year(deletedborrowers.updated_on) = Year(Now() - INTERVAL 1 MONTH) AND
          Month(deletedborrowers.updated_on) = Month(Now() - INTERVAL 1 MONTH)
        THEN 1
      END) AS BORROWERS_DELETED_LAST_MONTH
    FROM
      deletedborrowers
    GROUP BY
      deletedborrowers.branchcode) deleted_borrowers ON
      deleted_borrowers.branchcode = branches.branchcode

























