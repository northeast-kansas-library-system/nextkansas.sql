/*
R.002158

----------

Name: Items with Double Shelving Locations
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Items-admin

Created on: 2014-01-14 20:02:36
Modified on: 2015-08-16 20:28:32
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT i.dateaccessioned,b.title, b.author,t.publicationyear, i.location, i.ccode,i.itype,i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit barcode" FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber)  
WHERE (i.location NOT IN ('ADULT','CHILDRENS','YOUNGADULT','CATALOGING','PROC','CART')) ORDER BY i.dateaccessioned desc



