/*
R.002328

----------

Name: Quickly update Passwords for a Grade of Students
Created by: Heather Braum

----------

Group: School Libraries
     Students

Created on: 2014-08-15 15:15:13
Modified on: 2014-08-19 22:27:34
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/members/member-password.pl?member=',b.borrowernumber,'\" target="_blank">'"edit username/password"'</a>') as "edit patron", b.firstname, b.surname FROM borrowers b  LEFT JOIN borrower_attributes ba USING (borrowernumber) WHERE b.branchcode=<<branch|branches>> AND b.categorycode='STUDENT' AND ba.attribute=<<grade|GRADE>> ORDER BY b.surname, b.firstname LIMIT 400



