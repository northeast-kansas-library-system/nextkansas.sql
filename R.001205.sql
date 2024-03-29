/*
R.001205

----------

Name: Document Current ID/SSN
Created by: -

----------

Group: Administrative Reports
     Patrons-admin

Created on: 2011-10-18 14:01:54
Modified on: 2014-03-23 20:08:38
Date last run: 2020-05-08 10:52:14

----------

Public: 0
Expiry: 0

----------



----------
*/



select CONCAT('<a href=\"/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=',borrowers.borrowernumber,'\" target="_blank">'"edit patron"'</a>') as "edit patron", borrowers.firstname, borrowers.surname, borrowers.branchcode, borrowers.cardnumber, borrower_attributes.attribute from borrower_attributes join borrowers USING(borrowernumber) where borrower_attributes.code IN ('LICENSE','ALTID') and borrower_attributes.attribute NOT REGEXP 'verified|YES|on file|proof|bill|needs|need|same|dad|mom|ID|see|^/' and borrower_attributes.attribute REGEXP 'K0|ID#|-' order by borrowers.branchcode asc

























