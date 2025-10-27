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
Date last run: 2025-09-16 15:08:15

----------

Public: 0
Expiry: 0

----------

Enhanced - Pick your branch and CCode to get a list of items with 

----------
*/



SELECT  items.holdingbranch, items.datelastborrowed,items.datelastseen, items.itemcallnumber,biblio.title, biblio.author FROM items JOIN biblio USING (biblionumber) WHERE items.homebranch = &lt;&gt; AND items.ccode=&lt;&gt; ORDER BY biblio.title asc

























