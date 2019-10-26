/*
R.002074

----------

Name: Count of all old holds (old_reserves) placed by all borrowers
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2013-10-29 16:03:15
Modified on: 2015-09-11 12:33:09
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowernumber, count(reserve_id) FROM old_reserves GROUP BY borrowernumber ORDER BY count(timestamp) DESC LIMIT 100


