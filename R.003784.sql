/*
R.003784

----------

Name: ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2023-11-08 14:15:53
Modified on: 2023-11-08 14:17:11
Date last run: 2023-11-09 08:53:13

----------

Public: 0
Expiry: 300

----------

Basic item info template

----------
*/



SELECT 
 
  If( 
    items.homebranch = items.holdingbranch, 
    home_branches.branchname, 
    Concat( 
      home_branches.branchname, 
      '<br />Currently at: ', 
      current_branches.branchname 
    ) 
  ) AS LIBRARY, 
  If( 
    items.permanent_location = items.location, 
    perm_locs.lib, 
    Concat(perm_locs.lib, ' (', locs.lib, ')') 
  ) AS LOCATION, 
  itemtypes.description AS ITEM_TYPE, 
  ccodes.lib AS COLLECTION_CODE, 
  items.itemcallnumber AS CALL_NUMBER, 
  biblio.author AS AUTHOR, 
  Concat_Ws( 
    " ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="c"]') 
  ) AS TITLE, 
  Concat_WS('', '-', items.barcode, '-') AS ITEM_BARCODE
FROM biblio 
  JOIN biblio_metadata 
    ON biblio_metadata.biblionumber = biblio.biblionumber 
  JOIN items 
    ON items.biblionumber = biblio.biblionumber 
  JOIN branches home_branches 
    ON items.homebranch = home_branches.branchcode 
  JOIN branches current_branches 
    ON items.holdingbranch = current_branches.branchcode 
  LEFT JOIN ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.imageurl, 
      authorised_values.lib_opac 
    FROM authorised_values 
    WHERE authorised_values.category = 'LOC' 
  ) perm_locs 
    ON perm_locs.authorised_value = items.permanent_location 
  LEFT JOIN ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.imageurl, 
      authorised_values.lib_opac 
    FROM authorised_values 
    WHERE authorised_values.category = 'LOC' 
  ) locs 
    ON locs.authorised_value = items.location 
  LEFT JOIN itemtypes 
    ON itemtypes.itemtype = items.itype 
  LEFT JOIN ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.imageurl, 
      authorised_values.lib_opac 
    FROM authorised_values 
    WHERE authorised_values.category = 'CCODE' 
  ) ccodes 
    ON ccodes.authorised_value = items.ccode 
WHERE 
  items.barcode LIKE '%12345%' AND 
  items.homebranch LIKE '%' AND 
  items.permanent_location LIKE '%' AND 
  items.itype LIKE '%' AND 
  items.ccode LIKE '%' 
GROUP BY 
  items.itemnumber, 
  biblio.biblionumber 
ORDER BY 
  home_branches.branchcode, 
  perm_locs.lib, 
  ITEM_TYPE, 
  COLLECTION_CODE, 
  CALL_NUMBER, 
  AUTHOR, 
  TITLE, 
  items.barcode 

























