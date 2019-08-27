/*
R.002071

----------

Name: Circulation History (old_issues) Counts for All Borrowers
Created by: Heather Braum

----------

Group: Administrative Reports
     Circ Stats-admin

Created on: 2013-10-29 15:58:05
Modified on: 2015-09-11 12:32:18
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowernumber, count(timestamp) FROM old_issues GROUP BY borrowernumber ORDER BY count(timestamp) DESC LIMIT 100



