/*
R.002144

----------

Name: Yearly Circulation by Branch by Itype and Location ADMINREPORT
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2014-01-06 13:39:35
Modified on: 2024-03-01 15:44:07
Date last run: 2023-07-28 17:04:21

----------

Public: 0
Expiry: 0

----------

DO NOT RUN DURING NORMAL HOURS!! Enter year and choose branch. Run.

----------
*/



SELECT IF(items.itype IS NULL AND deleteditems.itype IS NULL, NULL, CONCAT(COALESCE(items.itype,''), COALESCE(deleteditems.itype,''))) AS itype, IF(items.location IS NULL AND deleteditems.location IS NULL, NULL, CONCAT(COALESCE(items.location,''), COALESCE(deleteditems.location,''))) AS location, Count(*) AS count  FROM statistics LEFT JOIN items USING(itemnumber) LEFT JOIN deleteditems USING(itemnumber) WHERE statistics.branch=<> AND statistics.type IN ('issue','renew','localuse') AND year(statistics.datetime) = <> 
GROUP BY statistics.branch, itype, location 
ORDER BY statistics.branch, itype, location

























