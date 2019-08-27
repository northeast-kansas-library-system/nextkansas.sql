/*
R.002261

----------

Name: Figuring out Overdue Patrons who may be gone, based on Address
Created by: Heather Braum

----------

Group: Circulation
     Overdues

Created on: 2014-05-14 10:46:33
Modified on: 2014-05-14 10:49:04
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowers.borrowernumber,'\" target="_blank">',borrowers.surname,'</a>') AS "borrowers.surname", borrowers.firstname, borrowers.phone, borrowers.cardnumber, borrowers.email, borrowers.address, borrowers.address2, borrowers.city, borrowers.zipcode FROM borrowers join issues USING (borrowernumber) WHERE issues.branchcode = <<Pick your branch|branches>> AND borrowers.branchcode=<<branch|branches>> AND (TO_DAYS(curdate())-TO_DAYS(date_due)) > <<number of days>> AND borrowers.address LIKE <<put address search here>> AND borrowers.city LIKE <<put city search here>> GROUP BY borrowers.borrowernumber order by borrowers.surname asc, issues.date_due asc



