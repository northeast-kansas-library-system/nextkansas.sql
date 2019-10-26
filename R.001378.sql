/*
R.001378

----------

Name: All items in a specific item type
Created by: -

----------

Group: Administrative Reports
     Shelf Lists - admin

Created on: 2012-05-11 11:21:56
Modified on: 2013-06-16 14:33:46
Date last run: 2018-04-26 13:28:45

----------

Public: 0
Expiry: 0

----------

(Reports on Entire Collection)

----------
*/

SELECT  i.homebranch, i.itemcallnumber, b.title, i.itype, i.ccode, i.barcode, i.dateaccessioned FROM items i JOIN biblio b USING (biblionumber) WHERE i.itype=<<Pick your item type|itemtypes>> ORDER BY i.homebranch, i.itemcallnumber asc


