/*
R.003419

----------

Name: GHW - Monthly 111 Monthly statistics master - Circulation
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2021-02-04 16:59:13
Modified on: 2021-10-31 21:05:14
Date last run: 2021-11-01 09:35:30

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
  branches.branchcode,
  Coalesce(CIR_RENEW_LM.count, 0) AS CHECKOUT_RENEW_LM,
  Coalesce(CKO_LM.count, 0) AS CHECKOUT_LM,
  Coalesce(RENEW_LM.count, 0) AS RENEW_LM,
  Coalesce(RETURN_LM.count, 0) AS RETURN_LM,
  Coalesce(ADULT.count, 0) AS CR_ADULT_LM,
  Coalesce(YOUTH.count, 0) AS CR_YOUTH_LM,
  Coalesce(DVD_CIRC_RENEW_LM.count, 0) AS CR_VIDEO_DISC_LM
FROM
  branches LEFT JOIN
  (SELECT
     statistics.branch,
     Count(*) AS count
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     statistics.branch) CIR_RENEW_LM ON branches.branchcode =
      CIR_RENEW_LM.branch LEFT JOIN
  (SELECT
     statistics.branch,
     Count(*) AS count
   FROM
     statistics LEFT JOIN
     items ON items.itemnumber = statistics.itemnumber
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
     If(
       Coalesce(statistics.location, "ADULT") = "CART",
       items.permanent_location, 
       Coalesce(statistics.location, "ADULT")
     ) LIKE "%ADULT%"
   GROUP BY
     statistics.branch) ADULT ON branches.branchcode = ADULT.branch LEFT JOIN
  (SELECT
     statistics.branch,
     Count(*) AS count
   FROM
     statistics LEFT JOIN
     items ON items.itemnumber = statistics.itemnumber
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
     If(
       Coalesce(statistics.location, "ADULT") = "CART",
       items.permanent_location, 
       Coalesce(statistics.location, "ADULT")
     ) NOT LIKE "%ADULT%"
   GROUP BY
     statistics.branch) YOUTH ON branches.branchcode = YOUTH.branch LEFT JOIN
  (SELECT
     statistics.branch,
     Count(*) AS count
   FROM
     statistics
   WHERE
     statistics.type = 'issue' AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     statistics.branch) CKO_LM ON CKO_LM.branch = branches.branchcode LEFT JOIN
  (SELECT
     statistics.branch,
     Count(*) AS count
   FROM
     statistics
   WHERE
     statistics.type = 'renew' AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     statistics.branch) RENEW_LM ON RENEW_LM.branch = branches.branchcode
  LEFT JOIN
  (SELECT
     statistics.branch,
     Count(*) AS count
   FROM
     statistics
   WHERE
     statistics.type = 'return' AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     statistics.branch) RETURN_LM ON RETURN_LM.branch = branches.branchcode
  LEFT JOIN
  (SELECT
     statistics.branch,
     Count(*) AS count
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
     statistics.itemtype LIKE "NVID%" AND
     (statistics.ccode LIKE "VID_B%" OR
         statistics.ccode LIKE "VID_C" OR
         statistics.ccode LIKE "VID_D" OR
         statistics.ccode LIKE "VID_M")
   GROUP BY
     statistics.branch) DVD_CIRC_RENEW_LM ON DVD_CIRC_RENEW_LM.branch =
      branches.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode

























