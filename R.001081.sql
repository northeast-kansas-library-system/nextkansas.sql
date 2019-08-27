/*
R.001081

----------

Name: Total Number of Borrowers
Created by: -

----------

Group: Patrons
     Patron Statistics

Created on: 2011-03-31 16:22:36
Modified on: 2013-06-23 12:27:09
Date last run: 2019-08-09 12:21:41

----------

Public: 0
Expiry: 0

----------

Enhanced - run, pick your branch and get a total count of your borrowers. #count #patrons

----------
*/

SELECT count(*) from borrowers where branchcode=<<Pick your branch|branches>>



