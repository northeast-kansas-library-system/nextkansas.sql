/*
R.001900

----------

Name: Missing Items, Limited by CCode
Created by: Heather Braum

----------

Group: Catalog Records and Items
     -

Created on: 2013-06-10 15:21:25
Modified on: 2015-08-16 20:35:49
Date last run: 2019-02-13 13:56:31

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT i.datelastseen, b.title, b.author,t.publicationyear, i.location, i.ccode,i.itype,i.itemcallnumber, i.barcode, i.holdingbranch, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber)  
WHERE i.homebranch=<<Pick your branch|branches>> AND i.ccode=<<Pick your collection code|CCODE>> AND i.itemlost = '3'
ORDER BY  i.itemcallnumber LIMIT 10000



