/*
R.002168

----------

Name: Total Circ of a Library's Items in a Year (All Branches)
Created by: Heather Braum

----------

Group: Administrative Reports
     Daily, Monthly, Yearly Stats-admin

Created on: 2014-01-17 17:09:28
Modified on: 2014-01-17 17:09:28
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT items.homebranch, count(*) FROM statistics, items WHERE statistics.itemnumber=items.itemnumber AND statistics.type IN ('issue','renew','localuse') AND year(statistics.datetime) = '2013' GROUP BY items.homebranch



