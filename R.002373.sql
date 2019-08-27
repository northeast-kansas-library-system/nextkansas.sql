/*
R.002373

----------

Name: Count of Patrons by Birth Year
Created by: Heather Braum

----------

Group: Patrons
     Patron Statistics

Created on: 2014-09-11 09:28:40
Modified on: 2014-09-11 10:53:05
Date last run: 2018-04-23 16:55:46

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT year(dateofbirth), count(*) FROM borrowers WHERE branchcode=<<choose branch|branches>> GROUP BY year(dateofbirth)



