/*
R.002386

----------

Name: Adult patron email list
Created by: SABETHA TECH

----------

Group: Patrons
     -

Created on: 2014-09-29 16:46:12
Modified on: 2014-09-29 16:46:12
Date last run: 2019-07-01 11:13:46

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT  borrowers.surname,borrowers.firstname,borrowers.address,borrowers.city,borrowers.email,borrowers.categorycode FROM borrowers   WHERE borrowers.branchcode='SABETHA' AND borrowers.categorycode='ADULT'



