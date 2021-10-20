/*
R.001933

----------

Name: Edit Item Records from a Collection Code Shelf List
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2013-07-11 13:39:56
Modified on: 2013-11-17 15:06:41
Date last run: 2021-04-07 15:23:59

----------

Public: 0
Expiry: 0

----------

Choose your branch and a collection code. Displays item title, callnumber, location, barcode, and an edit link that takes you to the edit item screen in a new window/tab.

----------
*/



SELECT biblio.title, items.itemcallnumber, items.location, items.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',biblio.biblionumber,'&itemnumber=',items.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit barcode"  FROM biblio JOIN items USING(biblionumber) WHERE items.homebranch=<<branch|branches>> AND items.ccode=<<ccode|CCODE>> ORDER BY biblio.title

























