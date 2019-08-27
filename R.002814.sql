/*
R.002814

----------

Name: Overbrook Adult Non-Fiction
Created by: OVERBROOK TECH

----------

Group: -
     -

Created on: 2016-11-03 14:35:01
Modified on: 2016-11-03 14:35:01
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT  items.itemcallnumber,biblio.author,biblio.title,items.barcode,items.homebranch,items.itemlost,items.holdingbranch,items.itemnotes,items.ccode,items.location,items.permanent_location,items.onloan,items.holdingbranch FROM items LEFT JOIN biblioitems on (items.biblioitemnumber=biblioitems.biblioitemnumber) LEFT JOIN biblio on (biblioitems.biblionumber=biblio.biblionumber)   WHERE items.homebranch='OVERBROOK' AND items.ccode='NONFICTION' AND items.location='ADULT' ORDER BY items.itemcallnumber asc



