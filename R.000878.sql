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
Date last run: 2025-09-30 16:13:04

----------

Public: 0
Expiry: 0

----------

Enhanced - Run, Pick Your Branch and Shelving Location to get a list of materials in your collection

----------
*/



SELECT b.biblionumber, i.dateaccessioned, b.title, b.author, i.ccode, i.location, i.itemcallnumber, i.itype, t.publicationyear, i.barcode, CONCAT(''"edit item"'') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch=&lt;&gt; AND i.location = &lt;&gt; ORDER BY i.itemcallnumber asc

























