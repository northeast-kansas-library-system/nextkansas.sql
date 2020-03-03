/*
R.001033

----------

Name: Fines over $10 by branch
Created by: -

----------

Group: Circulation
     Charges

Created on: 2011-01-24 21:34:31
Modified on: 2013-06-21 13:49:49
Date last run: 2020-01-06 16:53:00

----------

Public: 0
Expiry: 0

----------

Enhanced - Pick your branch to find patrons with fines over $10 #fines

----------
*/

SELECT  borrowers.cardnumber, borrowers.surname, borrowers.firstname, Phone, borrowers.altcontactphone, borrowers.email, borrowers.address, borrowers.city, borrowers.zipcode, FORMAT(SUM(accountlines.amountoutstanding),2) as due FROM borrowers LEFT JOIN accountlines USING (borrowernumber) WHERE borrowers.branchcode= <<Pick your branch|branches>> AND accountlines.amountoutstanding != 0 GROUP BY borrowers.cardnumber having SUM(accountlines.amountoutstanding) >10 ORDER BY borrowers.surname ASC



