/*
R.003500

----------

Name: GHW - Monthly 9913 - Local checkouts and renewals last month
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-05-03 00:32:33
Modified on: 2021-06-02 08:30:37
Date last run: 2021-07-02 16:12:15

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  branch_itype.branchname,
  branch_itype.description,
  Coalesce(all_local_items.Count_datetime, 0) AS ALL_LOCAL_ITEMS,
  Coalesce(all_local_adult.Count_datetime, 0) AS ALL_LOCAL_ADULT,
  Coalesce(all_local_ya.Count_datetime, 0) AS ALL_LOCAL_YA,
  Coalesce(all_local_childrens.Count_datetime, 0) AS ALL_LOCAL_CHILD,
  Coalesce(all_local_other.Count_datetime, 0) AS ALL_LOCAL_OTHER
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
      branches.branchcode LIKE '%') branch_itype LEFT JOIN
  (SELECT
      Coalesce(statistics.branch, 'NEKLS') AS branch,
      Coalesce(statistics.itemtype, 'PUNC') AS itemtype,
      Count(statistics.datetime) AS Count_datetime
    FROM
      statistics JOIN
      items ON items.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      If(
        Coalesce(statistics.branch, 'NEKLS') LIKE 'DONI%', 
        'DONI%',
        If(
          Coalesce(statistics.branch, 'NEKLS') LIKE 'PH%', 
          'PH%',
          statistics.branch
        )
      ) = 
      If(
        Coalesce(items.homebranch, 'NEKLS') LIKE 'DONI%',
        'DONI%', 
        If(
          Coalesce(items.homebranch, 'NEKLS') LIKE 'PH%', 
          'PH%',
          items.homebranch
        )
      ) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      Coalesce(statistics.branch, 'NEKLS'),
      Coalesce(statistics.itemtype, 'PUNC')) all_local_items ON
      all_local_items.branch = branch_itype.branchcode AND
      all_local_items.itemtype = branch_itype.itemtype LEFT JOIN
  (SELECT
      Coalesce(statistics.branch, 'NEKLS') AS branch,
      Coalesce(statistics.location, 'CART') AS location,
      Coalesce(statistics.itemtype, 'PUNC') AS itemtype,
      Count(statistics.datetime) AS Count_datetime
    FROM
      statistics JOIN
      items ON items.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      If(
        Coalesce(statistics.branch, 'NEKLS') LIKE 'DONI%', 
        'DONI%',
        If(
          Coalesce(statistics.branch, 'NEKLS') LIKE 'PH%', 
          'PH%',
          statistics.branch
        )
      ) = 
      If(
        Coalesce(items.homebranch, 'NEKLS') LIKE 'DONI%',
        'DONI%', 
        If(
          Coalesce(items.homebranch, 'NEKLS') LIKE 'PH%', 
          'PH%',
          items.homebranch
        )
      ) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (Coalesce(statistics.location, 'CART') = 'ADULT' OR
        Coalesce(statistics.location, 'CART') = 'BALDADULT' OR
        Coalesce(statistics.location, 'CART') = 'LVPLADULT' OR
        Coalesce(statistics.location, 'CART') = 'PAOLAADULT')
    GROUP BY
      Coalesce(statistics.branch, 'NEKLS'),
      Coalesce(statistics.location, 'CART'),
      Coalesce(statistics.itemtype, 'PUNC')) all_local_adult ON
      all_local_adult.branch = branch_itype.branchcode AND
      all_local_adult.itemtype = branch_itype.itemtype LEFT JOIN
  (SELECT
      Coalesce(statistics.branch, 'NEKLS') AS branch,
      Coalesce(statistics.location, 'CART') AS location,
      Coalesce(statistics.itemtype, 'PUNC') AS itemtype,
      Count(statistics.datetime) AS Count_datetime
    FROM
      statistics JOIN
      items ON items.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      If(
        Coalesce(statistics.branch, 'NEKLS') LIKE 'DONI%', 
        'DONI%',
        If(
          Coalesce(statistics.branch, 'NEKLS') LIKE 'PH%', 
          'PH%',
          statistics.branch
        )
      ) = 
      If(
        Coalesce(items.homebranch, 'NEKLS') LIKE 'DONI%',
        'DONI%', 
        If(
          Coalesce(items.homebranch, 'NEKLS') LIKE 'PH%', 
          'PH%',
          items.homebranch
        )
      ) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (Coalesce(statistics.location, 'CART') = 'YOUNGADULT' OR
        Coalesce(statistics.location, 'CART') LIKE '%YA%')
    GROUP BY
      Coalesce(statistics.branch, 'NEKLS'),
      Coalesce(statistics.location, 'CART'),
      Coalesce(statistics.itemtype, 'PUNC')) all_local_ya ON
      all_local_ya.branch = branch_itype.branchcode AND
      all_local_ya.itemtype = branch_itype.itemtype LEFT JOIN
  (SELECT
      Coalesce(statistics.branch, 'NEKLS') AS branch,
      Coalesce(statistics.location, 'CART') AS location,
      Coalesce(statistics.itemtype, 'PUNC') AS itemtype,
      Count(statistics.datetime) AS Count_datetime
    FROM
      statistics JOIN
      items ON items.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      If(
        Coalesce(statistics.branch, 'NEKLS') LIKE 'DONI%', 
        'DONI%',
        If(
          Coalesce(statistics.branch, 'NEKLS') LIKE 'PH%', 
          'PH%',
          statistics.branch
        )
      ) = 
      If(
        Coalesce(items.homebranch, 'NEKLS') LIKE 'DONI%',
        'DONI%', 
        If(
          Coalesce(items.homebranch, 'NEKLS') LIKE 'PH%', 
          'PH%',
          items.homebranch
        )
      ) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Coalesce(statistics.location, 'CART') LIKE '%CHILD%'
    GROUP BY
      Coalesce(statistics.branch, 'NEKLS'),
      Coalesce(statistics.location, 'CART'),
      Coalesce(statistics.itemtype, 'PUNC')) all_local_childrens ON
      all_local_childrens.branch = branch_itype.branchcode AND
      all_local_childrens.itemtype = branch_itype.itemtype LEFT JOIN
  (SELECT
      Coalesce(statistics.branch, 'NEKLS') AS branch,
      Coalesce(statistics.location, 'CART') AS location,
      Coalesce(statistics.itemtype, 'PUNC') AS itemtype,
      Count(statistics.datetime) AS Count_datetime
    FROM
      statistics JOIN
      items ON items.itemnumber = statistics.itemnumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      If(
        Coalesce(statistics.branch, 'NEKLS') LIKE 'DONI%', 
        'DONI%',
        If(
          Coalesce(statistics.branch, 'NEKLS') LIKE 'PH%', 
          'PH%',
          statistics.branch
        )
      ) = 
      If(
        Coalesce(items.homebranch, 'NEKLS') LIKE 'DONI%',
        'DONI%', 
        If(
          Coalesce(items.homebranch, 'NEKLS') LIKE 'PH%', 
          'PH%',
          items.homebranch
        )
      ) AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      Coalesce(statistics.location, 'CART') NOT LIKE '%ADULT%' AND
      Coalesce(statistics.location, 'CART') NOT LIKE '%YA%' AND
      Coalesce(statistics.location, 'CART') NOT LIKE '%CHILD%'
    GROUP BY
      Coalesce(statistics.branch, 'NEKLS'),
      Coalesce(statistics.location, 'CART'),
      Coalesce(statistics.itemtype, 'PUNC')) all_local_other ON
      all_local_other.branch = branch_itype.branchcode AND
      all_local_other.itemtype = branch_itype.itemtype
GROUP BY
  branch_itype.branchname,
  branch_itype.description
ORDER BY
  branch_itype.branchname,
  branch_itype.description



