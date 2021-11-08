/*
R.003500

----------

Name: GHW - Monthly 610 Local checkouts and renewals last month by Item type
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2021-05-03 00:32:33
Modified on: 2021-10-31 22:09:29
Date last run: 2021-10-31 21:59:14

----------

Public: 0
Expiry: 300

----------

<p class="updated">SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."</p>

<p></p>
<p class="updated">Updated on 2021.10.20 to include changes based on the "Recently returned" shelving location.</p>
<p></p>

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
     ) = If(
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
     ) = If(
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
     If(
       Coalesce(statistics.location, "ADULT") = "CART", 
       items.permanent_location, 
       Coalesce(statistics.location, "ADULT")
     ) LIKE "%ADULT%"
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
         statistics.branch)
       ) = If(
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
     If(
       Coalesce(statistics.location, "ADULT") = "CART", 
       items.permanent_location, 
       Coalesce(statistics.location, "ADULT")
     ) LIKE "%YA%"
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
     ) = If(
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
     If(
       Coalesce(statistics.location, "ADULT") = "CART", 
       items.permanent_location, 
       Coalesce(statistics.location, "ADULT")
     ) LIKE "%CHILD%"
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
     ) = If(
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

























