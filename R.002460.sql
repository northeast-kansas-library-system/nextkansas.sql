/*
R.002460

----------

Name: unknown
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-02-12 09:17:07
Modified on: 2015-12-09 15:25:59
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT homebranch, itemlost, count(*) from items where itemlost not in ('0','1','3','5') group by homebranch, itemlost 



