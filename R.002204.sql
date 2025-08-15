/*
R.002204

----------

Name: Never Checked Out Or Hasn't Checked Out Since a specific date (Limited to a collection code and shelving location)
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Weeding Criteria

Created on: 2014-03-11 14:41:38
Modified on: 2019-11-19 11:27:11
Date last run: 2025-08-01 15:30:24

----------

Public: 0
Expiry: 0

----------

Limited by branch, collection code, shelving location.

----------
*/



SELECT items.barcode AS 'Barcode',
       items.holdingbranch,
       items.datelastseen,
       items.datelastborrowed,
       items.itemcallnumber,
       biblio.title,
       t.publicationyear AS 'Copyright',
       items.dateaccessioned AS 'Accessioned',
       items.itype,
       items.ccode,
       items.location
FROM items
LEFT JOIN biblio USING (biblionumber)
LEFT JOIN biblioitems t USING(biblionumber)
WHERE items.homebranch= &lt;&gt;
  AND items.ccode=&lt;&gt;
  AND items.location=&lt;&gt;
  AND ((items.issues IS NULL AND items.dateaccessioned &lt; &lt;&gt;)
       OR items.datelastborrowed &lt; &lt;&gt;)
ORDER BY items.itemcallnumber

























