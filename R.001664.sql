/*
R.001664

----------

Name: Date last borrowed, Call number and Title limited by Ccode
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Weeding Criteria

Created on: 2012-12-03 19:36:57
Modified on: 2014-10-08 14:30:43
Date last run: 2025-10-27 19:23:31

----------

Public: 0
Expiry: 0

----------

Enhanced - Pick your branch and CCode to get a list of items with 

----------
*/



SELECT  items.holdingbranch, items.datelastborrowed,items.datelastseen, items.itemcallnumber,biblio.title, biblio.author FROM items JOIN biblio USING (biblionumber) WHERE items.homebranch = <> AND items.ccode=<> ORDER BY biblio.title asc

























