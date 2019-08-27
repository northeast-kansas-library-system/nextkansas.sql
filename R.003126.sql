/*
R.003126

----------

Name: GHW - ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-09-26 17:24:42
Modified on: 2018-09-26 17:50:24
Date last run: 2018-10-07 14:38:31

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat(
    If(items.location IS NULL, "Blank shelving location / ", ""),
    If(items.itype = "XXX", "Unclassified itype / ", ""),
    If(items.ccode IS NULL, "Blank collection code / ", ""),
    If(items.ccode = "XXX", "Unclassified collection code / ", ""),
    If(items.barcode LIKE "WAC%", "", If(LENGTH(items.barcode) < 13, "Short barcode / ", "")),
    If(items.barcode IS NULL, "Blank barcode /", "")
  ) AS PROBLEM,
  Concat('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',  biblio.biblionumber,  '&itemnumber=',  items.itemnumber, '" target="_blank">Edit this item</a>') AS EDIT_ITEM,
  biblio.biblionumber,
  items.itemnumber,
  items.barcode,
  items.homebranch,
  locations.lib AS SHELVING_LOCATION,
  Concat(itemtypes.description, " (", items.itype, ")") AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(" ", biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="c"]')) AS FULL_TITLE,
  items.dateaccessioned
FROM
  biblio
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN items ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'CCODE'
      GROUP BY
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib) ccodes ON items.ccode = ccodes.authorised_value
  JOIN biblioitems ON biblioitems.biblionumber = biblio.biblionumber AND
    items.biblioitemnumber = biblioitems.biblioitemnumber
  INNER JOIN itemtypes ON items.itype = itemtypes.itemtype
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'LOC') locations ON items.location = locations.authorised_value
WHERE
  items.itype <> 'ILL' AND
  items.dateaccessioned < (<<Choose all items added before|date>> + interval 1 day) AND
  items.notforloan = 0 AND
  items.homebranch LIKE <<Choose your library|ZBRAN>> AND
  Concat(
    If(items.location IS NULL, "BLLOC / ", ""),
    If(items.itype = "XXX", "XTYPE / ", ""),
    If(items.ccode IS NULL, "BLCCODE / ", ""),
    If(items.ccode = "XXX", "XCCODE / ", ""),
    If(items.barcode LIKE "WAC%", "", If(LENGTH(items.barcode) < 13, "SBC / ", "")),
    If(items.barcode IS NULL, "BLBC / ", "")
  ) LIKE <<Enter type of problem|LPMONTH>>
GROUP BY
  biblio.biblionumber,
  items.itemnumber,
  locations.lib,
  items.dateaccessioned,
  items.itype
ORDER BY
  items.homebranch,
  items.itype,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE



