/*
R.001654

----------

Name: Monthly New Materials by Itype (branch-specific)
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Monthly

Created on: 2012-11-29 01:48:34
Modified on: 2014-01-08 16:45:58
Date last run: 2021-01-11 11:30:26

----------

Public: 0
Expiry: 0

----------

Shows count of new items added to a collection in last month by item type and shelving location. Choose Branch

----------
*/

SELECT count(itemnumber) as added, itype, location FROM items WHERE homebranch=<<branch|branches>> AND month(dateaccessioned) = <<enter two-digit month, ex. 02>> AND year(dateaccessioned) = <<enter four-digit year>> GROUP BY itype,location ORDER BY itype,location ASC



