/*
R.001786

----------

Name: Borrowers list
Created by: Heather Braum

----------

Group: Patrons
     -

Created on: 2013-04-05 10:33:49
Modified on: 2013-09-21 16:25:54
Date last run: 2018-11-06 14:31:33

----------

Public: 0
Expiry: 0

----------

Choose branch.

----------
*/

SELECT firstname, surname, address, address2, city, state, zipcode, email, categorycode, dateenrolled, dateexpiry FROM borrowers WHERE branchcode=<<choose branch|branches>> ORDER BY surname



