/*
R.002292

----------

Name: Get collection overlap between two libraries
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2014-06-26 15:45:28
Modified on: 2014-06-26 15:46:18
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblio.title, biblio.author, items.itemcallnumber, items.ccode, count(items.itemnumber) FROM items JOIN biblio USING(biblionumber) WHERE items.biblionumber IN (SELECT biblionumber FROM items WHERE homebranch=<<library 1 to compare|branches>>) AND biblionumber IN (SELECT biblionumber FROM items WHERE homebranch=<<library 2 to compare|branches>>) GROUP BY items.biblionumber ORDER BY items.ccode, items.itemcallnumber



