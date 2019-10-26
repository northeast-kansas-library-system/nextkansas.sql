/*
R.002125

----------

Name: Coatney Collection
Created by: LINWOOD TECH

----------

Group: Library-Specific
     Linwood

Created on: 2013-12-06 11:37:39
Modified on: 2015-12-05 20:37:12
Date last run: -

----------

Public: 0
Expiry: 0

----------

This one is correct -- updated by hb, 12/2015. 

----------
*/

SELECT title, author, holdingbranch as "current library location", location, itemcallnumber, barcode FROM items left join biblio USING(biblionumber) WHERE homebranch='linwood' and itemcallnumber like 'cc %' order by itemcallnumber


