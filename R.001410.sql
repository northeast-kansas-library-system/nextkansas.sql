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
Date last run: 2021-06-22 15:20:06

----------

Public: 0
Expiry: 0

----------

Enhanced. - Choose Branch, Item Type, and Location -- (On Reports Webpages, 5/14/12). #shelflist

----------
*/

SELECT b.biblionumber, i.dateaccessioned, b.title, b.author, i.ccode, i.location, i.itemcallnumber, i.itype, t.publicationyear, i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch=<<Pick your branch|branches>> AND i.itype=<<Pick your item type|itemtypes>> AND i.location=<<location|LOC>> ORDER BY i.itemcallnumber



