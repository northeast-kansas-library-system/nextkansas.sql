/*
R.003875

----------

Name: GHW - very short bibliographic records - work in progress
Created by: George Williams

----------

Group: -
     -

Created on: 2025-01-27 14:15:47
Modified on: 2025-01-27 14:44:47
Date last run: 2025-11-25 15:07:49

----------

Public: 0
Expiry: 300

----------

ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="w"]')

----------
*/



SELECT
  Concat( 
    'Go to title' 
  ) AS LINK_TO_TITLE, 
  items.barcode AS ITEM_BARCODE,
  home_branches.branchname AS HOME_BRANCH,
  holding_branches.branchname AS HOLDING_BRANCH,
  If(perm_loc.lib = loc.lib, perm_loc.lib, Concat(perm_loc.lib, ' (', loc.lib, ')')) AS LOCATION,
  itypes.description AS ITEM_TYPE,
  ccode.lib AS CCODE,
  If(items.copynumber IS NULL, items.itemcallnumber, Concat(items.itemcallnumber, ' // Copy number: ', items.copynumber)) AS CALL_NUMBER,
  biblio.author,
  biblio.title,
  biblioitems.publicationyear AS COPYRIGHT_DATE,
  items.dateaccessioned AS DATE_ADDED,
  borrowers.userid,
  borrowers.branchcode,
  bib_created_by.LEN AS BIB_SIZE
FROM items 
  LEFT JOIN biblio 
    ON biblio.biblionumber = items.biblionumber 
  LEFT JOIN biblioitems 
    ON biblioitems.biblioitemnumber = items.biblionumber 
  LEFT JOIN (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches) home_branches ON home_branches.branchcode = items.homebranch
  LEFT JOIN (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
  ) holding_branches 
    ON holding_branches.branchcode = items.holdingbranch 
  LEFT JOIN (
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
  LEFT JOIN (
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
  LEFT JOIN (
    SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes
  ) itypes 
    ON itypes.itemtype = items.itype 
  LEFT JOIN (
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
  JOIN (
    SELECT
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="w"]') AS metadata,
      biblio_metadata.biblionumber,
      Length(biblio_metadata.metadata) AS LEN
    FROM
      biblio_metadata
    WHERE
      Length(biblio_metadata.metadata) &lt; 2001
  ) bib_created_by 
    ON bib_created_by.biblionumber = items.biblionumber 
  JOIN borrowers 
    ON borrowers.borrowernumber = bib_created_by.metadata
WHERE
  items.homebranch LIKE &lt;&gt; AND
  borrowers.branchcode LIKE &lt;&gt;
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

























