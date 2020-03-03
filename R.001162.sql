/*
R.001162

----------

Name: Collection Value
Created by: BASEHOR TECH

----------

Group: Catalog Records and Items
     Collection Statistics

Created on: 2011-08-11 16:22:06
Modified on: 2013-09-21 16:29:49
Date last run: 2020-03-02 14:01:51

----------

Public: 0
Expiry: 0

----------

Enhanced - Select your library and run to get a list of collection codes and the total value of each collection sorted by shelf location. #special

----------
*/

SELECT location as Shelf, ccode as Collection, count(itemnumber) as items, sum(replacementprice) as value FROM items WHERE items.homebranch = <<branch|branches>> GROUP BY location,ccode ORDER BY location,ccode asc 



