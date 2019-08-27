/*
R.001437

----------

Name: Entire collection -- count of specific ccode by library
Created by: Heather Braum

----------

Group: Administrative Reports
     Collection Stats-admin

Created on: 2012-05-31 14:45:38
Modified on: 2013-11-17 14:34:17
Date last run: 2018-12-10 23:16:00

----------

Public: 0
Expiry: 0

----------

#count

----------
*/

SELECT homebranch, location, count(itemnumber) as items FROM items WHERE ccode= <<ccode|CCODE>> GROUP BY homebranch, location ORDER BY homebranch, location



