/*
R.001187

----------

Name: Collection size by Shelving Location
Created by: -

----------

Group: Catalog Records and Items
     Collection Statistics

Created on: 2011-09-06 17:01:39
Modified on: 2013-09-21 16:19:41
Date last run: 2020-10-20 15:45:07

----------

Public: 0
Expiry: 0

----------

Enhanced - Run, pick and go... #count

----------
*/

SELECT location, homebranch,count(itemnumber) as items FROM items WHERE items.homebranch = <<Pick your branch|branches>> GROUP BY location ORDER BY location asc 



