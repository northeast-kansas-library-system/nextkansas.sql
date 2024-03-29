/*
R.003048

----------

Name: GHW - Flexible items added list
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-02-07 16:01:11
Modified on: 2018-02-07 16:05:35
Date last run: 2020-06-05 14:19:16

----------

Public: 0
Expiry: 300

----------

Allows you to select home library, location, item type, collection code, left anchored call number, date added range, etc.

----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', items.biblionumber, '\" target="_blank">', items.biblionumber, '</a>') AS LINK_TO_TITLE,
  items.biblionumber,
  items.itemnumber,
  Concat("-", Coalesce(items.barcode, "-"), "-") AS BARCODE,
  items.homebranch,
  Coalesce(items.location, "-") AS LOCATION,
  Coalesce(items.itype, "-") AS ITYPE,
  Coalesce(items.ccode, "-") AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(" ",
    biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  biblioitems.publicationyear,
  items.dateaccessioned,
  items.datelastborrowed,
  items.datelastseen,
  items.issues,
  items.renewals,
  Sum((Coalesce(items.issues, 0)) + Coalesce(items.renewals, 0)) AS CHECKOUTS_PLUS_RENEWALS,
  If(items.onloan IS NULL, 'No', 'Yes') AS CHECKED_OUT,
  If(Sum(Coalesce(items.damaged, 0) + Coalesce(items.itemlost, 0) + Coalesce(items.withdrawn, 0)) = 0, 'No', 'Yes') AS STATUS_PROBLEMS,
  items.itemnotes,
  items.itemnotes_nonpublic,
  CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',items.biblionumber,'&itemnumber=',items.itemnumber,'#edititem\" target="_blank">Edit item</a>') AS EDIT_ITEM
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber
  JOIN biblioitems ON items.biblioitemnumber = biblioitems.biblioitemnumber
WHERE
  items.homebranch LIKE <<Item home library|ZBRAN>> AND
  Coalesce(items.location, "-") LIKE <<Item shelving location|LLOC>> AND
  Coalesce(items.itype, "-") LIKE <<Item type|LITYPES>> AND
  Coalesce(items.ccode, "-") LIKE <<Item collection code|LCCODE>> AND
  Coalesce(items.itemcallnumber, "-") LIKE CONCAT(<<Enter first part of call number or a % symbol>>, "%") AND
  items.dateaccessioned BETWEEN <<Item was added between|date>> AND <<and|date>> + INTERVAL 1 DAY
GROUP BY
  items.itemnumber
HAVING 
  CHECKOUTS_PLUS_RENEWALS <= <<With X or fewer checkouts|ZNUMBERS>> AND
  CHECKED_OUT LIKE <<Display checked out items|ZYES_NO>> AND
  STATUS_PROBLEMS LIKE <<Display lost, missing, and withdrawn items|ZYES_NO>>
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title

























