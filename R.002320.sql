/*
R.002320

----------

Name: Checking for lowercase cardnumbers at school libraries
Created by: Heather Braum

----------

Group: Administrative Reports
     School Libraries-admin

Created on: 2014-08-12 23:00:21
Modified on: 2018-12-08 22:53:32
Date last run: 2018-12-09 21:26:58

----------

Public: 0
Expiry: 0

----------

right now, limited to student categorycode

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',borrowers.borrowernumber,'\" target="_blank">'"edit patron"'</a>') as "edit patron", cardnumber FROM borrowers WHERE branchcode LIKE 'PH%' AND cardnumber COLLATE utf8mb4_BIN = LOWER(cardnumber COLLATE utf8mb4_BIN) ORDER BY cardnumber



