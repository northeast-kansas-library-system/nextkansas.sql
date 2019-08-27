/*
R.002275

----------

Name: Old Patron Data Cleanup
Created by: Heather Braum

----------

Group: Administrative Reports
     Patrons-admin

Created on: 2014-06-05 16:26:23
Modified on: 2014-08-09 00:26:07
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

select b.borrowernumber, CONCAT('<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',b.borrowernumber,'&step=4\" target="_blank">'"edit patron attribute"'</a>') as "edit patron", b.branchcode, b.contactnote, b.borrowernotes, ba_LICENSE.attribute AS license, ba_ALTID.attribute AS altid, ba_OLDKEY.attribute AS oldkey from borrowers b
LEFT JOIN borrower_attributes ba_LICENSE ON (b.borrowernumber = ba_LICENSE.borrowernumber AND ba_LICENSE.code = 'LICENSE')
LEFT JOIN borrower_attributes ba_ALTID ON (b.borrowernumber = ba_ALTID.borrowernumber AND ba_ALTID.code = 'ALTID')
LEFT JOIN borrower_attributes ba_OLDKEY ON (b.borrowernumber = ba_OLDKEY.borrowernumber AND ba_OLDKEY.code = 'OLDKEY') 
WHERE ba_ALTID.attribute <> '' OR ba_LICENSE.attribute <> '' OR ba_OLDKEY.attribute <> '' ORDER BY b.branchcode



