/*
R.002028

----------

Name: Items marked claims returned
Created by: Heather Braum

----------

Group: Catalog Records and Items
     -

Created on: 2013-09-03 10:42:20
Modified on: 2015-08-16 20:25:06
Date last run: 2018-05-04 17:26:00

----------

Public: 0
Expiry: 0

----------

Items marked claims returned; enhanced; choose branch, run. 

----------
*/

SELECT i.datelastseen, b.title, b.author,t.publicationyear, i.location, i.ccode,i.itype,i.itemcallnumber, i.barcode, i.holdingbranch, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber)  LEFT JOIN biblioitems t USING(biblionumber) 
WHERE i.homebranch=<<Pick your branch|branches>> AND i.itemlost = '5'
ORDER BY  i.itemcallnumber



