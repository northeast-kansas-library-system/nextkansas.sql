/*
R.001811

----------

Name: Itemtypes in use at Prairie Hills Schools
Created by: Heather Braum

----------

Group: Administrative Reports
     School Libraries-admin

Created on: 2013-04-29 10:17:30
Modified on: 2014-08-19 22:31:23
Date last run: 2019-04-05 14:01:45

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT homebranch, itype, count(itemnumber) FROM items WHERE homebranch IN ('PHAXTELL','PHSMS','PHSES','PHSHS','PHWAC') GROUP BY homebranch, itype ORDER BY homebranch, itype LIMIT 100



