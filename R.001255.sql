/*
R.001255

----------

Name: Basehor patrons
Created by: BASEHOR DIRECTOR

----------

Group: Library-Specific
     -

Created on: 2011-12-10 18:27:42
Modified on: 2013-06-17 01:07:09
Date last run: 2018-02-28 13:36:43

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowers.email FROM borrowers WHERE borrowers.branchcode ='BASEHOR' ORDER BY borrowers.surname ASC



