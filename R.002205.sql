/*
R.002205

----------

Name: Never Checked Out Or Hasn't Checked Out Since a specific date (Limited to a collection code)
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Weeding Criteria

Created on: 2014-03-11 14:42:05
Modified on: 2016-06-09 09:36:23
Date last run: 2019-09-03 19:08:27

----------

Public: 0
Expiry: 0

----------

Limited by branch and collection code. 

----------
*/

SELECT items.barcode as 'Barcode', items.holdingbranch, items.datelastseen, items.datelastborrowed, items.itemcallnumber, biblio.title, t.publicationyear as 'Copyright', items.dateaccessioned as 'Accessioned', items.itype, items.ccode, items.location FROM items LEFT JOIN biblio USING (biblionumber) LEFT JOIN biblioitems t USING(biblionumber)  WHERE items.homebranch= <<Pick Your Branch|branches>> AND items.ccode=<<collection code|CCODE>> AND ((items.issues IS NULL AND items.dateaccessioned < <<Choose date|date>>) OR items.datelastborrowed < <<Choose date again|date>>) ORDER BY items.itemcallnumber



