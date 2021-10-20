/*
R.002808

----------

Name: GHW - Flexible shelflist sorted by branch, location, itype, ccode
Created by: George H Williams

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2016-10-14 10:30:29
Modified on: 2018-04-16 11:02:08
Date last run: 2020-09-10 10:17:39

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows all items at a specified branch with a specified shelving location, a specified item type, and a specified collection code</p>
<ul><li>Shows current items</li>
<li>at a location you specify</li>
<li>grouped and sorted by item home branch, shelving location, item type, collection code, call number, author, and title</li>
<li>contains links to bibliographic records</li>
</ul><br />
</div>

----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">', biblio.biblionumber, '</a>') AS LINK_TO_TITLE,
  items.barcode AS ITEM_BC,
  items.homebranch AS HOMEBRANCH,
  items.location AS SHELVING_LOCATION,
  items.itype AS ITEM_TYPE,
  authorised_values.lib AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE
FROM
  items JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber AND
    items.biblionumber = biblio_metadata.biblionumber LEFT JOIN
  authorised_values
    ON items.ccode = authorised_values.authorised_value
WHERE
  items.homebranch LIKE <<Choose item home branch|LBRANCH>> AND
  items.location LIKE <<Choose item location|LLOC>> AND
  items.itype LIKE <<Choose item type|LITYPES>> AND
  authorised_values.lib LIKE <<Choose collection code|LCCODE>> AND
  authorised_values.category = "CCODE"
GROUP BY
  HOMEBRANCH,
  SHELVING_LOCATION,
  ITEM_TYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE
ORDER BY
  HOMEBRANCH,
  SHELVING_LOCATION,
  ITEM_TYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE

























