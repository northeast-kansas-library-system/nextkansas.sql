/*
R.002151

----------

Name: Holton Damaged Items
Created by: Heather Braum

----------

Group: Library-Specific
     Holton

Created on: 2014-01-13 11:34:47
Modified on: 2014-01-13 11:58:20
Date last run: -

----------

Public: 0
Expiry: 0

----------

Items marked damaged on 2014-01-13

----------
*/

SELECT biblio.title, items.itemcallnumber, items.booksellerid, items.itemnotes, items.barcode, items.replacementprice FROM biblio JOIN items USING(biblionumber) WHERE items.homebranch='HOLTON' AND items.damaged='1' AND items.timestamp LIKE '2014-01-13%'



