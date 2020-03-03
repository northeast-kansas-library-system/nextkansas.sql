/*
R.002912

----------

Name: GHW - End of year Inventory at branch
Created by: George H Williams

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2017-02-23 17:12:52
Modified on: 2017-02-23 17:27:48
Date last run: 2019-12-31 16:56:10

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  items.barcode,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.price,
  items.replacementprice,
  items.itemlost,
  items.damaged,
  items.onloan,
  items.notforloan,
  items.withdrawn,
  items.dateaccessioned,
  If(items.timestamp > 1, "-", items.timestamp) AS DELETED_ON
FROM
  items INNER JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber
WHERE
  items.homebranch = 'BONNERSPGS' AND
  items.dateaccessioned < MakeDate(Year(Now()), 1)
UNION
SELECT
  deleteditems.barcode,
  deleteditems.homebranch,
  deleteditems.location,
  deleteditems.itype,
  deleteditems.ccode,
  deleteditems.itemcallnumber,
  deletedbiblio.author,
  deletedbiblio.title,
  deleteditems.price,
  deleteditems.replacementprice,
  deleteditems.itemlost,
  deleteditems.damaged,
  deleteditems.onloan,
  deleteditems.notforloan,
  deleteditems.withdrawn,
  deleteditems.dateaccessioned,
  deleteditems.timestamp
FROM
  deleteditems INNER JOIN
  deletedbiblio
    ON deleteditems.biblionumber = deletedbiblio.biblionumber
WHERE
  deleteditems.homebranch = 'BONNERSPGS' AND
  deleteditems.dateaccessioned < MakeDate(Year(Now()), 1) AND
  deleteditems.timestamp > MakeDate(Year(Now()), 1)
  UNION
SELECT
  deleteditems.barcode,
  deleteditems.homebranch,
  deleteditems.location,
  deleteditems.itype,
  deleteditems.ccode,
  deleteditems.itemcallnumber,
  biblio.author,
  biblio.title,
  deleteditems.price,
  deleteditems.replacementprice,
  deleteditems.itemlost,
  deleteditems.damaged,
  deleteditems.onloan,
  deleteditems.notforloan,
  deleteditems.withdrawn,
  deleteditems.dateaccessioned,
  deleteditems.timestamp
FROM
  deleteditems INNER JOIN
  biblio
    ON deleteditems.biblionumber = biblio.biblionumber
WHERE
  deleteditems.homebranch = 'BONNERSPGS' AND
  deleteditems.dateaccessioned < MakeDate(Year(Now()), 1) AND
  deleteditems.timestamp > MakeDate(Year(Now()), 1)
ORDER BY
  homebranch,
  location,
  itype,
  ccode,
  itemcallnumber,
  author,
  title



