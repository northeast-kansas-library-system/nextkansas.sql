/*
R.001666

----------

Name: Collection size by Collection Code
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Collection Statistics

Created on: 2012-12-03 21:24:29
Modified on: 2013-06-23 12:36:09
Date last run: 2021-07-01 23:18:58

----------

Public: 0
Expiry: 0

----------

Enhanced - Just Run > Pick branch > done! #count

----------
*/

SELECT ccode, homebranch,count(itemnumber) as items FROM items WHERE items.homebranch = <<Pick your Branch|branches>> GROUP BY ccode ORDER BY itype asc 



