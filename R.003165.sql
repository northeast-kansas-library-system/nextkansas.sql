/*
R.003165

----------

Name: 1930 report for 2019
Created by: BASEHOR DIRECTOR

----------

Group: Circulation
     -

Created on: 2019-02-01 09:25:45
Modified on: 2019-02-01 09:25:45
Date last run: 2020-01-22 14:27:20

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT IF(items.itype IS NULL AND deleteditems.itype IS NULL, NULL, CONCAT(COALESCE(items.itype,''), COALESCE(deleteditems.itype,''))) AS itype, IF(items.location IS NULL AND deleteditems.location IS NULL, NULL, CONCAT(COALESCE(items.location,''), COALESCE(deleteditems.location,''))) AS location, Count(*) AS count  FROM statistics LEFT JOIN items USING(itemnumber) LEFT JOIN deleteditems USING(itemnumber) WHERE statistics.branch='BASEHOR' AND statistics.type IN ('issue','renew','localuse') AND month(statistics.datetime) = '01' AND year(statistics.datetime) = '2019' GROUP BY itype, location ORDER BY itype, location



