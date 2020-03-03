/*
R.000579

----------

Name: Debarred patrons
Created by:  Tongie Book Club

----------

Group: Patrons
     -

Created on: 2009-06-12 15:39:47
Modified on: 2013-11-17 12:49:30
Date last run: 2020-01-06 16:51:00

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT  borrowers.cardnumber,borrowers.surname,borrowers.firstname,borrowers.branchcode,borrowers.categorycode,borrowers.debarred,borrowers.flags FROM borrowers   WHERE borrowers.branchcode=<<branch|branches>> AND borrowers.debarred IS NOT NULL



