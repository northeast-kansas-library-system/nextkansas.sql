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
Date last run: 2025-07-31 13:11:58

----------

Public: 0
Expiry: 0

----------

List of all records that only your library has copies attached to in the NExpress Shared Catalog

----------
*/



SELECT CONCAT(''"link to record"'') as "link to record", biblio.title, biblio.author, items.ccode, items.itemcallnumber, count(items.itemnumber) FROM items JOIN biblio USING(biblionumber) WHERE items.homebranch=&lt;&gt; AND biblio.biblionumber NOT IN (SELECT biblionumber FROM items WHERE homebranch &lt;&gt; &lt;&gt;) GROUP BY biblio.biblionumber ORDER BY items.ccode, items.itemcallnumber

























