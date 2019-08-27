/*
R.001338

----------

Name: List of all patrons
Created by: -

----------

Group: Patrons
     -

Created on: 2012-03-08 10:22:28
Modified on: 2014-01-15 00:42:08
Date last run: 2019-08-12 15:57:13

----------

Public: 0
Expiry: 0

----------

Run - Pick Branch. May take time, depending on the number of patrons you have. Also includes an Edit Patron link. #patrons

----------
*/

SELECT borrowers.dateenrolled, borrowers.surname,borrowers.firstname,borrowers.branchcode,borrowers.categorycode,borrowers.phone,borrowers.cardnumber,borrowers.address,borrowers.city,borrowers.zipcode, CONCAT('<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',borrowers.borrowernumber,'\" target="_blank">'"edit patron"'</a>') as "edit patron" FROM borrowers WHERE borrowers.branchcode = <<Pick your branch|branches>> ORDER BY borrowers.categorycode ASC



