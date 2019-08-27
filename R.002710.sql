/*
R.002710

----------

Name: Lost at other location
Created by: ATCHISON TECH

----------

Group: -
     -

Created on: 2016-07-13 11:45:21
Modified on: 2016-07-13 11:45:21
Date last run: 2017-05-24 10:34:48

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT  items.barcode,items.homebranch,items.replacementprice,items.itemlost,items.itemlost_on,items.holdingbranch,items.paidfor,items.itemcallnumber FROM items LEFT JOIN biblioitems on (items.biblioitemnumber=biblioitems.biblioitemnumber) LEFT JOIN biblio on (biblioitems.biblionumber=biblio.biblionumber)   WHERE items.holdingbranch=<<holdingbranch|branches>> AND items.homebranch=<<homebranch|branches>> AND items.itemlost=<<itemlost>> ORDER BY items.itemlost_on desc



