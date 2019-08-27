/*
R.002327

----------

Name: Quickly Update Teacher Login info
Created by: Heather Braum

----------

Group: School Libraries
     Teachers

Created on: 2014-08-15 15:09:22
Modified on: 2014-08-19 22:30:09
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/members/member-password.pl?member=',b.borrowernumber,'\" target="_blank">'"edit username/password"'</a>') as "edit patron", b.firstname, b.surname FROM borrowers b WHERE b.branchcode=<<choose branch|branches>> AND categorycode='TEACHER' ORDER BY b.surname LIMIT 200



