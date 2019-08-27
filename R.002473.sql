/*
R.002473

----------

Name: Total Items Added in a time period, by collection code & shelving location {for doniphan}
Created by: Heather Braum

----------

Group: Library-Specific
     Doniphan

Created on: 2015-03-20 15:01:15
Modified on: 2015-03-20 15:02:00
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT ccode, location, count(itemnumber) FROM items WHERE homebranch LIKE 'DONI%' AND dateaccessioned BETWEEN <<enter start date, yyyy-mm-dd format, ex. 2014-01-01>> AND <<enter end date, yyyy-mm-dd format, ex 2014-12-31>> GROUP BY ccode, location



