/*
R.001482

----------

Name: Patron Cardnumbers and usernames
Created by: -

----------

Group: Borrowers
     -

Created on: 2012-07-31 08:45:41
Modified on: 2013-09-25 17:17:49
Date last run: 2021-06-21 12:42:17

----------

Public: 0
Expiry: 0

----------

enhanced #patrons

----------
*/

SELECT borrowers.firstname, borrowers.surname, borrowers.cardnumber, borrowers.userid from borrowers where branchcode = <<Select your branch|branches>>



