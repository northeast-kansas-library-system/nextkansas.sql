/*
R.001671

----------

Name: Fines Over $10 by Patron Category
Created by: -

----------

Group: Circulation
     Charges

Created on: 2012-12-06 13:24:49
Modified on: 2013-06-23 12:35:53
Date last run: 2024-06-14 08:36:38

----------

Public: 0
Expiry: 0

----------

MC 12/6/12 #fines #patrons

----------
*/



SELECT borrowers.cardnumber, borrowers.surname,borrowers.firstname, borrowers.address, borrowers.city, borrowers.zipcode, borrowers.email, borrowers.phone, borrowers.dateofbirth, borrowers.debarred, FORMAT(SUM(accountlines.amountoutstanding),2) AS Due FROM borrowers LEFT JOIN accountlines USING(borrowernumber) WHERE borrowers.categorycode = <> GROUP BY borrowers.borrowernumber HAVING SUM(accountlines.amountoutstanding) >= 10.00 ORDER BY borrowers.surname ASC

























