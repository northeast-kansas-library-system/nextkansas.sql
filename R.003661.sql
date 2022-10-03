/*
R.003661

----------

Name: Item numbers and barcodes by library/location/itype/ccode
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-05-16 16:05:33
Modified on: 2022-05-16 16:44:18
Date last run: 2022-09-30 14:49:46

----------

Public: 0
Expiry: 300

----------

Replaces report 2664

----------
*/



SELECT
  items.itemnumber,
  items.barcode,
  branches.branchname AS LIBRARY,
  perm_locs.lib AS LOCATION,
  itypes.description AS ITEM_TYPE,
  ccodes.lib AS CCODE,
  items.dateaccessioned AS ADDED
FROM
  items JOIN
  branches ON items.homebranch = branches.branchcode LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypes ON itypes.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') perm_locs ON
      perm_locs.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') ccodes ON ccodes.authorised_value =
      items.ccode
WHERE
  items.homebranch LIKE <<Choose a library|LBRANCH>> AND
  items.permanent_location LIKE <<Shelving location|LLOC>> AND
  items.itype LIKE <<Choose an item type|LITYPES>> AND
  items.ccode LIKE <<Choose a collection code|LCCODE>> AND
  items.dateaccessioned BETWEEN <<Added between date1|date>> AND <<date2|date>>
GROUP BY
  items.itemnumber
ORDER BY
  LIBRARY,
  LOCATION,
  ITEM_TYPE,
  CCODE,
  ADDED

























