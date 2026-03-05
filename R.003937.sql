/*
R.003937

----------

Name: 0150 - cko_by_owning_library
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2026-01-07 17:01:05
Modified on: 2026-01-07 17:25:23
Date last run: 2026-01-29 14:09:20

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  'Items checked out at' AS 'Items checked out at', 
  'Items owned by' AS 'Items owned by',
  'Total circulation' AS 'Total circulation',
  'Adult item circulation' AS 'Adult item circulation',
  'Young adult item circulation' AS 'Young adult item circulation',
  'Childrens item circulation' AS 'Childrens item circulation',
  'Other items circulation' AS 'Other items circulation'
UNION
SELECT
  branchess.transacting,
  branchess.owning,
  Coalesce(totals.CIRCS, 0) AS TOTAL,
  Coalesce(adult.CIRCS, 0) AS ADULT,
  Coalesce(young_adult.CIRCS, 0) AS YOUNG_ADULT,
  Coalesce(childrens.CIRCS, 0) AS CHILDRENS,
  Coalesce(other.CIRCS, 0) AS OTHER
FROM
  (
    SELECT
      transacting.branchname AS transacting,
      owning.branchname AS owning,
      Concat_Ws('', transacting.branchcode, owning.branchcode) AS code
    FROM
      branches transacting,
      branches owning
  ) branchess 
  LEFT JOIN
  (
    SELECT
      Concat_Ws('', 
        statistics.branch, 
        Coalesce(items.homebranch, deleteditems.homebranch, 'NEKLS')
      ) AS code,
      count(&ast;) AS CIRCS
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN
      deleteditems ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      Concat_Ws('', 
        statistics.branch, 
        Coalesce(items.homebranch, deleteditems.homebranch, 'NEKLS')
      )
  ) totals 
      ON totals.code = branchess.code
  LEFT JOIN
  (
    SELECT
      Concat_Ws('', 
        statistics.branch, 
        Coalesce(items.homebranch, deleteditems.homebranch, 'NEKLS')
      ) AS code,
      count(&ast;) AS CIRCS
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN
      deleteditems ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      statistics.location LIKE '%AD%'
    GROUP BY
      Concat_Ws('', 
        statistics.branch, 
        Coalesce(items.homebranch, deleteditems.homebranch, 'NEKLS')
      )
  ) adult 
    ON adult.code = branchess.code
  LEFT JOIN
  (
    SELECT
      Concat_Ws('', 
        statistics.branch, 
        Coalesce(items.homebranch, deleteditems.homebranch, 'NEKLS')
      ) AS code,
      count(&ast;) AS CIRCS
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN
      deleteditems ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      statistics.location LIKE '%YA%'
    GROUP BY
      Concat_Ws('', 
        statistics.branch, 
        Coalesce(items.homebranch, deleteditems.homebranch, 'NEKLS')
      )
  ) young_adult 
    ON young_adult.code = branchess.code 
  LEFT JOIN
  (
    SELECT
      Concat_Ws('', 
        statistics.branch, 
        Coalesce(items.homebranch, deleteditems.homebranch, 'NEKLS')
      ) AS code,
      count(&ast;) AS CIRCS
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN
      deleteditems ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      statistics.location LIKE '%JU%'
    GROUP BY
      Concat_Ws('', 
        statistics.branch, 
        Coalesce(items.homebranch, deleteditems.homebranch, 'NEKLS')
      )
  ) childrens 
    ON childrens.code = branchess.code 
  LEFT JOIN
  (
    SELECT
      Concat_Ws('', 
        statistics.branch, 
        Coalesce(items.homebranch, deleteditems.homebranch, 'NEKLS')
      ) AS code,
      count(&ast;) AS CIRCS
    FROM
      statistics LEFT JOIN
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN
      deleteditems ON deleteditems.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      statistics.location NOT LIKE '%AD%' AND
      statistics.location NOT LIKE '%YA%' AND
      statistics.location NOT LIKE '%JU%'
    GROUP BY
      Concat_Ws('', 
        statistics.branch, 
        Coalesce(items.homebranch, deleteditems.homebranch, 'NEKLS')
      )
  ) other 
    ON other.code = branchess.code
GROUP BY
  branchess.transacting,
  branchess.owning

























