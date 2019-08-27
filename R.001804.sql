/*
R.001804

----------

Name: SES Borrowers list limited by classroom teacher
Created by: Heather Braum

----------

Group: School Libraries
     Students

Created on: 2013-04-21 17:34:35
Modified on: 2014-08-19 22:35:14
Date last run: 2019-05-10 09:59:30

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowers.cardnumber, borrower_attributes.attribute as 'grade', borrowers.categorycode, CONCAT (borrowers.surname,' ',borrowers.firstname) AS name, borrowers.sort1, CONCAT('<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',borrowers.borrowernumber,'\" target="_blank">'"edit patron"'</a>') as "edit patron" FROM borrowers LEFT JOIN borrower_attributes USING (borrowernumber) WHERE borrowers.branchcode = 'PHSES' GROUP BY borrowers.cardnumber order by grade, borrowers.sort1 LIMIT 500



