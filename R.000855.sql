/*
R.000855

----------

Name: Find irregular call numbers
Created by:  Tongie Book Club

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2010-04-23 14:09:57
Modified on: 2018-08-20 15:40:38
Date last run: 2020-08-18 16:18:38

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
  items.homebranch = <<branch|branches>> AND
  items.itemcallnumber LIKE Concat(<<Enter Call Number prefix>>, "%")
ORDER BY
  items.dateaccessioned DESC



