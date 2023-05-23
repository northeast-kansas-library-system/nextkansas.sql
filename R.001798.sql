/*
R.001798

----------

Name: Patron Report for Schools
Created by: Heather Braum

----------

Group: School Libraries
     Students

Created on: 2013-04-19 13:58:48
Modified on: 2014-08-19 22:28:47
Date last run: 2023-04-26 11:38:01

----------

Public: 0
Expiry: 0

----------

Lists name, cardnumber, and grade. Limits on branch and grade. 

----------
*/



SELECT CONCAT (borrowers.firstname,' ',borrowers.surname) AS name, borrowers.cardnumber, borrower_attributes.attribute as 'grade' FROM borrowers LEFT JOIN borrower_attributes USING (borrowernumber) WHERE borrowers.branchcode=<<branch|branches>> AND borrower_attributes.attribute=<<grade|GRADE>> ORDER BY borrowers.surname LIMIT 300

























