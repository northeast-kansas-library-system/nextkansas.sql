/*
R.002195

----------

Name: Report of All Unique Titles at Your Library in NExpress
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2014-02-24 11:14:47
Modified on: 2014-02-24 11:26:43
Date last run: 2022-10-25 10:03:24

----------

Public: 0
Expiry: 0

----------

List of all records that only your library has copies attached to in the NExpress Shared Catalog

----------
*/



SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">'"link to record"'</a>') as "link to record", biblio.title, biblio.author, items.ccode, items.itemcallnumber, count(items.itemnumber) FROM items JOIN biblio USING(biblionumber) WHERE items.homebranch=<<your branch|branches>> AND biblio.biblionumber NOT IN (SELECT biblionumber FROM items WHERE homebranch <> <<your branch|branches>>) GROUP BY biblio.biblionumber ORDER BY items.ccode, items.itemcallnumber

























