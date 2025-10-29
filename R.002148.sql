/*
R.002148

----------

Name: Yearly Deleted Materials by CCode (branch-specific)
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2014-01-08 16:25:53
Modified on: 2014-01-08 16:25:53
Date last run: 2025-09-11 16:29:02

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT count(itemnumber) as deleted, ccode, location from deleteditems WHERE homebranch=<> AND year(timestamp) = <> GROUP BY ccode,location ORDER BY  ccode,location 

























