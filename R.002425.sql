/*
R.002425

----------

Name: Call_Number_Test1
Created by: BURLINGAME TECH

----------

Group: Library-Specific
     Burlingame

Created on: 2014-12-13 12:49:54
Modified on: 2014-12-13 13:32:01
Date last run: 2019-06-30 21:18:00

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT  biblio.title,items.itype,items.cn_source,items.itemcallnumber, biblioitems.collectiontitle
FROM items
LEFT JOIN biblioitems on (items.biblioitemnumber=biblioitems.biblioitemnumber)
LEFT JOIN biblio on (biblioitems.biblionumber=biblio.biblionumber) 
WHERE items.homebranch='BURLINGAME'
AND items.barcode='0003038003928'



