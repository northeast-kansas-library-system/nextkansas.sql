/*
R.003688

----------

Name: fixup
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-12-12 17:01:09
Modified on: 2022-12-12 17:01:24
Date last run: 2022-12-14 11:41:20

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  branch_itype.branchname, 
  branch_itype.description, 
  Coalesce(Sum(statistics_all.CKO_REN), 0) AS CKO_REN_ALL, 
  Coalesce(Sum(statistics_adult.CKO_REN), 0) AS CKO_REN_ADULT, 
  Coalesce(Sum(statistics_ya.CKO_REN), 0) AS CKO_REN_YA, 
  Coalesce(Sum(statistics_child.CKO_REN), 0) AS CKO_REN_CHILD, 
  Coalesce(Sum(statistics_other.CKO_REN), 0) AS CKO_REN_OTHER 
FROM 
  ( 
    SELECT 
      branches.branchname, 
      itemtypes.description, 
      branches.branchcode, 
      itemtypes.itemtype 
    FROM 
      branches, 
      itemtypes 
    WHERE 
      branches.branchcode LIKE <<Choose check-out library|ZBRAN>> 
  ) branch_itype LEFT JOIN 
  ( 
    SELECT 
      Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM 
      statistics 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
    ORDER BY 
      branch, 
      itemtype 
  ) statistics_all ON statistics_all.branch = branch_itype.branchcode AND 
    statistics_all.itemtype = branch_itype.itemtype LEFT JOIN 
  ( 
    SELECT 
      Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) LIKE "%AD%" 
    GROUP BY 
      Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
  ) statistics_adult ON statistics_adult.branch = branch_itype.branchcode AND 
    statistics_adult.itemtype = branch_itype.itemtype LEFT JOIN 
  ( 
    SELECT 
      Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) LIKE "%YA%" 
    GROUP BY 
      Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
  ) statistics_ya ON statistics_ya.branch = branch_itype.branchcode AND 
    statistics_ya.itemtype = branch_itype.itemtype LEFT JOIN 
  ( 
    SELECT 
      Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      ( 
        If( 
          Coalesce(statistics.location, "PROC") = "CART", 
          Coalesce(items.permanent_location, "PROC"), 
          Coalesce(statistics.location, "PROC") 
        ) LIKE "%CHILD%" OR 
        If( 
          Coalesce(statistics.location, "PROC") = "CART", 
          Coalesce(items.permanent_location, "PROC"), 
          Coalesce(statistics.location, "PROC") 
        ) LIKE "%JU%" 
      ) 
    GROUP BY 
      Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
  ) statistics_child ON statistics_child.branch = branch_itype.branchcode AND 
    statistics_child.itemtype = branch_itype.itemtype LEFT JOIN 
  ( 
    SELECT 
      Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%AD%" AND 
      If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%YA%" AND 
      If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%CHILD%" AND 
      If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%JU%" 
    GROUP BY 
      Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
  ) statistics_other ON statistics_other.branch = branch_itype.branchcode AND 
    statistics_other.itemtype = branch_itype.itemtype 
GROUP BY 
  branch_itype.branchname, 
  branch_itype.description 

























