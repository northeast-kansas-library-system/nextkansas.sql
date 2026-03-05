/*
R.002153

----------

Name: Total Circulation for a Year (limited by branch) ADMINREPORT
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2014-01-13 17:24:22
Modified on: 2024-03-01 15:44:23
Date last run: 2026-01-06 16:44:18

----------

Public: 0
Expiry: 0

----------

Choose branch, enter four-digit-year

----------
*/



SELECT Count(&ast;) AS count  FROM statistics WHERE statistics.branch=&lt;&gt; AND statistics.type IN ('issue','renew','localuse') AND year(statistics.datetime) = &lt;&gt; 

























