/*
R.002577

----------

Name: For patron card creator tool if needed to be updated
Created by: Heather Braum

----------

Group: Administrative Reports
     School Libraries-admin

Created on: 2015-08-19 14:38:10
Modified on: 2015-08-19 14:38:10
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT branchcode, othernames, GROUP_CONCAT(borrowernumber ORDER BY surname, firstname) FROM borrowers WHERE categorycode='student' and branchcode LIKE 'ph%' and dateexpiry='2016-08-31' GROUP BY branchcode, othernames



