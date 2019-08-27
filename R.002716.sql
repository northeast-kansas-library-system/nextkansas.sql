/*
R.002716

----------

Name: Overbrook VHS
Created by: OVERBROOK TECH

----------

Group: -
     -

Created on: 2016-08-02 10:41:42
Modified on: 2016-08-02 10:41:42
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT  items.barcode,items.homebranch,items.itemcallnumber,biblio.title FROM items LEFT JOIN biblioitems on (items.biblioitemnumber=biblioitems.biblioitemnumber) LEFT JOIN biblio on (biblioitems.biblionumber=biblio.biblionumber)   WHERE items.homebranch='OVERBROOK' AND items.itemcallnumber >= 'Video a' AND items.itemcallnumber <= 'Video ZZZ' ORDER BY items.itemcallnumber asc



