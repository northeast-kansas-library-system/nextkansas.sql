/*
R.002451

----------

Name: Shelf list of callnumbers with extra spaces
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2015-01-27 10:55:11
Modified on: 2018-08-22 09:42:16
Date last run: 2019-01-30 08:49:02

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  items.dateaccessioned,
  biblio.title,
  biblio.author,
  biblioitems.publicationyear,
  items.location,
  items.ccode,
  items.itype,
  items.barcode,
  Concat(
    '<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',
    biblio.biblionumber,
    '&itemnumber=',
    items.itemnumber,
    '#edititem\" target="_blank">edit item</a>'
  ) AS "edit item"
FROM
  items
  LEFT JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN biblioitems ON biblio.biblionumber = biblioitems.biblionumber
WHERE
  items.homebranch LIKE <<Pick your branch|LBRANCH>> AND
  (items.itemcallnumber IS NULL OR
    items.itemcallnumber LIKE ' %' OR
    items.itemcallnumber LIKE '	%' OR
    items.itemcallnumber LIKE '%	%' OR
    items.itemcallnumber LIKE '%  %')
ORDER BY
  items.dateaccessioned DESC



