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
Date last run: 2020-10-15 14:36:03

----------

Public: 0
Expiry: 0

----------

List of all items that only your library has copies attached to records in the NExpress Shared Catalog (limited by ccode)

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">'"link to record"'</a>') as "link to record", items.barcode, items.itemcallnumber, biblio.title, items.ccode, items.datelastborrowed, (IFNULL(items.issues,0)+IFNULL(items.renewals,0)) as
"Total Circ" FROM items JOIN biblio USING(biblionumber) WHERE items.homebranch=<<your branch|branches>> AND items.ccode=<<ccode|CCODE>> AND biblio.biblionumber NOT IN (SELECT biblionumber FROM items WHERE homebranch <> <<your branch|branches>>) GROUP BY items.itemnumber ORDER BY items.ccode, items.itemcallnumber



