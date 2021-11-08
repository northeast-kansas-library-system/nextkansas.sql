/*
R.003394

----------

Name: GHW - Monthly 220 Circulation statistics by collection code
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2020-12-31 17:40:07
Modified on: 2021-10-31 22:36:11
Date last run: 2021-11-01 09:41:16

----------

Public: 0
Expiry: 300

----------

Monthly statistics - should be run on schedule only - staff at libraries should run report 3159 if they just want data for their library.

<p class="updated">SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."</p>

<p></p>
<p class="updated">Updated on 2021.10.20 to include changes based on the "Recently returned" shelving location.</p>
<p></p>

----------
*/



SELECT
  branchccodes.branchname,
  branchccodes.lib,
  Coalesce(all_lm.CKO_RENEW, "0") AS CKO_RENW_ALL,
  Coalesce(adult_lm.CKO_RENEW, "0") AS CKO_RENEW_ADULT,
  Coalesce(ya_lm.CKO_RENEW, "0") AS CKO_RENEW_YA,
  Coalesce(childrens_lm.CKO_RENEW, "0") AS CKO_RENEW_CHILDRENS,
  Coalesce(other_lm.CKO_RENEW, "0") AS CKO_RENEW_OTHER
FROM
  (SELECT
     branches.branchcode,
     authorised_values.authorised_value,
     authorised_values.lib,
     branches.branchname
   FROM
     branches,
     authorised_values
   WHERE
     authorised_values.category = 'CCODE'
   ORDER BY
     branches.branchcode,
     authorised_values.lib) branchccodes LEFT JOIN
  (SELECT
     If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
     Count(*) AS CKO_RENEW,
     If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
   FROM
     statistics
   WHERE
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
     (statistics.type = 'issue' OR
         statistics.type = 'renew')
   GROUP BY
     If(statistics.branch IS NULL, "NEKLS", statistics.branch),
     If(statistics.ccode IS NULL, "XXX", statistics.ccode)) all_lm ON
      all_lm.branch = branchccodes.branchcode AND
      all_lm.CCODE = branchccodes.authorised_value LEFT JOIN
  (SELECT
     If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
     Count(*) AS CKO_RENEW,
     If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
   FROM
     statistics LEFT JOIN
     items ON items.itemnumber = statistics.itemnumber
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     If(
       Coalesce(statistics.location, "ADULT") = "CART", 
       items.permanent_location, 
       Coalesce(statistics.location, "ADULT")
     ) LIKE "%ADULT%"
   GROUP BY
     If(statistics.branch IS NULL, "NEKLS", statistics.branch),
     If(statistics.ccode IS NULL, "XXX", statistics.ccode)) adult_lm ON
      adult_lm.branch = branchccodes.branchcode AND
      adult_lm.CCODE = branchccodes.authorised_value LEFT JOIN
  (SELECT
     If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
     Count(*) AS CKO_RENEW,
     If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
   FROM
     statistics LEFT JOIN
     items ON items.itemnumber = statistics.itemnumber
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     If(
       Coalesce(statistics.location, "ADULT") = "CART", 
       items.permanent_location, 
       Coalesce(statistics.location, "ADULT")
     ) LIKE "%YA%"
   GROUP BY
     If(statistics.branch IS NULL, "NEKLS", statistics.branch),
     If(statistics.ccode IS NULL, "XXX", statistics.ccode)) ya_lm ON
      ya_lm.branch = branchccodes.branchcode AND
      ya_lm.CCODE = branchccodes.authorised_value LEFT JOIN
  (SELECT
     If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
     Count(*) AS CKO_RENEW,
     If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
   FROM
     statistics LEFT JOIN
     items ON items.itemnumber = statistics.itemnumber
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     If(
       Coalesce(statistics.location, "ADULT") = "CART", 
       items.permanent_location, 
       Coalesce(statistics.location, "ADULT")
     ) LIKE "%CHILDRENS%"
   GROUP BY
     If(statistics.branch IS NULL, "NEKLS", statistics.branch),
     If(statistics.ccode IS NULL, "XXX", statistics.ccode)) childrens_lm ON
      childrens_lm.branch = branchccodes.branchcode AND
      childrens_lm.CCODE = branchccodes.authorised_value LEFT JOIN
  (SELECT
     If(statistics.branch IS NULL, "NEKLS", statistics.branch) AS branch,
     Count(*) AS CKO_RENEW,
     If(statistics.ccode IS NULL, "XXX", statistics.ccode) AS CCODE
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
     If(statistics.branch IS NULL, "NEKLS", statistics.branch),
     If(statistics.ccode IS NULL, "XXX", statistics.ccode)) other_lm ON
      other_lm.branch = branchccodes.branchcode AND
      other_lm.CCODE = branchccodes.authorised_value
WHERE
  branchccodes.branchcode LIKE '%'
ORDER BY
  branchccodes.branchname,
  branchccodes.lib

























