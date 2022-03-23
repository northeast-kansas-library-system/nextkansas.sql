/*
R.002143

----------

Name: Yearly Circulation by Branch by CCode and Location
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2014-01-06 13:37:54
Modified on: 2014-01-08 16:33:34
Date last run: 2022-01-02 13:10:40

----------

Public: 0
Expiry: 0

----------

DO NOT RUN DURING NORMAL HOURS!! Enter year and choose branch. Run.

----------
*/



SELECT IF(items.ccode IS NULL AND deleteditems.ccode IS NULL, NULL, CONCAT(COALESCE(items.ccode,''), COALESCE(deleteditems.ccode,''))) AS ccode, IF(items.location IS NULL AND deleteditems.location IS NULL, NULL, CONCAT(COALESCE(items.location,''), COALESCE(deleteditems.location,''))) AS location, Count(*) AS count  FROM statistics LEFT JOIN items USING(itemnumber) LEFT JOIN deleteditems USING(itemnumber) WHERE statistics.branch=<<branch|branches>> AND statistics.type IN ('issue','renew','localuse') AND year(statistics.datetime) = <<enter year>> 
GROUP BY ccode, location 
ORDER BY ccode, location

























