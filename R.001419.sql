/*
R.001419

----------

Name: Items with Missing Status
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Status reports-lost, damaged

Created on: 2012-05-14 23:40:18
Modified on: 2015-08-16 18:11:42
Date last run: 2021-06-05 09:27:32

----------

Public: 0
Expiry: 0

----------

Enhanced -- Choose Library.(On Reports Web Page, 5/14/12). #lost

----------
*/

SELECT i.datelastseen, b.title, b.author,t.publicationyear, i.location, i.ccode,i.itype,i.itemcallnumber, i.barcode, i.holdingbranch, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber)
WHERE i.homebranch=<<Pick your branch|branches>> AND i.itemlost = '3'
ORDER BY  i.itemcallnumber



