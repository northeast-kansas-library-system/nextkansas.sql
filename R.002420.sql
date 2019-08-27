/*
R.002420

----------

Name: Total Items added in a Year
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2014-12-03 20:25:09
Modified on: 2014-12-03 20:25:09
Date last run: 2019-01-22 12:17:17

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT count(i.itemnumber) as added from items i WHERE i.homebranch=<<branch|branches>> AND year(i.dateaccessioned) = <<enter four-digit year>>



