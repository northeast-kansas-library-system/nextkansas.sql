/*
R.002237

----------

Name: Circulation of your library's materials at your library in a month, by collection code and location
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Monthly

Created on: 2014-04-02 17:51:21
Modified on: 2014-04-02 17:54:56
Date last run: 2023-01-13 16:16:10

----------

Public: 0
Expiry: 0

----------

Choose your branch three times. Gives the circulation of your materials at your library in a given month by collection code and location

----------
*/



SELECT IF(items.ccode IS NULL AND deleteditems.ccode IS NULL, NULL, CONCAT(COALESCE(items.ccode,''), COALESCE(deleteditems.ccode,''))) AS ccode, IF(items.location IS NULL AND deleteditems.location IS NULL, NULL, CONCAT(COALESCE(items.location,''), COALESCE(deleteditems.location,''))) AS location, Count(*) AS count  FROM statistics LEFT JOIN items USING(itemnumber) LEFT JOIN deleteditems USING(itemnumber) WHERE statistics.branch=<<choose branch|branches>> AND statistics.type IN ('issue','renew','localuse') AND month(statistics.datetime) = <<enter two-digit month (ex, 03 for March)>> AND year(statistics.datetime) = <<enter four-digit year (ex, 2014)>> AND (items.homebranch=<<choose branch|branches>> OR deleteditems.homebranch=<<choose branch|branches>>) GROUP BY ccode, location

























