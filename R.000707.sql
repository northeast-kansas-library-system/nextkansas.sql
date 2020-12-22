/*
R.000707

----------

Name: Shelf List of Specific Call Number Prefix
Created by:  Tongie Book Club

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2009-10-29 15:00:05
Modified on: 2015-07-01 18:21:04
Date last run: 2020-12-04 09:09:36

----------

Public: 0
Expiry: 0

----------

Enhanced. Choose branch and enter call number prefix + % to search on.

----------
*/

SELECT items.dateaccessioned,items.datelastseen,items.itype,items.ccode,items.location,items.itemcallnumber,items.barcode,biblio.title,biblio.author,t.publicationyear, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',biblio.biblionumber,'&itemnumber=',items.itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item" 
  FROM items LEFT JOIN biblio USING(biblionumber)  LEFT JOIN biblioitems t USING(biblionumber)  WHERE items.homebranch=<<Home branch|branches>> AND items.itemcallnumber LIKE <<Call number LIKE (USE % FOR wildcard)>> ORDER BY items.itemcallnumber ASC



