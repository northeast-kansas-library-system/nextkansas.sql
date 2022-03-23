/*
R.003646

----------

Name: GHW - Circulation and renewal count by library, location, item type, and collection code.
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-02-06 01:06:29
Modified on: 2022-03-09 16:06:04
Date last run: 2022-03-21 14:19:07

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Circulation and renewal count by library, location, item type, and collection code.</p>
<ul><li>Shows circulation in the month you specify (limited to the previous 25 months)</li>
<li>at the library you specify</li>
<li>grouped by circulating library, location, item type, and collection code</li>
<li>sorted by circulating library, item type, and collection code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Replaces reports:</p>
<ul>
<li>1930</li>
<li>3165</li>
</ul>
<p></p>
<p class= "notetags" style="display: none;">#circ_count_by_library #circ_count_by_itype #circ_count_by_ccode #circ_count_by_location</p>
</div>

----------
*/



SELECT
  branches.branchname,
  itemtypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  Coalesce(Sum(DISTINCT all_counts.count), 0) AS ALL_CKO_RENEW,
  Coalesce(Sum(DISTINCT adult.count), 0) AS ADULT,
  Coalesce(Sum(DISTINCT children.count), 0) AS CHILDRENS,
  Coalesce(Sum(DISTINCT young_adult.count), 0) AS YA,
  Coalesce(Sum(DISTINCT all_counts.count), 0) - 
    (Coalesce(Sum(DISTINCT adult.count), 0) +
    Coalesce(Sum(DISTINCT children.count), 0) +
    Coalesce(Sum(DISTINCT young_adult.count), 0)
  ) AS OTHER
FROM
  branches JOIN
  (SELECT
     statistics.branch,
     statistics.itemtype,
     statistics.ccode,
     Count(*) AS count
   FROM
     statistics
   WHERE
     statistics.branch LIKE <<branch|ZBRAN>> AND
     statistics.type IN ('issue', 'renew') AND
     Year(statistics.datetime) = <<Choose year|Year>> AND
     Month(statistics.datetime)= <<Choose month|Month>> 
   GROUP BY
     statistics.branch,
     statistics.itemtype,
     statistics.ccode) all_counts ON all_counts.branch = branches.branchcode
  LEFT JOIN
  (SELECT
     statistics.branch,
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ) AS LOC,
     statistics.itemtype,
     statistics.ccode,
     Count(*) AS count
   FROM
     statistics LEFT JOIN
     items ON items.itemnumber = statistics.itemnumber LEFT JOIN
     deleteditems ON deleteditems.itemnumber = statistics.itemnumber
   WHERE
     statistics.branch LIKE <<branch|ZBRAN>> AND
     statistics.type IN ('issue', 'renew') AND
     Month(statistics.datetime)= <<Choose month|Month>> AND
     Year(statistics.datetime) = <<Choose year|Year>> AND
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ) LIKE "%ADULT%"
   GROUP BY
     statistics.branch,
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ),
     statistics.itemtype,
     statistics.ccode) adult ON adult.branch = all_counts.branch AND
      adult.ccode = all_counts.ccode AND
      adult.itemtype = all_counts.itemtype LEFT JOIN
  (SELECT
     statistics.branch,
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ) AS LOC,
     statistics.itemtype,
     statistics.ccode,
     Count(*) AS count
   FROM
     statistics LEFT JOIN
     items ON items.itemnumber = statistics.itemnumber LEFT JOIN
     deleteditems ON deleteditems.itemnumber = statistics.itemnumber
   WHERE
     statistics.branch LIKE <<branch|ZBRAN>> AND
     statistics.type IN ('issue', 'renew') AND
     Month(statistics.datetime)= <<Choose month|Month>> AND
     Year(statistics.datetime) = <<Choose year|Year>> AND
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ) LIKE "%CHILD%"
   GROUP BY
     statistics.branch,
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ),
     statistics.itemtype,
     statistics.ccode) children ON children.branch = all_counts.branch AND
      children.itemtype = all_counts.itemtype AND
      children.ccode = all_counts.ccode LEFT JOIN
  (SELECT
     statistics.branch,
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ) AS LOC,
     statistics.itemtype,
     statistics.ccode,
     Count(*) AS count
   FROM
     statistics LEFT JOIN
     items ON items.itemnumber = statistics.itemnumber LEFT JOIN
     deleteditems ON deleteditems.itemnumber = statistics.itemnumber
   WHERE
     statistics.branch LIKE <<branch|ZBRAN>> AND
     statistics.type IN ('issue', 'renew') AND
     Month(statistics.datetime)= <<Choose month|Month>> AND
     Year(statistics.datetime) = <<Choose year|Year>> AND
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ) LIKE "%YA%"
   GROUP BY
     statistics.branch,
     If(statistics.location = "CART", 
       Coalesce(items.permanent_location, deleteditems.permanent_location), 
       statistics.location
     ),
     statistics.itemtype,
     statistics.ccode) young_adult ON young_adult.branch = all_counts.branch AND
      young_adult.itemtype = all_counts.itemtype AND
      young_adult.ccode = all_counts.ccode LEFT JOIN
  itemtypes ON itemtypes.itemtype = all_counts.itemtype LEFT JOIN
  (SELECT
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib,
     authorised_values.lib_opac
   FROM
     authorised_values
   WHERE
     authorised_values.category = 'CCODE') ccodes 
     ON ccodes.authorised_value = all_counts.ccode
GROUP BY
  branches.branchname,
  itemtypes.description,
  ccodes.lib
ORDER BY
  branches.branchname,
  ITYPE,
  CCODE

























