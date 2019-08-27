/*
R.002072

----------

Name: Current Circulation Counts (issues) for All Borrowers
Created by: Heather Braum

----------

Group: Administrative Reports
     Circ Stats-admin

Created on: 2013-10-29 16:00:38
Modified on: 2015-09-11 12:32:34
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowernumber, count(timestamp) FROM issues GROUP BY borrowernumber ORDER BY count(timestamp) DESC LIMIT 100



