/*
R.002073

----------

Name: Current Holds Counts (reserves) for All Borrowers
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2013-10-29 16:01:50
Modified on: 2015-09-11 12:32:58
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowernumber, count(reserve_id) FROM reserves GROUP BY borrowernumber ORDER BY count(timestamp) DESC LIMIT 100



