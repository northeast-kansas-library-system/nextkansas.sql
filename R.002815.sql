/*
R.002815

----------

Name: Overbrook JS
Created by: OVERBROOK TECH

----------

Group: -
     -

Created on: 2016-11-04 13:26:06
Modified on: 2016-11-04 13:26:06
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT  items.itemcallnumber,biblio.author,biblio.title,items.barcode,items.homebranch,items.ccode,items.location,items.onloan,items.itemlost,items.holdingbranch FROM items LEFT JOIN biblioitems on (items.biblioitemnumber=biblioitems.biblioitemnumber) LEFT JOIN biblio on (biblioitems.biblionumber=biblio.biblionumber)   WHERE items.homebranch='OVERBROOK' AND items.itemcallnumber >= 'JS' AND items.itemcallnumber <= 'JT' ORDER BY items.itemcallnumber asc



