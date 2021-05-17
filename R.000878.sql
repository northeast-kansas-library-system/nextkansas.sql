/*
R.000878

----------

Name: Items in a specific Shelving Location
Created by:  Tongie Book Club

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2010-06-07 15:09:44
Modified on: 2015-08-16 17:00:38
Date last run: 2021-04-16 13:20:50

----------

Public: 0
Expiry: 0

----------

Enhanced - Run, Pick Your Branch and Shelving Location to get a list of materials in your collection

----------
*/

SELECT b.biblionumber, i.dateaccessioned, b.title, b.author, i.ccode, i.location, i.itemcallnumber, i.itype, t.publicationyear, i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch=<<branch|branches>> AND i.location = <<location|LOC>> ORDER BY i.itemcallnumber asc



