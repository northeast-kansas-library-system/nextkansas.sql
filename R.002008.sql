/*
R.002008

----------

Name: School Patrons Not Updated for 2015-2016 Year? 
Created by: -

----------

Group: School Libraries
     -

Created on: 2013-08-19 13:44:36
Modified on: 2019-07-24 21:54:09
Date last run: 2019-07-24 21:53:45

----------

Public: 1
Expiry: 300

----------

<p><span style="background-color: darkred; color: white">Scheduled for deletion on August 31, 2019</p>

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=',b.borrowernumber,'\" target="_blank">'"view patron"'</a>') as "view patron",  b.cardnumber, b.surname, b.firstname, b.othernames, b.email, b.dateofbirth, b.branchcode, b.categorycode, b.userid, b.sort1, b.dateexpiry, b.dateenrolled,ba_GRADE.attribute AS grade
FROM borrowers b
LEFT JOIN borrower_attributes ba_GRADE ON (b.borrowernumber = ba_GRADE.borrowernumber AND ba_GRADE.code = 'GRADE')
WHERE b.branchcode = <<choose branch|branches>> AND b.dateexpiry < '2016-08-31'
GROUP BY b.borrowernumber
ORDER BY b.categorycode, b.branchcode, ba_GRADE.attribute, b.surname,  b.firstname




