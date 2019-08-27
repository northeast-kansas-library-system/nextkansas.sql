/*
R.001413

----------

Name: Collection Size by Item Type & Location (per branch)
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Collection Statistics

Created on: 2012-05-14 23:10:39
Modified on: 2015-11-16 18:12:07
Date last run: 2019-06-24 16:30:50

----------

Public: 0
Expiry: 0

----------

Enchanced -- Choose Branch. (On Reports Webpages, 5/14/12). #count

----------
*/

SELECT itype, location, count(itemnumber) as items FROM items WHERE homebranch = <<Pick your branch|branches>> GROUP BY itype, location ORDER BY itype asc 



