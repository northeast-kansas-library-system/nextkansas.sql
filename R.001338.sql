/*
R.001338

----------

Name: List of all patrons
Created by: -

----------

Group: Borrowers
     -

Created on: 2012-03-08 10:22:28
Modified on: 2014-01-15 00:42:08
Date last run: 2026-01-12 12:03:54

----------

Public: 0
Expiry: 0

----------

Run - Pick Branch. May take time, depending on the number of patrons you have. Also includes an Edit Patron link. #patrons

----------
*/



SELECT borrowers.dateenrolled, borrowers.surname,borrowers.firstname,borrowers.branchcode,borrowers.categorycode,borrowers.phone,borrowers.cardnumber,borrowers.address,borrowers.city,borrowers.zipcode, CONCAT(''"edit patron"'') as "edit patron" FROM borrowers WHERE borrowers.branchcode = &lt;&gt; ORDER BY borrowers.categorycode ASC

























