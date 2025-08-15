/*
R.002895

----------

Name: GHW - Lost statuses by check-out branch with last patron data
Created by: George Williams

----------

Group: Circulation
     Overdues

Created on: 2017-02-01 15:28:38
Modified on: 2024-01-17 11:48:54
Date last run: 2025-08-11 11:10:26

----------

Public: 0
Expiry: 0

----------

 
Lists items with any "Lost" status that were checked out at your library
Shows items that currently have the "Lost" status you specify
shows items that were checked out at your library - regardless of which library owns the item
grouped by itemnumber
sorted by the default Next sort order (home library, location, item type, collection code, call number, title, author, barcode number) + patron borrowernumber
OR
date marked lost, borrowers cardnumber, and then the normal sort order

Notes:

Monthly cleanup

Replaces report 888

Click here to run in a new window


----------
*/



SELECT
  holdingbranches.branchname AS CKO_BRANCH,
  Concat(
    'Link to item'
  ) AS ITEM,
  items.barcode AS ITEM_BARCODE,
  homebranches.branchname AS ITEM_HOME,
  If(
    loc.lib = perm_loc.lib, 
    loc.lib, 
    Concat(perm_loc.lib, ' (', loc.lib,')')
  ) AS LOCATION,
  itemtypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber AS CALL_NUMBER,
  biblio.author,
  Concat_Ws(' ', 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS TITLE,
  losts.lib AS LOST_STATUS,
  Date_Format(old_issues.returndate, '%m/%d/%Y') AS LOST_ON,
  borrowers.branchcode AS BORROWER_HOME_LIBRARY,
  borrowers.cardnumber AS LAST_PATRON_CARD,
  borrowers.surname AS LAST_PATRON_NAME,
  borrowers.email,
  items.replacementprice,
  Concat(
    'Link to borrower'
  ) AS BORROWER,
  @SortOrder := &lt;&gt; AS SORTING 
FROM
  items 
  JOIN
    biblio 
    ON items.biblionumber = biblio.biblionumber 
  LEFT JOIN
    (
      SELECT
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = "CCODE"
    ) ccodes 
  ON items.ccode = ccodes.authorised_value 
  LEFT JOIN
    (
      SELECT
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'LOST'
    ) losts 
  ON items.itemlost = losts.authorised_value 
  JOIN
    old_issues 
  ON old_issues.itemnumber = items.itemnumber 
    JOIN
      borrowers 
    ON old_issues.borrowernumber = borrowers.borrowernumber 
    JOIN
      biblio_metadata 
    ON biblio.biblionumber = biblio_metadata.biblionumber
  JOIN
    branches homebranches 
  ON homebranches.branchcode = items.homebranch 
  JOIN
    branches holdingbranches 
  ON holdingbranches.branchcode = items.holdingbranch
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
        authorised_values.category = 'loc'
    ) loc 
  ON loc.authorised_value = items.location 
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
        authorised_values.category = 'loc'
    ) perm_loc 
  ON perm_loc.authorised_value = items.permanent_location 
  JOIN
    itemtypes 
  ON itemtypes.itemtype = items.itype
WHERE
  Date_Format(old_issues.returndate, '%m/%d/%Y') = Date_Format(items.itemlost_on, '%m/%d/%Y') AND
  items.holdingbranch LIKE &lt;&gt; 
GROUP BY
  holdingbranches.branchname,
  homebranches.branchname,
  itemtypes.description,
  Date_Format(old_issues.returndate, '%m/%d/%Y'),
  borrowers.cardnumber,
  borrowers.surname,
  items.itemnumber
HAVING
  LOST_STATUS LIKE &lt;&gt; 
ORDER BY
  (CASE WHEN SORTING = 3 THEN old_issues.returndate END) ASC, 
  (CASE WHEN SORTING = 2 THEN old_issues.returndate END) DESC, 
  (CASE WHEN SORTING = 1 THEN CKO_BRANCH END) ASC, 
  (CASE WHEN SORTING &gt; 1 THEN borrowers.cardnumber END) ASC, 
  LOCATION,
  ITYPE,
  CCODE,
  CALL_NUMBER,
  biblio.author,
  TITLE,
  ITEM_BARCODE,
  LAST_PATRON_CARD,
  LAST_PATRON_NAME

























