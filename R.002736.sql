/*
R.002736

----------

Name: Overbrook Disney DVD
Created by: OVERBROOK TECH

----------

Group: -
     -

Created on: 2016-08-17 15:06:56
Modified on: 2016-08-17 15:08:07
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT  items.barcode,items.itemcallnumber,biblio.title FROM items LEFT JOIN biblioitems on (items.biblioitemnumber=biblioitems.biblioitemnumber) LEFT JOIN biblio on (biblioitems.biblionumber=biblio.biblionumber)   WHERE items.homebranch='OVERBROOK' AND items.itemcallnumber >= 'J DVD DISA' AND items.itemcallnumber <= 'J DVD DISZZZZ' ORDER BY items.itemcallnumber asc



