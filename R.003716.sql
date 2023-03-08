/*
R.003716

----------

Name: GHW - Library quick data
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-02-24 23:38:52
Modified on: 2023-03-01 08:40:30
Date last run: 2023-03-07 14:36:57

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  branches.branchname AS 'Library',
  Coalesce(borrowers_count.Count_borrowernumber, 0) AS 'Current borrower count',
  Coalesce(biblio_count.Count_biblionumber, 0) AS 'Current title count',
  Coalesce(item_count.Count_itemnumber, 0) AS 'Current item count',
  Coalesce(cko_renew_count.cko_renew, 0) AS 'Checkouts + renewals - previous 365 days',
  Coalesce(unique_borrowers.Count_borrowernumber, 0) AS 'Unique borrowers - previous 365 days'
FROM branches
  LEFT JOIN (
    SELECT borrowers.branchcode,
      Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber
    FROM borrowers
    WHERE borrowers.branchcode LIKE <<Choose your library|ZBRAN>>
    GROUP BY borrowers.branchcode
  ) borrowers_count ON borrowers_count.branchcode = branches.branchcode
  LEFT JOIN (
    SELECT items.homebranch,
      Count(DISTINCT items.biblionumber) AS Count_biblionumber
    FROM items
    WHERE items.homebranch LIKE <<Choose your library|ZBRAN>>
    GROUP BY items.homebranch
  ) biblio_count ON biblio_count.homebranch = branches.branchcode
  LEFT JOIN (
    SELECT items.homebranch,
      Count(DISTINCT items.itemnumber) AS Count_itemnumber
    FROM items
    WHERE items.homebranch LIKE <<Choose your library|ZBRAN>>
    GROUP BY items.homebranch
  ) item_count ON item_count.homebranch = branches.branchcode
  LEFT JOIN (
    SELECT statistics.branch,
      Count(*) AS cko_renew
    FROM statistics
    WHERE (
        statistics.type = 'issue'
        OR statistics.type = 'renew'
      )
      AND statistics.datetime BETWEEN CurDate() - INTERVAL 1 YEAR
      AND CurDate()
      AND statistics.branch LIKE <<Choose your library|ZBRAN>>
    GROUP BY statistics.branch
  ) cko_renew_count ON cko_renew_count.branch = branches.branchcode
  LEFT JOIN (
    SELECT statistics.branch,
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber
    FROM statistics
    WHERE (
        statistics.type = 'issue'
        OR statistics.type = 'renew'
      )
      AND statistics.datetime BETWEEN CurDate() - INTERVAL 1 YEAR
      AND CurDate()
      AND statistics.branch LIKE <<Choose your library|ZBRAN>>
    GROUP BY statistics.branch
  ) unique_borrowers ON unique_borrowers.branch = branches.branchcode
WHERE 
  branches.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY 
  branches.branchname
ORDER BY 
  'Library'

























