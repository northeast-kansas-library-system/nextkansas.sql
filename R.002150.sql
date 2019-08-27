/*
R.002150

----------

Name: Monthly Deleted Materials by Itype (branch-specific)
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Monthly

Created on: 2014-01-08 16:46:55
Modified on: 2014-01-08 16:48:12
Date last run: 2018-08-01 15:56:50

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT count(itemnumber) as deleted, itype, location from deleteditems WHERE homebranch=<<branch|branches>> AND month(timestamp) =<<enter two digit month, ex. 02>> AND year (timestamp) = <<enter four digit year>> GROUP BY itype,location ORDER BY itype,location asc



