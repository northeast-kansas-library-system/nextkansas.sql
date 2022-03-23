/*
R.001653

----------

Name: Monthly New Materials by Ccode (branch-specific)
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Monthly

Created on: 2012-11-29 01:46:31
Modified on: 2014-01-08 16:46:15
Date last run: 2022-03-08 10:43:11

----------

Public: 0
Expiry: 0

----------

Shows count of new items added to a collection in last month by ccode and shelving location. Choose Branch.

----------
*/



SELECT count(itemnumber) as added, ccode, location from items WHERE homebranch=<<branch|branches>> AND month(dateaccessioned) =<<enter two digit month, ex. 02>> AND year (dateaccessioned) = <<enter four digit year>> GROUP BY ccode,location ORDER BY ccode,location asc

























