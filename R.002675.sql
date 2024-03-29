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
Date last run: 2022-08-23 14:17:07

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT b.biblionumber, i.dateaccessioned, b.title, b.author, i.ccode, i.location, i.itemcallnumber, i.itype, t.publicationyear, i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch=<<Pick your branch|branches>> AND i.ccode=<<Pick your collection code|CCODE>> AND i.itype=<<item type|itemtypes>> ORDER BY i.itemcallnumber

























