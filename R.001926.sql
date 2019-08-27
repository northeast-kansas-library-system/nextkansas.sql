/*
R.001926

----------

Name: Monthly 002 Total Circulation
Created by: Heather Braum

----------

Group: -
     -

Created on: 2013-07-03 08:01:48
Modified on: 2016-10-05 16:15:18
Date last run: 2017-07-10 09:52:21

----------

Public: 0
Expiry: 0

----------

Monthly Total Circ

----------
*/

SELECT statistics.branch as "Library", count(*) as "Total Circ" FROM statistics WHERE statistics.type IN ('issue','renew','localuse') AND year(statistics.datetime) = <<Choose Year|YEAR>> AND month(statistics.datetime) = <<Choose Month|MONTH>> GROUP BY statistics.branch ORDER BY statistics.branch



