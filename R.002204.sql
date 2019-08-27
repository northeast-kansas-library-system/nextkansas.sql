/*
R.002204

----------

Name: Never Checked Out Or Hasn't Checked Out Since a specific date (Limited to a collection code and shelving location)
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Weeding Criteria

Created on: 2014-03-11 14:41:38
Modified on: 2016-04-18 16:49:07
Date last run: 2019-08-15 13:04:03

----------

Public: 0
Expiry: 0

----------

Limited by branch, collection code, shelving location.

----------
*/

SELECT items.barcode as 'Barcode', items.holdingbranch, items.datelastseen, items.datelastborrowed, items.itemcallnumber, biblio.title, t.publicationyear as 'Copyright', items.dateaccessioned as 'Accessioned', items.itype, items.ccode, items.location FROM items LEFT JOIN biblio USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber) WHERE items.homebranch= <<Pick Your Branch|branches>> AND items.ccode=<<collection code|CCODE>> AND items.location=<<location|LOC>> AND ((items.issues IS NULL AND items.dateaccessioned < <<enter date item added to catalog to check prior to yyyy-mm-dd>>) OR items.datelastborrowed < <<last date borrowed enter date yyyy-mm-dd>>) ORDER BY items.itemcallnumber



