/*
R.003852

----------

Name: Email problem data
Created by: George Williams

----------

Group: -
     -

Created on: 2024-07-09 09:59:48
Modified on: 2024-07-09 10:07:50
Date last run: 2025-06-23 09:49:27

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  home_branches.branchreplyto,
  items.itemnumber,
  items.barcode AS ITEM_BARCODE,
  home_branches.branchname AS HOME_BRANCH,
  holding_branches.branchname AS HOLDING_BRANCH,
  If(
    perm_loc.lib = loc.lib, 
    perm_loc.lib, 
    Concat(
      perm_loc.lib, 
      ' (', 
      loc.lib, 
      ')')
    ) AS LOCATION,
  itypes.description AS ITEM_TYPE,
  ccode.lib AS CCODE,
  If(
    items.copynumber IS NULL, 
    items.itemcallnumber, 
    Concat(
      items.itemcallnumber, 
      ' // Copy number: ', 
      items.copynumber
    )
  ) AS CALL_NUMBER,
  biblio.author,
  biblio.title,
  biblioitems.publicationyear AS COPYRIGHT_DATE,
  items.dateaccessioned AS DATE_ADDED,
  items.datelastborrowed AS DATE_LAST_BORROWED,
  items.datelastseen AS DATE_LAST_SEEN,
  (Coalesce(items.issues, 0) + Coalesce(items.renewals, 0)) AS TOTAL_CKO_RENEW
FROM
  items 
LEFT JOIN
  biblio 
    ON biblio.biblionumber = items.biblionumber 
LEFT JOIN
  biblioitems 
    ON biblioitems.biblioitemnumber = items.biblionumber 
LEFT JOIN
  (
    SELECT
      branches.branchcode,
      branches.branchname,
      branches.branchreplyto
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
      branches
  ) holding_branches 
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
  ) loc 
    ON loc.authorised_value = items.location 
LEFT JOIN
  (
    SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes
  ) itypes 
    ON itypes.itemtype = items.itype 
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
    ON ccode.authorised_value = items.ccode
WHERE
  items.barcode LIKE Concat('%',  <<Enter item barcode number>> , '%')
GROUP BY
  items.itemnumber
ORDER BY
  HOME_BRANCH,
  LOCATION,
  ITEM_TYPE,
  CCODE,
  CALL_NUMBER,
  biblio.author,
  biblio.title,
  items.itemnumber

























