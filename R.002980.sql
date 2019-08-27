/*
R.002980

----------

Name: Overbrook PB call #
Created by: OVERBROOK TECH

----------

Group: -
     -

Created on: 2017-08-01 08:25:35
Modified on: 2017-08-01 08:25:35
Date last run: 2017-08-07 09:35:38

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT  items.barcode,items.homebranch,items.itemcallnumber,biblio.title,biblio.author FROM items LEFT JOIN biblioitems on (items.biblioitemnumber=biblioitems.biblioitemnumber) LEFT JOIN biblio on (biblioitems.biblionumber=biblio.biblionumber)   WHERE items.homebranch='OVERBROOK' AND items.itemcallnumber >= 'PBA' AND items.itemcallnumber <= 'PBZ' ORDER BY items.itemcallnumber asc



