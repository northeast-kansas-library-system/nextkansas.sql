/*
R.002619

----------

Name: Non numbers, hyphens in zipcode
Created by: Heather Braum

----------

Group: Administrative Reports
     Patrons-admin

Created on: 2015-10-13 11:05:20
Modified on: 2015-10-13 11:05:20
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',borrowers.borrowernumber,'\" target="_blank">'"edit patron"'</a>') as "edit patron", borrowernumber, state, zipcode FROM borrowers WHERE zipcode IS NOT NULL and zipcode <> '' and zipcode REGEXP '^.*([^0-9-].*)$'



