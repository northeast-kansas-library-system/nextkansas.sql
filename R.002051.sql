/*
R.002051

----------

Name: Count of holds per library on holds list at any given time
Created by: Heather Braum

----------

Group: Holds-Reserves
     -

Created on: 2013-10-18 11:15:55
Modified on: 2013-10-31 14:30:53
Date last run: 2020-11-05 11:16:34

----------

Public: 0
Expiry: 0

----------

Shows counts of all holds at libraries on the holds queue. 

----------
*/

SELECT i.holdingbranch, (SELECT count(t.itemnumber) FROM tmp_holdsqueue t WHERE t.holdingbranch=i.holdingbranch GROUP BY t.holdingbranch) as count FROM items i GROUP BY i.holdingbranch ORDER BY i.holdingbranch LIMIT 100



