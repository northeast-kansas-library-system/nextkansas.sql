/*
R.003716

----------

Name: GHW - Library quick statistics
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-02-24 23:38:52
Modified on: 2023-03-28 15:54:25
Date last run: 2023-05-23 11:26:43

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches.branchname,
  'Current borrowers' AS STATISTIC,
  coalesce(Count(DISTINCT borrowers.borrowernumber), 0) AS Count
FROM
  branches LEFT JOIN
  borrowers ON borrowers.branchcode = branches.branchcode
WHERE
  branches.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branches.branchname
UNION
SELECT
  branches.branchname,
  'Current titles' AS STATISTIC,
  coalesce(Count(DISTINCT items.biblionumber), 0) AS Count_biblionumber
FROM
  branches LEFT JOIN
  items ON items.homebranch = branches.branchcode
WHERE
  branches.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branches.branchname
UNION
SELECT
  branches.branchname,
  'Current items' AS STATISTIC,
  coalesce(Count(DISTINCT items.itemnumber), 0) AS Count_itemnumber
FROM
  branches LEFT JOIN
  items ON items.homebranch = branches.branchcode
WHERE
  branches.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branches.branchname
UNION
SELECT
  branches.branchname,
  'Checkouts + renewals - previous 365 days' AS STATISTIC,
  coalesce(Count(*), 0)
FROM
  branches LEFT JOIN
  statistics ON statistics.branch = branches.branchcode
WHERE
  branches.branchcode LIKE <<Choose your library|ZBRAN>> AND
  (statistics.type = 'issue' OR
    statistics.type = 'renew') AND
  statistics.datetime BETWEEN CurDate() - INTERVAL 1 YEAR AND CurDate()
GROUP BY
  branches.branchname
UNION
SELECT
  branches.branchname,
  'Unique borrowers - previous 365 days' AS STATISTIC,
  coalesce(Count(DISTINCT statistics.borrowernumber), 0) AS Count_borrowernumber
FROM
  branches LEFT JOIN
  statistics ON statistics.branch = branches.branchcode
WHERE
  branches.branchcode LIKE <<Choose your library|ZBRAN>> AND
  (statistics.type = 'issue' OR
    statistics.type = 'renew') AND
  statistics.datetime BETWEEN CurDate() - INTERVAL 1 YEAR AND CurDate()
GROUP BY
  branches.branchname
ORDER BY
  branchname

























