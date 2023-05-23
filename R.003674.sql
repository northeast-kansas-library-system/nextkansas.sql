/*
R.003674

----------

Name: Items in a library's collection with Replacement Price
Created by: OTTAWA TECH

----------

Group: Catalog Records and Items
     -

Created on: 2022-10-27 11:46:35
Modified on: 2023-03-29 08:54:21
Date last run: 2023-03-29 08:54:29

----------

Public: 0
Expiry: 300

----------

Written by Derrick Larcom at Ottawa Library as a reference for an online point of sale system

----------
*/



SELECT b.biblionumber, i.dateaccessioned, b.title, b.author, i.ccode, i.location, i.itemcallnumber, i.itype, t.publicationyear, i.barcode, i.replacementprice, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.homebranch=<<Choose your library|branches>> ORDER BY i.replacementprice asc

























