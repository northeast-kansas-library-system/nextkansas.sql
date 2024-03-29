/*
R.001415

----------

Name: Items with Damaged Status
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Status reports-lost, damaged

Created on: 2012-05-14 23:22:27
Modified on: 2015-08-16 19:37:14
Date last run: 2023-05-04 15:19:30

----------

Public: 0
Expiry: 0

----------

Enhanced -- Choose Library. (On Reports Webpages, 5/14/12) #special #count

----------
*/



SELECT i.datelastseen,b.title, b.author,t.publicationyear, i.location, i.ccode,i.itype,i.itemcallnumber, i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber)
WHERE i.homebranch=<<Pick your branch|branches>> AND (i.damaged='1' OR i.itemlost='4') ORDER BY  i.itemcallnumber

























