/*
R.001787

----------

Name: AATEMP patrons, limited by branch
Created by: Heather Braum

----------

Group: Borrowers
     Fix Patrons

Created on: 2013-04-05 10:43:02
Modified on: 2015-05-05 17:16:43
Date last run: 2021-04-13 15:49:26

----------

Public: 0
Expiry: 0

----------

Patrons missing a categorycode; Includes edit patron link

----------
*/

SELECT borrowernumber, CONCAT('<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',borrowers.borrowernumber,'\" target="_blank">'"edit patron"'</a>') as "edit patron", dateenrolled, surname,firstname,branchcode,categorycode, cardnumber,address,city,phone,email FROM borrowers WHERE branchcode=<<Select your branch|branches>> AND categorycode='AATEMP' ORDER BY surname



