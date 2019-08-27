/*
R.002197

----------

Name: Report of Non-Exclusive Items at Your Library in NExpress (limited by ccode)
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2014-02-24 11:37:00
Modified on: 2014-03-11 14:33:36
Date last run: -

----------

Public: 0
Expiry: 0

----------

List of all items that are not unique to your library (attached to same record, anyway) in the NExpress Shared Catalog (limited by ccode). Aka, multiple branches have items on these particular records. 

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">'"link to record"'</a>') as "link to record", items.barcode, items.itemcallnumber, biblio.title, items.ccode, items.datelastborrowed, (IFNULL(items.issues,0)+IFNULL(items.renewals,0)) as
"Total Circ" FROM items JOIN biblio USING(biblionumber) WHERE items.homebranch=<<your branch|branches>> AND items.ccode=<<ccode|CCODE>> AND biblio.biblionumber NOT IN (SELECT biblionumber FROM items WHERE homebranch=<<your branch|branches>> AND biblionumber NOT IN (SELECT biblionumber FROM items WHERE homebranch <> <<your branch|branches>>)) GROUP BY items.itemnumber ORDER BY items.ccode, items.itemcallnumber



