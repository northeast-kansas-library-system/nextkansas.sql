/*
R.000904

----------

Name: Patrons with total fines credit
Created by:  Tongie Book Club

----------

Group: Circulation
     Charges

Created on: 2010-08-16 13:51:51
Modified on: 2013-06-18 10:48:24
Date last run: 2023-03-01 14:41:00

----------

Public: 0
Expiry: 0

----------

Enhanced - Run, pick your branch and see who has a credit. What is difference between this and 831?

----------
*/



SELECT  borrowers.cardnumber, borrowers.surname, borrowers.firstname, FORMAT(SUM(accountlines.amountoutstanding),2) as due FROM borrowers LEFT JOIN accountlines USING (borrowernumber) WHERE borrowers.branchcode=<<Pick your branch|branches>> AND accountlines.amountoutstanding != 0 GROUP BY borrowers.cardnumber having SUM(accountlines.amountoutstanding) < 0 ORDER BY borrowers.surname ASC

























