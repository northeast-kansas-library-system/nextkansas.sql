/*
R.003258

----------

Name: Backtrack itypes
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-05 20:57:00
Modified on: 2019-09-06 01:39:27
Date last run: 2019-10-04 11:46:00

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branch_itype.branchname,
  branch_itype.description,
  Coalesce(statisticsall.CKO_REN, 0) AS CKO_REN_ALL,
  Coalesce(statisticsadult.CKO_REN, 0) AS CKO_REN_ADULT,
  Coalesce(statisticsya.CKO_REN, 0) AS CKO_REN_YA,
  Coalesce(statisticschildren.CKO_REN, 0) AS CKO_CHILDRENS,
  Coalesce(statisticsother.CKO_REN, 0) AS CKO_REN_OTHER
FROM
  (SELECT
      branches.branchname,
      itemtypes.description,
      branches.branchcode,
      itemtypes.itemtype
    FROM
      branches,
      itemtypes
    WHERE
      branches.branchcode LIKE <<Choose check-out library|LBRANCH>>) branch_itype
  LEFT JOIN (SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 2 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 2 MONTH)
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
    ORDER BY
      branch,
      itemtype) statisticsall ON branch_itype.branchcode = statisticsall.branch AND
    branch_itype.itemtype = statisticsall.itemtype
  LEFT JOIN (SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 2 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 2 MONTH) AND
      (Coalesce(statistics.location, "CART") = 'ADULT' OR
        Coalesce(statistics.location, "CART") = 'LVPLADULT')
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
    ORDER BY
      branch,
      itemtype) statisticsadult ON branch_itype.branchcode = statisticsadult.branch AND
    branch_itype.itemtype = statisticsadult.itemtype
  LEFT JOIN (SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 2 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 2 MONTH) AND
      Coalesce(statistics.location, "CART") <> 'ADULT' AND
      Coalesce(statistics.location, "CART") <> 'LVPLADULT' AND
      Coalesce(statistics.location, "CART") <> 'YOUNGADULT' AND
      Coalesce(statistics.location, "CART") <> 'LVPLYA' AND
      Coalesce(statistics.location, "CART") <> 'CHILDRENS' AND
      Coalesce(statistics.location, "CART") <> 'LVPLCHILD'
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
    ORDER BY
      branch,
      itemtype) statisticsother ON branch_itype.branchcode = statisticsother.branch AND
    branch_itype.itemtype = statisticsother.itemtype
  LEFT JOIN (SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 2 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 2 MONTH) AND
      (Coalesce(statistics.location, "CART") = 'YOUNGADULT' OR
        Coalesce(statistics.location, "CART") = 'LVPLYA')
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
    ORDER BY
      branch,
      itemtype) statisticsya ON statisticsya.itemtype = branch_itype.itemtype AND
    statisticsya.branch = branch_itype.branchcode
  LEFT JOIN (SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 2 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 2 MONTH) AND
      (Coalesce(statistics.location, "CART") = 'CHILDRENS' OR
        Coalesce(statistics.location, "CART") = 'LVPLCHILD')
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
    ORDER BY
      branch,
      itemtype) statisticschildren ON statisticschildren.itemtype = branch_itype.itemtype AND
    statisticschildren.branch = branch_itype.branchcode
GROUP BY
  branch_itype.branchname,
  branch_itype.description
ORDER BY
  branch_itype.branchname,
  branch_itype.description



