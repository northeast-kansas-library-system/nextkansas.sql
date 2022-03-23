/*
R.002153

----------

Name: Total Circulation for a Year (limited by branch)
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2014-01-13 17:24:22
Modified on: 2014-01-17 16:57:44
Date last run: 2021-12-21 13:51:14

----------

Public: 0
Expiry: 0

----------

Choose branch, enter four-digit-year

----------
*/



SELECT Count(*) AS count  FROM statistics WHERE statistics.branch=<<branch|branches>> AND statistics.type IN ('issue','renew','localuse') AND year(statistics.datetime) = <<enter year>> 

























