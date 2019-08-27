/*
R.001890

----------

Name: Count of Patrons Per Zipcode
Created by: Heather Braum

----------

Group: Patrons
     Patron Statistics

Created on: 2013-05-28 09:47:50
Modified on: 2018-12-04 13:05:04
Date last run: 2018-12-13 16:08:34

----------

Public: 0
Expiry: 0

----------

Choose branch
Updated 12/2018 by Robin - now gives correct count of patrons

----------
*/

SELECT borrowers.zipcode, COUNT(DISTINCT borrowers.borrowernumber) AS 'Patrons' FROM borrowers WHERE borrowers.branchcode = <<Select your branch|branches>> GROUP BY borrowers.zipcode



