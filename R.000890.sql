/*
R.000890

----------

Name: LOST Report ALL
Created by:  Tongie Book Club

----------

Group: Administrative Reports
     Patrons-admin

Created on: 2010-07-12 11:31:06
Modified on: 2013-06-16 14:54:02
Date last run: 2022-07-21 14:15:44

----------

Public: 0
Expiry: 0

----------

This report lists ALL libraries and ALL patrons with LOST items outstanding. mc 7/12/10

----------
*/



SELECT  borrowers.branchcode, borrowers.cardnumber, borrowers.surname, borrowers.firstname, accountlines.description, accountlines.timestamp, FORMAT(SUM(accountlines.amountoutstanding),2) as due FROM borrowers LEFT JOIN accountlines USING(borrowernumber) WHERE accountlines.description LIKE 'lost item%' AND accountlines.amountoutstanding > 0  GROUP BY accountlines.description  ORDER BY borrowers.branchcode ASC


























