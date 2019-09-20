/*
R.001163

----------

Name: single collection code value
Created by: BASEHOR TECH

----------

Group: Catalog Records and Items
     Collection Statistics

Created on: 2011-08-11 17:03:50
Modified on: 2013-11-17 16:16:09
Date last run: 2019-09-18 10:28:14

----------

Public: 0
Expiry: 0

----------

#special

----------
*/

SELECT biblio.title, items.replacementprice, count(items.biblionumber) as items, sum(items.replacementprice) as value FROM items JOIN biblio USING (biblionumber) WHERE items.homebranch = <<Pick your branch|branches>> AND items.ccode = <<Choose your Collection code|CCODE>> GROUP BY items.biblionumber ORDER BY items.biblionumber asc



