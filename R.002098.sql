/*
R.002098

----------

Name: Shelf List of Specific Call Number Prefix including numbers
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2013-11-14 15:59:14
Modified on: 2015-08-16 20:27:18
Date last run: 2018-08-01 11:13:16

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT items.dateaccessioned,items.itype,items.ccode,items.location,items.itemcallnumber,items.barcode,biblio.title,biblio.author,t.publicationyear  FROM items LEFT JOIN biblio USING(biblionumber) LEFT JOIN biblioitems t USING(biblionumber)  WHERE items.homebranch=<<Home branch|branches>>  AND items.itemcallnumber LIKE <<Call number LIKE (USE % FOR wildcard)>> AND items.itemcallnumber REGEXP '[0-9]' ORDER BY items.itemcallnumber ASC



