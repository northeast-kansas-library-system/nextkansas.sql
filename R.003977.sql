/*
R.003977

----------

Name: GHW - Days, Months, Years
Created by: George Williams

----------

Group: -
     -

Created on: 2026-07-29 00:48:33
Modified on: 2026-07-29 01:16:26
Date last run: 2026-07-29 09:07:26

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  dmy.DAYS,
  dmy.MONTHS,
  dmy.YEARS,
  Count(dmy.borrowernumber) AS Count,
  Round((Count(dmy.borrowernumber) / total.Count_borrowernumber) * 100, 2) AS PERCENT
FROM
  (SELECT
     abs(round(DateDiff(Coalesce(borrowers.dateenrolled, borrowers.updated_on), Coalesce(borrowers.lastseen,
     borrowers.updated_on)), -2)) AS DAYS,
     abs(round(DateDiff(Coalesce(borrowers.dateenrolled, borrowers.updated_on), Coalesce(borrowers.lastseen,
     borrowers.updated_on)), -2)) / 30.4375 AS MONTHS,
     abs(round(DateDiff(Coalesce(borrowers.dateenrolled, borrowers.updated_on), Coalesce(borrowers.lastseen,
     borrowers.updated_on)), -2)) / 365.25 AS YEARS,
     borrowers.borrowernumber
   FROM
     borrowers) dmy,
  (SELECT
     Count(borrowers.borrowernumber) AS Count_borrowernumber
   FROM
     borrowers) total
GROUP BY
  dmy.DAYS
ORDER BY
  dmy.DAYS

























