/*
R.002005

----------

Name: Wetmore students
Created by: Heather Braum

----------

Group: Administrative Reports
     School Libraries-admin

Created on: 2013-08-16 11:57:03
Modified on: 2013-11-17 12:33:24
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowernumber,cardnumber,surname,firstname,othernames,email,dateofbirth,branchcode,categorycode,sort1 FROM borrowers WHERE branchcode='PHWAC' AND categorycode='STUDENT'



