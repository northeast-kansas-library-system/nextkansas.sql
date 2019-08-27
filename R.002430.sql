/*
R.002430

----------

Name: Itypes that are XXX or unclassified
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Items-admin

Created on: 2015-01-08 11:26:19
Modified on: 2015-08-16 19:46:49
Date last run: 2018-10-03 10:47:23

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',b.biblionumber,'\" target="_blank">'"link to record"'</a>') as "link to record", i.dateaccessioned, b.title, b.author, i.itemnotes, i.ccode, i.location, i.itemcallnumber, i.itype, t.publicationyear, i.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',b.biblionumber,'&itemnumber=',i.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item"  FROM items i LEFT JOIN biblio b USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE i.itype='xxx' ORDER BY i.itype,i.ccode, i.itemcallnumber



