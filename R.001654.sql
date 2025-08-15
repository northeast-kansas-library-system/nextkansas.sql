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
Date last run: 2025-08-10 18:30:59

----------

Public: 0
Expiry: 0

----------

Shows count of new items added to a collection in last month by item type and shelving location. Choose Branch

----------
*/



SELECT count(itemnumber) as added, itype, location FROM items WHERE homebranch=&lt;&gt; AND month(dateaccessioned) = &lt;&gt; AND year(dateaccessioned) = &lt;&gt; GROUP BY itype,location ORDER BY itype,location ASC

























