/*
R.003362

----------

Name: GHW - Items at a library without a replacement cost
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-04 09:24:50
Modified on: 2020-11-30 20:21:44
Date last run: 2020-11-30 20:22:34

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat('<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', items.biblionumber, '\" target="_blank">', items.biblionumber, '</a>') AS LINK_TO_TITLE,
  Concat('<a class= "clicked" href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', items.biblionumber, '&itemnumber=', items.itemnumber, '#edititem\" target="_blank">Edit item</a>') AS EDIT_ITEM,
  items.itemnumber AS ITEM_NUMBER,
  Concat("-", Coalesce(items.barcode, "-"), "-") AS BARCODE,
  items.homebranch,
  items.holdingbranch,
  Coalesce(plocs.lib, "-") AS PERMANENT_LOCATION,
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
  items.replacementprice
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
      items.location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') plocs ON plocs.authorised_value =
      items.permanent_location
WHERE
  items.homebranch Like <<Choose your library|ZBRAN>> AND
  Coalesce(items.replacementprice, 0) = 0
GROUP BY
  items.itemnumber,
  Coalesce(locs.lib, "-"),
  items.replacementprice,
  plocs.lib,
  biblio.biblionumber
ORDER BY
  items.homebranch,
  PERMANENT_LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  items.copynumber,
  Trim(REGEXP_REPLACE(biblio.author, "[.,:;\/]", "")),
  Trim(REGEXP_REPLACE(Trim(LEADING 'a ' FROM Trim(LEADING 'an ' FROM Trim(LEADING 'the ' FROM Lower(biblio.title)))), "[.:;\"\'\/]", "")),
  Trim(REGEXP_REPLACE(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), "[.:;\"\'\/]", "")),
  Trim(REGEXP_REPLACE(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), "[.:;\"\'\/]", "")),
  Trim(REGEXP_REPLACE(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), "[.:;\"\'\/]", ""))



