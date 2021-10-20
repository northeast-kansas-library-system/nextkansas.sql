/*
R.003393

----------

Name: GHW - Monthly 210 Circulation statistics by item type
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2020-12-31 17:36:03
Modified on: 2021-07-29 17:19:53
Date last run: 2021-10-01 00:18:02

----------

Public: 0
Expiry: 300

----------

Monthly statistics - should be run on schedule only - staff at libraries should run report 3128 if they just want data for their library.

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
      branches.branchcode Like '%') branch_itype Left Join
  (SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
    ORDER BY
      branch,
      itemtype) statisticsall ON branch_itype.branchcode = statisticsall.branch
      AND
      branch_itype.itemtype = statisticsall.itemtype LEFT JOIN
  (SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      (Coalesce(statistics.location, "CART") = 'ADULT' OR
        Coalesce(statistics.location, "CART") = 'LVPLADULT' OR
        Coalesce(statistics.location, "CART") = 'PAOLAADULT' OR
        Coalesce(statistics.location, "CART") = 'BALDADULT')
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
    ORDER BY
      branch,
      itemtype) statisticsadult ON branch_itype.branchcode =
      statisticsadult.branch AND
      branch_itype.itemtype = statisticsadult.itemtype LEFT JOIN
  (SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Coalesce(statistics.location, "CART") NOT LIKE "%ADULT%" AND
      Coalesce(statistics.location, "CART") NOT LIKE "%CHILD%" AND
      Coalesce(statistics.location, "CART") NOT LIKE "%YA%"
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
    ORDER BY
      branch,
      itemtype) statisticsother ON branch_itype.branchcode =
      statisticsother.branch AND
      branch_itype.itemtype = statisticsother.itemtype LEFT JOIN
  (SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      (Coalesce(statistics.location, "CART") LIKE "%YA%" OR
        Coalesce(statistics.location, "CART") LIKE "YOUNGADULT")
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
    ORDER BY
      branch,
      itemtype) statisticsya ON statisticsya.itemtype = branch_itype.itemtype
      AND
      statisticsya.branch = branch_itype.branchcode LEFT JOIN
  (SELECT
      Coalesce(statistics.branch, "NEKLS") AS branch,
      Coalesce(statistics.itemtype, "BOOK") AS itemtype,
      Count(*) AS CKO_REN
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Coalesce(statistics.location, "CART") LIKE "%CHILD%"
    GROUP BY
      Coalesce(statistics.branch, "NEKLS"),
      Coalesce(statistics.itemtype, "BOOK")
    ORDER BY
      branch,
      itemtype) statisticschildren ON statisticschildren.itemtype =
      branch_itype.itemtype AND
      statisticschildren.branch = branch_itype.branchcode
GROUP BY
  branch_itype.branchname,
  branch_itype.description
ORDER BY
  branch_itype.branchname,
  branch_itype.description

























