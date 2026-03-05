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
Date last run: 2025-06-30 13:39:15

----------

Public: 0
Expiry: 0

----------

Shows count of new items added to a collection in last month by ccode and shelving location. Choose Branch.

----------
*/



SELECT count(itemnumber) as added, ccode, location from items WHERE homebranch=&lt;&gt; AND month(dateaccessioned) =&lt;&gt; AND year (dateaccessioned) = &lt;&gt; GROUP BY ccode,location ORDER BY ccode,location asc

























