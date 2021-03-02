/*
R.003412

----------

Name: koha-US test 2206
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-01-25 09:53:34
Modified on: 2021-01-25 09:53:34
Date last run: 2021-01-25 10:25:52

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    items.biblionumber, 
    '\" target="_blank">', 
    items.biblionumber, 
    '</a>'
  ) AS LINK_TO_TITLE,
  items.biblionumber,
  items.itemnumber AS ITEM_NUMBER,
  Concat("-", Coalesce(items.barcode, "-"), "-") AS BARCODE,
  items.homebranch,
  items.holdingbranch,
  Coalesce(locs.lib, "-") AS LOCATION,
  Coalesce(itypes.description, "-") AS ITYPE,
  Coalesce(ccodes.lib, "-") AS CCODE,
  items.itemcallnumber,
  items.copynumber,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS FULL_TITLE,
  Concat_Ws(" - ", 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="655"]/subfield[@code="a"]')
  ) AS GENRE,
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', 
    items.biblionumber, 
    '&itemnumber=', 
    items.itemnumber, 
    '#edititem\" target="_blank">Edit item</a>'
  ) AS EDIT_ITEM
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber JOIN
  biblioitems ON items.biblioitemnumber = biblioitems.biblioitemnumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      items.ccode LEFT JOIN
  (SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes) itypes ON itypes.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      items.location
WHERE
  items.homebranch = <<Choose your library|branches>> AND
  items.itype = <<Choose an item type|itemtypes:all>> AND
  Concat_Ws(" - ", 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="655"]/subfield[@code="a"]')
  ) Like Concat('%', <<Enter genre term>>, '%')
GROUP BY
  items.itemnumber,
  Coalesce(locs.lib, "-"),
  biblio.biblionumber
ORDER BY
  items.homebranch,
  LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.copynumber



