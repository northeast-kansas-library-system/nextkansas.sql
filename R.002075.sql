/*
R.002075

----------

Name: Count of all lines in statistics table by borrower
Created by: Heather Braum

----------

Group: Administrative Reports
     Patron Statistics-admin

Created on: 2013-10-29 16:04:59
Modified on: 2013-11-17 14:03:20
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowernumber, CONCAT ('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowernumber,'\" target="_blank">',borrowernumber,'</a>') AS "patron link", count(datetime) FROM statistics GROUP BY borrowernumber



