/*
R.001179

----------

Name: Entire Collection Size by IType
Created by: Heather Braum

----------

Group: Administrative Reports
     Collection Stats-admin

Created on: 2011-09-01 13:56:43
Modified on: 2013-09-25 16:38:03
Date last run: 2020-10-20 15:48:08

----------

Public: 0
Expiry: 0

----------

#count

----------
*/

SELECT itype, count(itemnumber) as items FROM items GROUP BY itype ORDER BY itype asc 



