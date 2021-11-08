/*
R.002806

----------

Name: GHW - Circulation statistics for locally owned items by date range
Created by: George H Williams

----------

Group: Statistics
     Date range

Created on: 2016-10-13 16:32:19
Modified on: 2021-10-20 12:30:11
Date last run: 2021-11-06 08:51:27

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo class=noprint>
<p>Counts circulation (check-outs, renewals, and local use) of items checked out at a library that were owned by that library</p>
<ul><li>Counts circulation during the date range you specify</li>
<li>At the library you specify</li>
<li>grouped and sorted by item type, collection code, and shelving location code</li>
<li>Does not count items checked out to "Inhouse" accounts</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p class="updated">SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."</p>
<p></p>
<p>Updated on 2020.01.06 to reflect changes in the database structure</p>
<p class="updated">Updated on 2021.10.20 to include changes based on the "Recently returned" shelving location.</p>
<p class= "notetags" style="display: none;">#statistics #circulation #permanent_location</p>
</div>

----------
*/



SELECT
  branches.branchname,
  Coalesce(
    If(locs.lib = "Recently returned", itemss.lib, locs.lib), 
    " Adult"
  ) AS LOCATION,
  Coalesce(itemtypes.description, "(UNCLASSIFIED)") AS ITEM_TYPE,
  Coalesce(ccodes.lib, "Fiction") AS CCODE,
  Count(*) AS CKO_RENEW_COUNT
FROM
  statistics JOIN
  branches ON branches.branchcode = statistics.branch LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      statistics.location JOIN
  (SELECT
      items.itemnumber,
      ilocs.lib,
      items.homebranch
    FROM
      items LEFT JOIN
      (SELECT
          authorised_values.category,
          authorised_values.authorised_value,
          authorised_values.lib,
          authorised_values.lib_opac
        FROM
          authorised_values
        WHERE
          authorised_values.category = 'LOC') ilocs ON ilocs.authorised_value =
          items.permanent_location
    WHERE
      items.homebranch LIKE <<Choose your library|LBRANCH>>
    UNION
    SELECT
      deleteditems.itemnumber,
      dilocs.lib,
      deleteditems.homebranch
    FROM
      deleteditems LEFT JOIN
      (SELECT
          authorised_values.category,
          authorised_values.authorised_value,
          authorised_values.lib,
          authorised_values.lib_opac
        FROM
          authorised_values
        WHERE
          authorised_values.category = 'LOC') dilocs ON
          dilocs.authorised_value = deleteditems.permanent_location
    WHERE
      deleteditems.homebranch LIKE <<Choose your library|LBRANCH>>) itemss ON itemss.itemnumber =
      statistics.itemnumber LEFT JOIN
  itemtypes ON itemtypes.itemtype = statistics.itemtype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') ccodes ON ccodes.authorised_value =
      statistics.ccode INNER JOIN
  (SELECT
      borrowers.borrowernumber,
      borrowers.categorycode,
      borrowers.branchcode
    FROM
      borrowers
    WHERE
      borrowers.categorycode <> 'INHOUSE'
    UNION
    SELECT
      deletedborrowers.borrowernumber,
      deletedborrowers.categorycode,
      deletedborrowers.branchcode
    FROM
      deletedborrowers
    WHERE
      deletedborrowers.categorycode <> 'INHOUSE') borrowerss ON
      borrowerss.borrowernumber = statistics.borrowernumber
WHERE
  statistics.branch LIKE <<Choose your library|LBRANCH>> AND
  (statistics.type = 'issue' OR
    statistics.type = 'renew' OR
    statistics.type = 'localuse') AND
  statistics.datetime BETWEEN 
    (<<Between the beginning of the day on|date>>) AND 
    (<<and the end of the day on|date>> + INTERVAL 1 DAY)
GROUP BY
  branches.branchname,
  Coalesce(If(locs.lib = "Recently returned", itemss.lib, locs.lib), " Adult"),
  Coalesce(itemtypes.description, "(UNCLASSIFIED)"),
  Coalesce(ccodes.lib, "Fiction")
ORDER BY
  branches.branchname,
  LOCATION,
  ITEM_TYPE,
  CCODE

























