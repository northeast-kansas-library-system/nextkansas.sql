/*
R.001124

----------

Name: Collection size by Item Type
Created by: -

----------

Group: Catalog Records and Items
     Collection Statistics

Created on: 2011-06-06 12:29:35
Modified on: 2013-06-19 12:50:24
Date last run: 2019-08-06 16:43:36

----------

Public: 0
Expiry: 0

----------

Enhanced - Just Run > Pick branch > done! #count

----------
*/

SELECT itype, homebranch,count(itemnumber) as items FROM items WHERE items.homebranch = <<Pick your Branch|branches>> GROUP BY itype ORDER BY itype asc 



