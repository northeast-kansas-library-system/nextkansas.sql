/*
R.001700

----------

Name: Number of items deleted in a calendar year (entire catalog)
Created by: Heather Braum

----------

Group: Administrative Reports
     Daily, Monthly, Yearly Stats-admin

Created on: 2013-01-07 17:07:34
Modified on: 2014-01-07 14:14:03
Date last run: 2017-12-20 19:43:47

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT homebranch, count(itemnumber) FROM deleteditems WHERE year(timestamp)=<<YEAR>> GROUP BY homebranch ORDER BY homebranch


