/*
R.001406

----------

Name: Location Code Nonstandard? 
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2012-05-14 22:21:07
Modified on: 2015-08-16 20:06:11
Date last run: 2020-01-07 08:19:15

----------

Public: 0
Expiry: 0

----------

Possible nonstandard locations NOT CHILDRENS, ADULT, or YOUNGADULT -- Enhanced -- Choose branch. Can edit items directly linked from this report

----------
*/



SELECT i.dateaccessioned,b.title, b.author,t.publicationyear, i.location, i.ccode,i.itype,i.itemcallnumber,i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit barcode" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber)
WHERE i.homebranch=<<Pick your branch|branches>> AND i.location NOT IN ('ADULT','CHILDRENS','YOUNGADULT')
ORDER BY i.location desc

























