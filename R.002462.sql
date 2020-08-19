/*
R.002462

----------

Name: Holds Queue numbers
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2015-02-12 21:15:52
Modified on: 2015-02-12 21:17:15
Date last run: 2020-08-19 10:00:03

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT current_timestamp() as "report time", t.holdingbranch, count(*) 
FROM tmp_holdsqueue t
GROUP BY t.holdingbranch
ORDER BY t.holdingbranch ASC
LIMIT 800



