/*
R.001078

----------

Name: Overdue Report by Date Range
Created by: -

----------

Group: Circulation
     Overdues

Created on: 2011-03-31 13:02:52
Modified on: 2013-06-23 12:27:01
Date last run: 2023-04-17 16:13:54

----------

Public: 0
Expiry: 0

----------

Select RUN, then pick your Library and fill in the date range #overdues

----------
*/



SELECT concat(borrowers.surname,', ',borrowers.firstname) as fullnamekey, borrowers.surname, borrowers.firstname, borrowers.email, borrowers.cardnumber, borrowers.phone, borrowers.address, borrowers.city, borrowers.zipcode, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.itemcallnumber, items.barcode, items.replacementprice, items.homebranch, biblio.title, biblio.author FROM borrowers LEFT JOIN issues USING (borrowernumber) LEFT JOIN items USING (itemnumber) LEFT JOIN biblio USING (biblionumber) WHERE issues.date_due BETWEEN <<Start Date (example: 2010-01-01) >> AND <<End Date (example: 2011-01-01 >> AND issues.branchcode= <<Pick your branch|branches>> ORDER BY borrowers.surname asc, issues.date_due asc

























