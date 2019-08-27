/*
R.002238

----------

Name: Circulation of your library's materials at your library in a month, by item type and location
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Monthly

Created on: 2014-04-02 17:55:00
Modified on: 2014-04-24 11:09:32
Date last run: 2018-05-15 17:23:56

----------

Public: 0
Expiry: 0

----------

Choose your branch three times. Gives the circulation of your materials at your library in a given month, by item type and location

----------
*/

SELECT IF(items.itype IS NULL AND deleteditems.itype IS NULL, NULL, CONCAT(COALESCE(items.itype,''), COALESCE(deleteditems.itype,''))) AS itype, IF(items.location IS NULL AND deleteditems.location IS NULL, NULL, CONCAT(COALESCE(items.location,''), COALESCE(deleteditems.location,''))) AS location, Count(*) AS count  FROM statistics LEFT JOIN items USING(itemnumber) LEFT JOIN deleteditems USING(itemnumber) WHERE statistics.branch=<<choose branch|branches>> AND statistics.type IN ('issue','renew','localuse') AND year(statistics.datetime) = <<enter four-digit year (ex, 2014)>> AND month(statistics.datetime) = <<enter two-digit month (ex. 02)>> AND (items.homebranch=<<choose branch|branches>> OR deleteditems.homebranch=<<choose branch|branches>>) GROUP BY itype, location



