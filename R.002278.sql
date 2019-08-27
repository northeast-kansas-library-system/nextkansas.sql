/*
R.002278

----------

Name: Looking for private data in patron records
Created by: Heather Braum

----------

Group: Administrative Reports
     Patrons-admin

Created on: 2014-06-06 20:53:00
Modified on: 2014-08-09 00:25:12
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

select CONCAT('<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',b.borrowernumber,'&step=3\" target="_blank">'"edit patron"'</a>') as "edit patron", b.branchcode, b.contactnote, b.borrowernotes from borrowers b where (b.borrowernotes LIKE '%K0%' OR b.borrowernotes LIKE '%sn%' OR b.borrowernotes LIKE '%dl%' OR b.borrowernotes LIKE '%social%' OR b.borrowernotes LIKE '%driver%' OR b.borrowernotes LIKE '%license%') ORDER BY b.branchcode



