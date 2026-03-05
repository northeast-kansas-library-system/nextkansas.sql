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
Date last run: 2025-11-12 18:08:31

----------

Public: 0
Expiry: 0

----------

Enhanced. Choose branch and enter call number prefix + % to search on.

----------
*/



SELECT items.dateaccessioned,items.datelastseen,items.itype,items.ccode,items.location,items.itemcallnumber,items.barcode,biblio.title,biblio.author,t.publicationyear, CONCAT(''"edit item"'') as "edit item" 
  FROM items LEFT JOIN biblio USING(biblionumber)  LEFT JOIN biblioitems t USING(biblionumber)  WHERE items.homebranch=&lt;&gt; AND items.itemcallnumber LIKE &lt;&gt; ORDER BY items.itemcallnumber ASC

























