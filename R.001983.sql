/*
R.001983

----------

Name: All PH School Patrons
Created by: Heather Braum

----------

Group: Administrative Reports
     School Libraries-admin

Created on: 2013-08-12 10:10:15
Modified on: 2014-08-19 22:33:22
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT * FROM borrowers  WHERE branchcode IN ('PHSES','PHSMS','PHSHS','PHWAC','PHAXTELL')



