/*
R.003501

----------

Name: GHW - Monthly 615 Local checkouts and renewals last month by Collection code
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2021-05-03 01:23:47
Modified on: 2021-10-31 22:28:02
Date last run: 2021-11-01 09:53:54

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
  branch_itype.lib AS CCODE,
  Coalesce(all_local_items.Count_datetime, 0) AS ALL_LOCAL_ITEMS,
  Coalesce(all_local_adult.Count_datetime, 0) AS ALL_LOCAL_ADULT,
  Coalesce(all_local_ya.Count_datetime, 0) AS ALL_LOCAL_YA,
  Coalesce(all_local_childrens.Count_datetime, 0) AS ALL_LOCAL_CHILD,
  Coalesce(all_local_other.Count_datetime, 0) AS ALL_LOCAL_OTHER
FROM
  (SELECT
     branches.branchname,
     branches.branchcode,
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib,
     authorised_values.lib_opac
   FROM
     branches,
     authorised_values
   WHERE
     branches.branchcode LIKE '%' AND
     authorised_values.category = 'CCODE') branch_itype LEFT JOIN
  (SELECT
     Coalesce(statistics.branch, 'NEKLS') AS branch,
     Coalesce(statistics.ccode, 'XXX') AS ccode,
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
     Coalesce(statistics.ccode, 'XXX')) all_local_items ON
      all_local_items.branch = branch_itype.branchcode AND
      all_local_items.ccode = branch_itype.authorised_value LEFT JOIN
  (SELECT
     Coalesce(statistics.branch, 'NEKLS') AS branch,
     Coalesce(statistics.location, 'CART') AS location,
     Coalesce(statistics.ccode, 'XXX') AS ccode,
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
     Coalesce(statistics.ccode, 'XXX')) all_local_adult ON
      all_local_adult.branch = branch_itype.branchcode AND
      all_local_adult.ccode = branch_itype.authorised_value LEFT JOIN
  (SELECT
     Coalesce(statistics.branch, 'NEKLS') AS branch,
     Coalesce(statistics.location, 'CART') AS location,
     Coalesce(statistics.ccode, 'XXX') AS ccode,
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
       If(Coalesce(statistics.branch, 'NEKLS') LIKE 'PH%', 
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
     ) LIKE "%YA%"
   GROUP BY
     Coalesce(statistics.branch, 'NEKLS'),
     Coalesce(statistics.location, 'CART'),
     Coalesce(statistics.ccode, 'XXX')) all_local_ya ON all_local_ya.branch =
      branch_itype.branchcode AND
      all_local_ya.ccode = branch_itype.authorised_value LEFT JOIN
  (SELECT
     Coalesce(statistics.branch, 'NEKLS') AS branch,
     Coalesce(statistics.location, 'CART') AS location,
     Coalesce(statistics.ccode, 'XXX') AS ccode,
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
     Coalesce(statistics.ccode, 'XXX')) all_local_childrens ON
      all_local_childrens.branch = branch_itype.branchcode AND
      all_local_childrens.ccode = branch_itype.authorised_value LEFT JOIN
  (SELECT
     Coalesce(statistics.branch, 'NEKLS') AS branch,
     Coalesce(statistics.location, 'CART') AS location,
     Coalesce(statistics.ccode, 'XXX') AS ccode,
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
     Coalesce(If(statistics.location LIKE 'CART', items.permanent_location, statistics.location), 'CART') NOT LIKE '%ADULT%' AND
     Coalesce(If(statistics.location LIKE 'CART', items.permanent_location, statistics.location), 'CART') NOT LIKE '%YA%' AND
     Coalesce(If(statistics.location LIKE 'CART', items.permanent_location, statistics.location), 'CART') NOT LIKE '%CHILD%'
   GROUP BY
     Coalesce(statistics.branch, 'NEKLS'),
     Coalesce(statistics.location, 'CART'),
     Coalesce(statistics.ccode, 'XXX')) all_local_other ON
      all_local_other.branch = branch_itype.branchcode AND
      all_local_other.ccode = branch_itype.authorised_value
GROUP BY
  branch_itype.branchname,
  branch_itype.lib
ORDER BY
  branch_itype.branchname,
  CCODE

























