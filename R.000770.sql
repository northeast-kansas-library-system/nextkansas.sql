/*
R.000770

----------

Name: All AATEMP patrons
Created by:  Tongie Book Club

----------

Group: Borrowers
     Fix Patrons

Created on: 2010-01-07 10:03:47
Modified on: 2014-02-28 15:13:22
Date last run: 2021-06-04 10:33:36

----------

Public: 0
Expiry: 0

----------

Please fix!

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',borrowers.borrowernumber,'\" target="_blank">'"edit patron"'</a>') as "edit patron", dateenrolled, surname,firstname,branchcode,categorycode, cardnumber,address,city,phone,email FROM borrowers WHERE categorycode='AATEMP' ORDER BY branchcode ASC



