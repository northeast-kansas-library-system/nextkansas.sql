/*
R.000891

----------

Name: LOST Report ONLY showing null value for replacement cost
Created by:  Tongie Book Club

----------

Group: Circulation
     Charges

Created on: 2010-07-12 12:22:10
Modified on: 2013-06-18 10:47:25
Date last run: 2022-05-10 08:09:45

----------

Public: 0
Expiry: 0

----------

ENHANCED - Select Run and use drop-down menu to select branch.  Report only displays Lost items with zero dollar value

----------
*/



SELECT  borrowers.cardnumber, borrowers.surname, borrowers.firstname, borrowers.phone, borrowers.email, borrowers.address, borrowers.city, borrowers.zipcode, accountlines.description, accountlines.timestamp, FORMAT(SUM(accountlines.amountoutstanding),2) as due FROM borrowers LEFT JOIN accountlines USING (borrowernumber) WHERE borrowers.branchcode= <<Pick your branch|branches>> AND accountlines.amountoutstanding=' ' AND accountlines.description LIKE 'lost item%' GROUP BY accountlines.description ORDER BY borrowers.surname ASC

























