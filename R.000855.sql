/*
R.000855

----------

Name: Find irregular call numbers
Created by:  Tongie Book Club

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2010-04-23 14:09:57
Modified on: 2021-09-07 22:26:30
Date last run: 2022-07-22 13:06:15

----------

Public: 0
Expiry: 0

----------

Select branch, enter call number prefix, and run

----------
*/



SELECT
  items.itype,
  items.itemcallnumber,
  items.barcode,
  biblio.title,
  biblioitems.publicationyear,
  items.dateaccessioned
FROM
  items
  LEFT JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN biblioitems ON biblio.biblionumber = biblioitems.biblionumber
WHERE
  items.homebranch LIKE <<branch|branches:all>> AND
  items.itemcallnumber LIKE Concat(<<Enter Call Number prefix>>, "%")
ORDER BY
  items.dateaccessioned DESC

























