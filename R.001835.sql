/*
R.001835

----------

Name: Local Holds at libraries
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Local Hold - Walkins

Created on: 2013-05-13 20:37:56
Modified on: 2014-04-25 15:47:56
Date last run: 2021-10-06 10:31:11

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT homebranch, count(itemnumber) FROM items WHERE itype IN ('LOCALHOLD','LOCALHOLD1','LOCALHOLD2') GROUP BY homebranch ORDER BY homebranch LIMIT 10000

























