/*
R.001802

----------

Name: Sort 1 Field for SES with grade
Created by: Heather Braum

----------

Group: School Libraries
     Students

Created on: 2013-04-21 17:13:56
Modified on: 2014-08-19 22:28:50
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowers.borrowernumber, borrowers.sort1 as 'teacher', borrower_attributes.attribute as 'grade' FROM borrowers LEFT JOIN borrower_attributes USING(borrowernumber) WHERE branchcode='PHSES' AND borrower_attributes.code IN ('GRADE') ORDER BY borrower_attributes.attribute, sort1 LIMIT 1000



