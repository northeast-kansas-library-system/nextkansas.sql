/*
R.002594

----------

Name: New items added in a month by itype and location for Overbrook
Created by: Heather Braum

----------

Group: Library-Specific
     Overbrook

Created on: 2015-08-28 05:54:05
Modified on: 2016-07-01 12:25:53
Date last run: 2019-05-28 13:39:42

----------

Public: 0
Expiry: 0

----------

For when Overbrook needs stats early.

----------
*/

SELECT i.itype as "Item Type", i.location as "Location", count(i.biblionumber) as "Total Added" FROM items i WHERE month(i.dateaccessioned) = <<choose Month|Month>> AND year (i.dateaccessioned) = <<Choose Year|Year>> AND i.homebranch='OVERBROOK' GROUP BY i.homebranch,i.itype,i.location ORDER BY i.homebranch,i.itype,i.location ASC



