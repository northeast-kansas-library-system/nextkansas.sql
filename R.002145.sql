/*
R.002145

----------

Name: Yearly New Materials Added by Ccode (branch-specific)
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2014-01-08 16:03:15
Modified on: 2016-02-23 15:01:06
Date last run: 2020-10-20 11:53:21

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT count(i.itemnumber) as added, i.ccode, i.location from items i WHERE i.homebranch=<<branch|branches>> AND year(i.dateaccessioned) = <<year|Year>> GROUP BY i.ccode,i.location ORDER BY i.ccode,i.location asc



