/*
R.002415

----------

Name: Shelf list of a specific collection code and call number
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2014-11-07 09:58:00
Modified on: 2015-08-16 19:45:21
Date last run: 2017-07-10 16:17:25

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT items.dateaccessioned,items.itype,items.ccode,items.location,items.itemcallnumber,items.barcode,biblio.title,biblio.author,t.publicationyear, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',biblio.biblionumber,'&itemnumber=',items.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" 
  FROM items LEFT JOIN biblio USING(biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE items.homebranch=<<Home branch|branches>> AND items.itemcallnumber LIKE <<Call number LIKE (USE % FOR wildcard; example: E % for call numbers beginning with E(space))>> AND items.ccode = <<ccode|CCODE>> ORDER BY items.itemcallnumber ASC 



