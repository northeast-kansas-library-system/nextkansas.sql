/*
R.003626

----------

Name: GHW - All items with a Damaged, Lost, or Withdrawn status at a library
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-12-01 11:00:54
Modified on: 2021-12-01 11:11:53
Date last run: 2021-12-06 20:16:00

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Lists all Damaged, Lost, or Withdrawn items at a library</p>
<ul><li>shows items that have those statuses at the time the report is run</li>
<li>at the library you specify</li>
<li>biblionumber and item number</li>
<li>Library, shelving location, item type, collection code, call number, author, and title.</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p>When presented with the options:</p>
<ul>
<li>List only damaged items</li>
<li>List only lost items</li>
<li>List only withdrawn items</li>
</ul>
<p>you should only select 1 and leave the others at their defaults.  If you choose "List only damaged items: Yes" and "List only lost items: Yes" you will only see items that are both damaged and lost.</p>
</div>

----------
*/



SELECT
  Concat(
    '<a class="btn btn-default noprint" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    items.biblionumber, 
    '\" target="_blank">Go to title</a>'
  ) AS LINK_TO_TITLE,
  items.itemnumber,
  Concat("-", items.barcode, "-") AS BARCODE,
  items.homebranch,
  If(
    items.permanent_location = items.location, 
    permlocs.lib, 
    Concat_Ws(" ", permlocs.lib, " (", locs.lib, ")")
  ) AS LOCATION,
  itemtypess.description AS ITYPE,
  ccodes.lib AS CCODE,
  If(items.copynumber IS NULL, items.itemcallnumber, Concat_Ws("", items.itemcallnumber, " (copy: ", items.copynumber, ")")) AS CALL_NUMBER,
  biblio.author,
  Concat_Ws(" ", biblio.title, biblio.medium, biblio.subtitle, biblioitems.number, biblio.part_name) AS FULL_TITLE,
  nfl.lib AS NOT_FOR_LOAN,
  If(items.damaged_on IS NULL, damageds.lib, Concat_Ws("", damageds.lib, " on ", items.damaged_on)) AS DAMAGED,
  If(items.itemlost_on IS NULL, losts.lib, Concat_Ws("", losts.lib, " on ", items.itemlost_on)) AS LOST,
  If(items.withdrawn_on IS NULL, withdrawns.lib, Concat_Ws("", withdrawns.lib, " on ", items.withdrawn_on)) AS WITHDRAWN,
  items.onloan,
  Concat(
    '<a class="btn btn-default noprint" href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', 
    items.biblionumber, 
    '&itemnumber=', 
    items.itemnumber, 
    '#edititem\" target="_blank">Edit item</a>'
  ) AS EDIT_ITEM
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblioitems ON biblioitems.biblionumber = items.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.imageurl
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') permlocs ON
      permlocs.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.imageurl
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      items.location LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itemtypess ON itemtypess.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.imageurl
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') ccodes ON ccodes.authorised_value =
      items.ccode LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.imageurl
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN') nfl ON nfl.authorised_value =
      items.notforloan LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.imageurl
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED') damageds ON
      damageds.authorised_value = items.damaged LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.imageurl
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST') losts ON losts.authorised_value =
      items.itemlost LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.imageurl
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN') withdrawns ON
      withdrawns.authorised_value = items.withdrawn
WHERE
  items.homebranch LIKE <<Choose your library|LBRANCH>> AND
  If(items.damaged + 0 = 0, "No", "Yes") LIKE <<List only damaged items|ZYES_NO>> AND
  If(items.itemlost + 0 = 0, "No", "Yes") LIKE <<List only lost items|ZYES_NO>> AND
  If(items.withdrawn + 0 = 0, "No", "Yes") LIKE <<List only withdrawn items|ZYES_NO>> 
GROUP BY
  items.biblionumber,
  items.itemnumber
ORDER BY
  items.homebranch,
  permlocs.lib,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE

























