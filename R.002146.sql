/*
R.002146

----------

Name: Yearly New Materials Added by Itype (branch-specific)
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2014-01-08 16:22:50
Modified on: 2016-02-23 15:02:01
Date last run: 2021-01-27 13:41:30

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT count(itemnumber) as added, itype, location from items WHERE homebranch=<<branch|branches>> AND year(dateaccessioned) = <<year|Year>> GROUP BY itype,location ORDER BY  itype,location 

























