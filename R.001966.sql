/*
R.001966

----------

Name: Never Checked Out Or Hasn't Checked Out Since a specific date
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Weeding Criteria

Created on: 2013-07-31 13:02:01
Modified on: 2015-11-10 11:33:12
Date last run: 2020-12-11 08:38:07

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT items.barcode as 'Barcode', items.holdingbranch, items.datelastseen, items.datelastborrowed, items.itemcallnumber, biblio.title, t.publicationyear as 'Copyright', items.dateaccessioned as 'Accessioned', items.itype, items.ccode, items.location FROM items LEFT JOIN biblio USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber)   WHERE items.homebranch= <<Pick Your Branch|branches>> AND ((items.issues IS NULL AND items.dateaccessioned < <<choose latest date item added yyyy-mm-dd|date>>) OR items.datelastborrowed < <<choose latest date item borrowed yyyy-mm-dd|date>>) ORDER BY items.itemcallnumber



