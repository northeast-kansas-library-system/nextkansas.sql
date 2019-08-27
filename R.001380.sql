/*
R.001380

----------

Name: Entire Collection Size by Ccode
Created by: Heather Braum

----------

Group: Administrative Reports
     Collection Stats-admin

Created on: 2012-05-11 13:46:32
Modified on: 2013-09-25 16:30:05
Date last run: 2018-12-10 23:15:33

----------

Public: 0
Expiry: 0

----------

#count

----------
*/

SELECT ccode, count(itemnumber) as items FROM items GROUP BY ccode ORDER BY ccode asc 



