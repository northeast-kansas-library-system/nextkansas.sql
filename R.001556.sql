/*
R.001556

----------

Name: Count of total holdings
Created by: Heather Braum

----------

Group: Administrative Reports
     Collection Stats-admin

Created on: 2012-09-24 09:58:03
Modified on: 2016-06-01 10:29:32
Date last run: 2017-06-05 00:20:26

----------

Public: 0
Expiry: 0

----------

Count of entire holdings in NExpress

----------
*/

SELECT count(items.itemnumber) from items WHERE dateaccessioned < <<Choose date (usually first of month, to count total holdings through end of previous month|date>>



