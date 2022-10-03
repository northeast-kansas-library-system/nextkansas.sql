/*
R.003648

----------

Name: Call numbers with unneeded spaces
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-02-07 09:12:49
Modified on: 2022-06-07 11:35:47
Date last run: 2022-08-09 09:25:20

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.itemnumber,
  Replace(items.itemcallnumber, ' ', '|') AS CALL_NUMBER_W_BREAKS,
  items.barcode AS ITEM_BARCODE,
  home_branches.branchname AS HOME_BRANCH,
  holding_branches.branchname AS HOLDING_BRANCH,
  If(
    perm_loc.lib = loc.lib, 
    perm_loc.lib, 
    Concat(perm_loc.lib, ' (', loc.lib, ')')
  ) AS LOCATION,
  itypes.description AS ITEM_TYPE,
  ccode.lib AS CCODE,
  If(
    items.copynumber IS NULL, 
    items.itemcallnumber,
    Concat(items.itemcallnumber, ' // Copy number: ', items.copynumber)
  ) AS CALL_NUMBER,
  biblio.author,
  biblio.title,
  cnlines.length AS SPINE_LABEL_LINES
FROM
  items LEFT JOIN
  biblio ON biblio.biblionumber = items.biblionumber LEFT JOIN
  biblioitems ON biblioitems.biblioitemnumber = items.biblionumber LEFT JOIN
  (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
    ) home_branches 
    ON home_branches.branchcode = items.homebranch
    LEFT JOIN
  (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches) holding_branches 
      ON holding_branches.branchcode = items.holdingbranch 
      LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
    ) perm_loc 
    ON perm_loc.authorised_value = items.permanent_location 
    LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
    ) loc ON loc.authorised_value = items.location 
    LEFT JOIN
  (
    SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes
    ) itypes ON itypes.itemtype = items.itype 
    LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    ) ccode 
    ON ccode.authorised_value = items.ccode JOIN
  (
    SELECT
      items.itemnumber,
      items.barcode,
      (Length(items.itemcallnumber) - Length(Replace(items.itemcallnumber, ' ',
      '')) + 1) AS length,
      items.homebranch
    FROM
      items
    WHERE
      items.homebranch Like <<Choose your library|branches:all>> AND
      (Length(Replace(items.itemcallnumber, ' ', '-')) - Length(Replace(items.itemcallnumber, ' ', '')) + 1) > <<Greater than X lines on the spine label|YNUMBER>>
    ) cnlines 
    ON cnlines.itemnumber = items.itemnumber AND
      cnlines.homebranch = items.homebranch
WHERE
  items.homebranch Like <<Choose your library|branches:all>>
GROUP BY
  items.itemnumber,
  cnlines.length,
  items.itemcallnumber
ORDER BY
  HOME_BRANCH,
  LOCATION,
  ITEM_TYPE,
  CCODE,
  CALL_NUMBER,
  biblio.author,
  biblio.title,
  items.itemnumber

























