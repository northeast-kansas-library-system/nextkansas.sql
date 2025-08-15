/*
R.001410

----------

Name: Shelf List of Specific Item Type and Location
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2012-05-14 22:52:34
Modified on: 2015-08-16 20:08:27
Date last run: 2025-08-12 15:02:34

----------

Public: 0
Expiry: 0

----------

Enhanced. - Choose Branch, Item Type, and Location -- (On Reports Webpages, 5/14/12). #shelflist

----------
*/



SELECT b.biblionumber, i.dateaccessioned, b.title, b.author, i.ccode, i.location, i.itemcallnumber, i.itype, t.publicationyear, i.barcode, CONCAT(''"edit item"'') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch=&lt;&gt; AND i.itype=&lt;&gt; AND i.location=&lt;&gt; ORDER BY i.itemcallnumber

























