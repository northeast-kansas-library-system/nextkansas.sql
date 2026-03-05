/*
R.003938

----------

Name: peppy
Created by: George Williams

----------

Group: -
     -

Created on: 2026-01-07 18:24:21
Modified on: 2026-01-29 14:09:02
Date last run: 2026-01-29 14:09:02

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.borrowernumber,
  borrowers.branchcode,
  CASE
    WHEN
      borrowers.dateenrolled &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1
      MONTH)), 1)
    THEN '1'
    ELSE '0'
  END AS total,
  CASE
    WHEN
      Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH)
    THEN '1'
    ELSE '0'
  END AS added_lm,
  CASE
    WHEN
      Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH)
    THEN '1'
    ELSE '0'
  END AS renewed_lm
FROM
  borrowers
GROUP BY
  borrowers.borrowernumber,
  borrowers.branchcode

























