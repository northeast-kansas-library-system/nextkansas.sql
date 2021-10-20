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
Date last run: 2021-10-09 12:15:17

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
WHERE items.homebranch= <<Pick Your Branch|branches>>
  AND items.ccode=<<collection code|CCODE>>
  AND items.location=<<LOCATION|LOC>>
  AND ((items.issues IS NULL AND items.dateaccessioned < <<enter date item added TO CATALOG TO CHECK PRIOR TO yyyy-mm-dd>>)
       OR items.datelastborrowed < <<LAST date borrowed enter date yyyy-mm-dd>>)
ORDER BY items.itemcallnumber

























