/*
R.001418

----------

Name: Items with Withdrawn Status
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Status reports-lost, damaged

Created on: 2012-05-14 23:35:28
Modified on: 2015-08-16 19:38:04
Date last run: 2020-12-09 13:31:10

----------

Public: 0
Expiry: 0

----------

Enhanced -- Choose Library. (On Reports Webpages, 5/14/12)  #special

----------
*/

SELECT items.datelastseen, authorised_values.lib, biblio.title, biblio.author, biblioitems.publicationyear, items.location, items.ccode,items.itype, items.itemcallnumber, items.barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',biblio.biblionumber,'&itemnumber=',items.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" FROM items LEFT JOIN biblioitems USING(biblionumber) LEFT JOIN biblio USING (biblionumber) LEFT JOIN authorised_values ON (items.withdrawn=authorised_values.authorised_value) WHERE items.homebranch=<<Pick your branch|branches>> AND items.withdrawn != 0 AND authorised_values.category='WITHDRAWN' ORDER BY authorised_values.lib, items.itemcallnumber



