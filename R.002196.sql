/*
R.002196

----------

Name: Report of Items Exclusive to Your Library in NExpress (limited by ccode)
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2014-02-24 11:21:02
Modified on: 2014-03-11 14:33:07
Date last run: 2022-02-07 13:40:28

----------

Public: 0
Expiry: 0

----------

List of all items that only your library has copies attached to records in the NExpress Shared Catalog (limited by ccode)

----------
*/



SELECT CONCAT(''"link to record"'') as "link to record", items.barcode, items.itemcallnumber, biblio.title, items.ccode, items.datelastborrowed, (IFNULL(items.issues,0)+IFNULL(items.renewals,0)) as
"Total Circ" FROM items JOIN biblio USING(biblionumber) WHERE items.homebranch=<> AND items.ccode=<> AND biblio.biblionumber NOT IN (SELECT biblionumber FROM items WHERE homebranch <> <>) GROUP BY items.itemnumber ORDER BY items.ccode, items.itemcallnumber

























