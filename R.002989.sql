/*
R.002989

----------

Name: OVERBROOK ITEMTYPE XXX?
Created by: OVERBROOK TECH

----------

Group: -
     -

Created on: 2017-08-14 11:52:45
Modified on: 2017-08-14 11:52:45
Date last run: 2018-05-04 17:43:18

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT  items.homebranch,items.itype,items.barcode,biblio.author,biblio.title FROM items LEFT JOIN biblioitems on (items.biblioitemnumber=biblioitems.biblioitemnumber) LEFT JOIN biblio on (biblioitems.biblionumber=biblio.biblionumber)   WHERE items.itype='XXX' AND items.homebranch='OVERBROOK'



