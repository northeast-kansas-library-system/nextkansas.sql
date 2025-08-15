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
Date last run: 2025-02-20 16:08:14

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT count(itemnumber) as added, itype, location from items WHERE homebranch=&lt;&gt; AND year(dateaccessioned) = &lt;&gt; GROUP BY itype,location ORDER BY  itype,location 

























