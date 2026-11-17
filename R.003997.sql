/*
R.003997

----------

Name: List of all patrons-nh test
Created by: Nikki Hansen

----------

Group: Borrowers
     -

Created on: 2026-08-28 08:30:07
Modified on: 2026-08-28 08:33:07
Date last run: 2026-08-28 08:49:06

----------

Public: 0
Expiry: 300

----------

Run - Pick Branch. May take time, depending on the number of patrons you have. Also includes an Edit Patron link. #patrons

----------
*/



SELECT borrowers.dateenrolled, borrowers.branchcode,borrowers.cardnumber,borrowers.address,borrowers.city,borrowers.zipcode, CONCAT('<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',borrowers.borrowernumber,'\" target="_blank">'"edit patron"'</a>') as "edit patron" FROM borrowers WHERE borrowers.branchcode = <<Pick your branch|branches>> ORDER BY borrowers.zipcode ASC

























