/*
R.001317

----------

Name: Patrons, added prior to 2013
Created by: -

----------

Group: Patrons
     Patron Statistics

Created on: 2012-02-10 13:36:59
Modified on: 2013-06-16 16:39:21
Date last run: 2018-10-09 18:31:51

----------

Public: 0
Expiry: 0

----------

Select your library from dropdown

----------
*/

SELECT branchcode, count(*) FROM borrowers WHERE borrowers.branchcode=<<Select your branch|branches>> AND branchcode IS NOT NULL AND categorycode is not null AND dateenrolled <'2013-01-01' group by branchcode





