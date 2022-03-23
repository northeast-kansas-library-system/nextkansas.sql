/*
R.003556

----------

Name: SANDBOX
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-09-07 12:04:47
Modified on: 2021-12-01 10:56:02
Date last run: 2021-12-01 10:58:45

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.biblionumber,
  items.itemnumber,
  items.barcode,
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
  items.onloan
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
  If(items.damaged + 0 = 0, "No", "Yes") LIKE <<Display damaged items|ZYES_NO>> AND
  If(items.itemlost + 0 = 0, "No", "Yes") LIKE <<Display lost items|ZYES_NO>> AND
  If(items.withdrawn + 0 = 0, "No", "Yes") LIKE <<Display withdrawn items|ZYES_NO>> 
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

























