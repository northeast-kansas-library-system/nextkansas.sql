/*
R.001165

----------

Name: Basehor Lost 
Created by: BASEHOR TECH

----------

Group:  BASEHOR
     -

Created on: 2011-08-15 15:42:56
Modified on: 2021-08-16 20:43:45
Date last run: 2022-05-10 08:10:21

----------

Public: 0
Expiry: 0

----------

Lost items by Collection code

----------
*/



SELECT items.datelastseen, title, items.barcode, itemcallnumber
FROM items RIGHT JOIN biblio on (items.biblionumber=biblio.biblionumber) 
WHERE itemlost in (1,3) AND items.homebranch="BASEHOR" AND items.ccode= "DVD" 
ORDER BY itemcallnumber, title

























