/*
R.001647

----------

Name: Patrons with messages
Created by: ROSSVILLE TECH

----------

Group: Borrowers
     -

Created on: 2012-11-20 12:42:12
Modified on: 2013-09-25 17:23:48
Date last run: 2022-12-13 11:19:16

----------

Public: 0
Expiry: 0

----------

#patrons

----------
*/



SELECT b.cardnumber, b.surname, b.firstname,
b.opacnote, b.borrowernotes, group_concat(DISTINCT m.message separator ', ') AS circmesages
FROM borrowers b
LEFT JOIN messages m USING (borrowernumber)
WHERE b.branchcode=<<Branch|branches>> AND ((b.opacnote IS NOT
NULL AND b.opacnote != '') OR (b.borrowernotes IS NOT NULL AND
b.borrowernotes != '') OR (m.message IS NOT NULL AND
m.message != '')) GROUP BY b.borrowernumber ORDER BY b.surname ASC,
b.firstname ASC

























