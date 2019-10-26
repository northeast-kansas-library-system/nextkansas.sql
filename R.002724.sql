/*
R.002724

----------

Name: OVERBROOK CD
Created by: OVERBROOK TECH

----------

Group: -
     -

Created on: 2016-08-08 13:16:36
Modified on: 2016-08-08 13:21:24
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT items.barcode,items.dateaccessioned,items.replacementprice,biblio.author,biblio.title,items.itemcallnumber FROM items LEFT JOIN biblioitems on (items.biblioitemnumber=biblioitems.biblioitemnumber) LEFT JOIN biblio on (biblioitems.biblionumber=biblio.biblionumber)   WHERE items.homebranch='OVERBROOK' AND items.itemcallnumber >= 'CD' AND items.itemcallnumber <= 'CDZ' GROUP BY items.itemcallnumber ORDER BY items.itemcallnumber asc


