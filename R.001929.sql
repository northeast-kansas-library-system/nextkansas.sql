/*
R.001929

----------

Name: Monthly Circ by Ccode, Location, Limited by Library
Created by: Heather Braum

----------

Group: -
     -

Created on: 2013-07-07 19:50:37
Modified on: 2017-09-22 09:05:55
Date last run: 2022-04-01 12:18:20

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT IF(items.ccode IS NULL AND deleteditems.ccode IS NULL, NULL, CONCAT(COALESCE(items.ccode,''), COALESCE(deleteditems.ccode,''))) AS ccode, IF(items.location IS NULL AND deleteditems.location IS NULL, NULL, CONCAT(COALESCE(items.location,''), COALESCE(deleteditems.location,''))) AS location, Count(*) AS count  FROM statistics LEFT JOIN items USING(itemnumber) LEFT JOIN deleteditems USING(itemnumber) WHERE statistics.branch=<<branch|branches>> AND statistics.type IN ('issue','renew','localuse') AND month(statistics.datetime) = <<Choose month|Month>> AND year(statistics.datetime) = <<Choose year|Year>> GROUP BY ccode, location

























