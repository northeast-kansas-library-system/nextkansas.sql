/*
R.003160

----------

Name: GHW - Materials added in the previous calendar month
Created by: George Williams

----------

Group: -
     -

Created on: 2019-01-27 22:47:48
Modified on: 2024-01-17 12:11:47
Date last run: 2025-10-17 14:00:31

----------

Public: 0
Expiry: 300

----------

 
Generates a list of items added in the previous calendar month
Only shows items added in the previous calendar month
at the library you specify
grouped by biblio number and item number
sorted by home branch, shelving location, item type, collection code, call number, author, and title
contains links to the item's bibliographic record

Notes:

Partially replaces report 536

Updated on 2023.07.21 to fix a home library/holding library issue

Click here to run in a new window


----------
*/



SELECT 
  Concat( 
    '', 
    items.biblionumber, 
    '' 
  ) AS 'Link to title', 
  Concat("-", Coalesce(items.barcode, "-"), "-") AS "Item barcode", 
  branches.branchname AS 'Library', 
  perm_locs.lib AS 'Permanent location', 
  If(locs.lib = perm_locs.lib, '', locs.lib) AS 'Current location', 
  itemtypes.description AS 'Item type', 
  ccodes.lib AS 'Collection code', 
  items.itemcallnumber AS 'Call number', 
  biblio.author AS 'Author', 
  Concat_Ws( 
    " ", 
    biblio.title, 
    ExtractValue( 
      biblio_metadata.metadata, 
      '//datafield[@tag="245"]/subfield[@code="h"]' 
    ), 
    ExtractValue( 
      biblio_metadata.metadata, 
      '//datafield[@tag="245"]/subfield[@code="b"]' 
    ), 
    ExtractValue( 
      biblio_metadata.metadata, 
      '//datafield[@tag="245"]/subfield[@code="p"]' 
    ), 
    ExtractValue( 
      biblio_metadata.metadata, 
      '//datafield[@tag="245"]/subfield[@code="n"]' 
    ) 
  ) AS 'Full title', 
  items.dateaccessioned AS 'Date added', 
  items.price AS 'Normal purchase price', 
  items.replacementprice AS 'Replacement price', 
  items.timestamp AS 'Last updated on' 
FROM items 
  JOIN biblio ON biblio.biblionumber = items.biblionumber 
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber 
  LEFT JOIN ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM authorised_values 
    WHERE authorised_values.category = 'CCODE' 
  ) ccodes ON ccodes.authorised_value = items.ccode 
  LEFT JOIN ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM authorised_values 
    WHERE authorised_values.category = 'LOC' 
  ) locs ON locs.authorised_value = items.location 
  LEFT JOIN itemtypes ON itemtypes.itemtype = items.itype 
  LEFT JOIN ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM authorised_values 
    WHERE authorised_values.category = 'LOC' 
  ) perm_locs ON perm_locs.authorised_value = items.permanent_location 
  JOIN branches ON items.homebranch = branches.branchcode 
WHERE 
  items.homebranch Like &lt;&gt; And 
  Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND 
  Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) 
GROUP BY 
  items.biblionumber, 
  items.itemnumber 
ORDER BY 
  'Library', 
  'Permanent location', 
  'Item type', 
  'Collection code', 
  'Call number', 
  'Author', 
  'Full title' 

























