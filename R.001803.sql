/*
R.001803

----------

Name: Sort 1 field for SES without grade
Created by: Heather Braum

----------

Group: School Libraries
     Students

Created on: 2013-04-21 17:28:11
Modified on: 2014-08-19 22:28:56
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowers.sort1 as 'teacher' FROM borrowers WHERE branchcode='PHSES' GROUP by borrowers.sort1 ORDER BY sort1 LIMIT 1000



