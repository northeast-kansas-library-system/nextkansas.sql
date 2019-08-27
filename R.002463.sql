/*
R.002463

----------

Name: Public notes field for a collection code
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2015-02-13 14:26:21
Modified on: 2015-02-13 14:29:39
Date last run: 2018-10-12 16:05:39

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblio.title, items.itemcallnumber, items.itemnotes, items.barcode FROM items LEFT JOIN biblio USING(biblionumber) WHERE homebranch=<<Your library|branches>> AND ccode=<<Choose collection code|CCODE>> ORDER BY items.itemnotes, items.itemcallnumber, biblio.title



