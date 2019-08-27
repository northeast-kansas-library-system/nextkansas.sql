/*
R.002470

----------

Name: Shelf list of specific collection code
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2015-03-05 14:52:28
Modified on: 2015-08-16 19:59:39
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT b.biblionumber, i.dateaccessioned, b.title, b.author, i.ccode, i.location, i.itemcallnumber, i.itype, t.publicationyear, i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch=<<Pick your branch|branches>> AND i.ccode=<<Pick your collection code|CCODE>> ORDER BY i.itemcallnumber



