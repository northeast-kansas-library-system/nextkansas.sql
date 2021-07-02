/*
R.000555

----------

Name: NEW PATRONS listed for finding errors
Created by: -

----------

Group: Borrowers
     Fix Patrons

Created on: 2009-05-11 14:05:16
Modified on: 2017-03-08 13:09:35
Date last run: 2021-07-01 17:19:35

----------

Public: 0
Expiry: 0

----------

Review added patrons in a month at your library to find mistakes. Use the edit patron link to fix the accounts if you find errors. 

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',borrowers.borrowernumber,'\" target="_blank">'"edit patron"'</a>') as "edit patron", dateenrolled,surname,firstname,branchcode,categorycode,cardnumber,address,city,phone,email FROM borrowers WHERE branchcode=<<Choose Library|branches>> AND year(dateenrolled) = <<Choose Year Patrons Added|Year>> AND month(dateenrolled) = <<Choose month Patrons Added|Month>> ORDER BY borrowers.categorycode ASC, borrowers.branchcode ASC



