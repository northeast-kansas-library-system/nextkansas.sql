/*
R.001927

----------

Name: Total borrowers in NExpress
Created by: Heather Braum

----------

Group: Administrative Reports
     Collection Stats-admin

Created on: 2013-07-03 08:05:20
Modified on: 2016-06-01 10:34:43
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT COUNT(borrowernumber) FROM borrowers WHERE dateenrolled < <<Choose date (usually first of month, to count total patrons in system through end of previous month|date>>



