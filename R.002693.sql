/*
R.002693

----------

Name: School patrons without grade levels set
Created by: Heather Braum

----------

Group: -
     -

Created on: 2016-05-11 13:12:30
Modified on: 2016-05-11 13:13:51
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/patroncards/edit-batch.pl?borrower_number=',b.borrowernumber,'&batch_id=4959&op=add\" target="_blank">'"add patron to label sheet"'</a>') as "view patron",  b.cardnumber, b.surname, b.firstname, b.othernames, b.email, b.dateofbirth, b.branchcode, b.categorycode, b.userid, b.sort1, b.dateexpiry, b.dateenrolled, ba_GRADE.attribute AS grade, ba_GRADYR.attribute AS grad_year
FROM borrowers b
LEFT JOIN borrower_attributes ba_GRADE ON (b.borrowernumber = ba_GRADE.borrowernumber AND ba_GRADE.code = 'GRADE')
LEFT JOIN borrower_attributes ba_GRADYR ON (b.borrowernumber = ba_GRADYR.borrowernumber AND ba_GRADYR.code = 'GRADYR')
WHERE b.branchcode = <<choose branch|branches>> AND b.categorycode <> 'STAFF' and (ba_GRADE.attribute IS NULL OR ba_GRADYR.attribute IS NULL)
GROUP BY b.borrowernumber
ORDER BY b.categorycode, b.branchcode, ba_GRADE.attribute, b.surname,  b.firstname



