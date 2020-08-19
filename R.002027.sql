/*
R.002027

----------

Name: Long Overdue/Assumed Lost Items
Created by: Heather Braum

----------

Group: Catalog Records and Items
     -

Created on: 2013-09-03 10:39:16
Modified on: 2015-08-16 20:24:53
Date last run: 2020-07-23 17:45:43

----------

Public: 0
Expiry: 0

----------

Items marked long overdue/assumed lost. Enhanced. Choose branch, run. 

----------
*/

SELECT i.datelastseen, b.title, b.author,t.publicationyear, i.location, i.ccode,i.itype,i.itemcallnumber, i.barcode, i.holdingbranch, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber)  LEFT JOIN biblioitems t USING(biblionumber) 
WHERE i.homebranch=<<Pick your branch|branches>> AND i.itemlost = '2'
ORDER BY  i.itemcallnumber



