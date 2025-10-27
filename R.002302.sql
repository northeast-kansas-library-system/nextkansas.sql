/*
R.002302

----------

Name: Your library's lost items not at your library
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Status reports-lost, damaged

Created on: 2014-07-25 15:25:01
Modified on: 2015-08-16 20:55:02
Date last run: 2025-10-06 18:53:51

----------

Public: 0
Expiry: 0

----------

Shows your library's items marked lost that have a current location that is not your library. 

----------
*/



SELECT items.timestamp AS "Last System Change", items.datelastseen AS "Last Scanner Gun Date", biblio.title, biblio.author,biblioitems.publicationyear, items.holdingbranch, items.location, items.ccode,items.itype,items.itemcallnumber, items.itemnotes, items.barcode, items.replacementprice, CONCAT (''"item info"'') AS "Item Info" FROM items LEFT JOIN biblio USING(biblionumber) LEFT JOIN biblioitems USING (biblionumber) LEFT JOIN authorised_values ON (items.itemlost=authorised_values.authorised_value) WHERE items.homebranch=&lt;&gt; AND items.holdingbranch != &lt;&gt; AND items.itemlost != 0 AND authorised_values.category='LOST' ORDER BY items.timestamp ASC

























