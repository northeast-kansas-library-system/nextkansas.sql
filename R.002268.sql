/*
R.002268

----------

Name: Borrowers with Overdues in Number of Days Overdue Range
Created by: Heather Braum

----------

Group: Circulation
     Overdues

Created on: 2014-06-02 11:45:46
Modified on: 2014-06-02 11:49:36
Date last run: 2018-04-10 09:38:49

----------

Public: 0
Expiry: 0

----------

See report 1530 for an items list

----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowers.borrowernumber,'\" target="_blank">',borrowers.surname,'</a>') AS "borrowers.surname", borrowers.firstname, borrowers.phone, borrowers.cardnumber, borrowers.email, borrowers.address, borrowers.address2, borrowers.city, borrowers.zipcode FROM borrowers join issues USING (borrowernumber) WHERE issues.branchcode = <<Pick your branch|branches>> AND borrowers.branchcode=<<branch|branches>> AND (TO_DAYS(curdate())-TO_DAYS(date_due)) BETWEEN <<start number of days overdue (ex. 7)>> AND <<end number of days overdue, 1 more than you want to track (ex. 31, instead of 30)>> GROUP BY borrowers.borrowernumber order by borrowers.surname asc, issues.date_due asc



