/*
R.002144

----------

Name: Yearly Circulation by Branch by Itype and Location
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2014-01-06 13:39:35
Modified on: 2014-01-08 16:33:40
Date last run: 2021-07-09 15:25:51

----------

Public: 0
Expiry: 0

----------

DO NOT RUN DURING NORMAL HOURS!! Enter year and choose branch. Run.

----------
*/

SELECT IF(items.itype IS NULL AND deleteditems.itype IS NULL, NULL, CONCAT(COALESCE(items.itype,''), COALESCE(deleteditems.itype,''))) AS itype, IF(items.location IS NULL AND deleteditems.location IS NULL, NULL, CONCAT(COALESCE(items.location,''), COALESCE(deleteditems.location,''))) AS location, Count(*) AS count  FROM statistics LEFT JOIN items USING(itemnumber) LEFT JOIN deleteditems USING(itemnumber) WHERE statistics.branch=<<branch|branches>> AND statistics.type IN ('issue','renew','localuse') AND year(statistics.datetime) = <<enter year>> 
GROUP BY statistics.branch, itype, location 
ORDER BY statistics.branch, itype, location



