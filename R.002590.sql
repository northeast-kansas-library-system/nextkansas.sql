/*
R.002590

----------

Name: Total Collection Size for Overbrook for a month
Created by: Heather Braum

----------

Group: Library-Specific
     Overbrook

Created on: 2015-08-28 05:48:55
Modified on: 2016-07-01 12:21:49
Date last run: -

----------

Public: 0
Expiry: 0

----------

For whenever Overbrook needs their stats earlier than normal. 

----------
*/

SELECT count(*) as "total collection size" FROM items WHERE homebranch='OVERBROOK' AND dateaccessioned < <<Choose first of the next month, to count previous month (example 7/1/16 for June numbers)|date>>



