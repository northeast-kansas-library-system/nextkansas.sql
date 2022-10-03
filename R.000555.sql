/*
R.000555

----------

Name: NEW PATRONS listed for finding errors
Created by: -

----------

Group: Borrowers
     Fix Patrons

Created on: 2009-05-11 14:05:16
Modified on: 2022-02-02 18:06:39
Date last run: 2022-10-03 12:42:10

----------

Public: 0
Expiry: 0

----------

Review added patrons in a month at your library to find mistakes. Use the edit patron link to fix the accounts if you find errors. 

----------
*/



SELECT CONCAT('<a class="btn btn-default" href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',borrowers.borrowernumber,'\" target="_blank">'"edit patron"'</a>') as "Edit this borrower", dateenrolled,surname,firstname,branchcode,categorycode,cardnumber,address,city,phone,email FROM borrowers WHERE branchcode=<<Choose Library|branches>> AND year(dateenrolled) = <<Choose Year Patrons Added|Year>> AND month(dateenrolled) = <<Choose month Patrons Added|Month>> ORDER BY borrowers.categorycode ASC, borrowers.branchcode ASC

























