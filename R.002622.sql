/*
R.002622

----------

Name: List of items with missing status limited by collection code
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2015-10-15 14:49:39
Modified on: 2015-10-23 13:19:43
Date last run: 2019-07-19 08:53:16

----------

Public: 0
Expiry: 0

----------

Choose library and collection code 

----------
*/

SELECT biblio.title, items.itemcallnumber, items.datelastseen, items.barcode FROM biblio LEFT JOIN items USING(biblionumber) WHERE items.homebranch=<<choose branch|branches>> AND items.itemlost='3' and items.ccode=<<Choose collection code|CCODE>> ORDER BY title



