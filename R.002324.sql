/*
R.002324

----------

Name: Students updated for 2014-2015 school year
Created by: Heather Braum

----------

Group: School Libraries
     Students

Created on: 2014-08-15 11:34:17
Modified on: 2014-08-19 22:32:08
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=',b.borrowernumber,'\" target="_blank">'"view patron"'</a>') as "view patron",  b.cardnumber, b.surname, b.firstname, b.othernames, b.email, b.dateofbirth, b.branchcode, b.categorycode, b.userid, b.sort1, b.dateexpiry, b.dateenrolled,ba_GRADE.attribute AS grade, ba_GRADYR.attribute AS grad_year, ba_UPDATED.attribute AS updated
FROM borrowers b
LEFT JOIN borrower_attributes ba_GRADE ON (b.borrowernumber = ba_GRADE.borrowernumber AND ba_GRADE.code = 'GRADE')
LEFT JOIN borrower_attributes ba_GRADYR ON (b.borrowernumber = ba_GRADYR.borrowernumber AND ba_GRADYR.code = 'GRADYR')
LEFT JOIN borrower_attributes ba_OLDKEY ON (b.borrowernumber = ba_OLDKEY .borrowernumber AND ba_OLDKEY .code = 'OLDKEY ')
LEFT JOIN borrower_attributes ba_UPDATED ON (b.borrowernumber = ba_UPDATED .borrowernumber AND ba_UPDATED .code = 'UPDATED ')
WHERE b.branchcode = <<choose branch|branches>> AND b.categorycode <> 'STAFF' AND ba_UPDATED.attribute = 'Aug2014'
GROUP BY b.borrowernumber
ORDER BY b.categorycode, b.branchcode, ba_GRADE.attribute, b.surname,  b.firstname




