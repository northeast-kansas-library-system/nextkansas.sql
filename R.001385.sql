/*
R.001385

----------

Name: Entire collection size by location
Created by: Heather Braum

----------

Group: Administrative Reports
     Collection Stats-admin

Created on: 2012-05-11 18:11:35
Modified on: 2013-09-25 16:38:10
Date last run: 2020-06-18 10:16:37

----------

Public: 0
Expiry: 0

----------

#count

----------
*/

SELECT location, count(itemnumber) as items FROM items GROUP BY location ORDER BY location asc 



