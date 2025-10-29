/*
R.002675

----------

Name: Shelf list of specific collection code and item type
Created by: Heather Braum

----------

Group: Catalog Records and Items
     -

Created on: 2016-03-07 10:42:35
Modified on: 2016-03-07 10:42:35
Date last run: 2025-07-17 16:31:47

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT b.biblionumber, i.dateaccessioned, b.title, b.author, i.ccode, i.location, i.itemcallnumber, i.itype, t.publicationyear, i.barcode, CONCAT(''"edit item"'') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch=<> AND i.ccode=<> AND i.itype=<> ORDER BY i.itemcallnumber

























