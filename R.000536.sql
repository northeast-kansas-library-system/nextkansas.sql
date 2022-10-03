/*
R.000536

----------

Name: New acquisitions for a specific month
Created by: -

----------

Group: Catalog Records and Items
     New Materials

Created on: 2009-05-04 15:06:32
Modified on: 2020-12-08 22:30:13
Date last run: 2022-10-03 09:34:22

----------

Public: 0
Expiry: 0

----------

Enter numeric month and year for the month you want to look at. 

----------
*/



SELECT
  Concat(
    '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',
    biblio.biblionumber,
    '\" target="_blank">',
    biblio.biblionumber,
    '</a>'
  ) AS "Link to Record",
  items.barcode,
  items.homebranch,
  items.permanent_location,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.dateaccessioned,
  items.price,
  items.replacementprice,
  items.timestamp
FROM
  items JOIN
  biblio ON biblio.biblionumber = items.biblionumber
WHERE
  items.homebranch = <<Pick your branch|branches>> AND
  Month(items.dateaccessioned) = <<Choose month|Month>> AND
  Year(items.dateaccessioned) = <<Choose year|Year>>
GROUP BY
  biblio.biblionumber
ORDER BY
  items.homebranch,
  items.permanent_location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title

























