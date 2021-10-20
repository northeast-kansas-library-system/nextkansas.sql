/*
R.001971

----------

Name: Total Circ for a Month for Entire NExpress
Created by: Heather Braum

----------

Group: Administrative Reports
     Circ Stats-admin

Created on: 2013-08-02 12:58:40
Modified on: 2016-06-01 10:38:07
Date last run: 2019-03-06 10:12:29

----------

Public: 0
Expiry: 0

----------

circulation for a month for all of NExpress

----------
*/



SELECT count(*) FROM statistics LEFT JOIN items USING(itemnumber) WHERE  year(statistics.datetime) = <<Choose year|YEAR>> AND  month(statistics.datetime) = <<Choose month|MONTH>> AND statistics.type IN ('issue','renew','localuse')

























