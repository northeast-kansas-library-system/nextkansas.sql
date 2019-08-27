/*
R.002157

----------

Name: Yearly Circ by Shelving Location (All Branches)
Created by: Heather Braum

----------

Group: Administrative Reports
     Daily, Monthly, Yearly Stats-admin

Created on: 2014-01-14 13:20:51
Modified on: 2014-01-14 13:25:26
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT statistics.branch, IF(items.location IS NULL AND deleteditems.location IS NULL, NULL, CONCAT(COALESCE(items.location,''), COALESCE(deleteditems.location,''))) AS location, Count(*) AS count  FROM statistics LEFT JOIN items USING(itemnumber) LEFT JOIN deleteditems USING(itemnumber) WHERE statistics.type IN ('issue','renew','localuse') AND year(statistics.datetime) = <<enter year>> 
GROUP BY statistics.branch, location 
ORDER BY statistics.branch, location



