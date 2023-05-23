/*
R.003673

----------

Name: Items in a specific Shelving Location with Replacement Price
Created by: OTTAWA TECH

----------

Group: Catalog Records and Items
     -

Created on: 2022-10-27 09:56:09
Modified on: 2023-03-29 08:55:12
Date last run: 2023-03-29 08:55:18

----------

Public: 0
Expiry: 300

----------

Enhanced - Run, Pick Your Branch and Shelving Location to get a list of materials in your collection

----------
*/



SELECT b.biblionumber, i.dateaccessioned, b.title, b.author, i.ccode, i.location, i.itemcallnumber, i.itype, t.publicationyear, i.barcode, i.replacementprice, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch=<<Choose your library|branches>> AND i.location = <<location|LOC>> ORDER BY i.itemcallnumber asc

























