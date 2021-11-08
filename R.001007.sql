/*
R.001007

----------

Name: Unreturned (Likely Lost) items report with Patron Info
Created by: TONGANOXIE TECH

----------

Group: Circulation
     Charges

Created on: 2010-12-15 13:51:34
Modified on: 2013-06-19 12:44:39
Date last run: 2021-10-28 14:39:15

----------

Public: 0
Expiry: 0

----------

Lost items with patron information. Enhanced

----------
*/



SELECT borrowers.surname, borrowers.firstname, borrowers.phone, borrowers.cardnumber, borrowers.address, borrowers.city, borrowers.zipcode, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.itemcallnumber, items.barcode, items.homebranch, biblio.title, biblio.author FROM borrowers left join issues USING (borrowernumber) LEFT JOIN items USING (itemnumber) LEFT JOIN biblio USING (biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) >= '180' and issues.branchcode = <<branch|branches>> order by borrowers.surname asc, issues.date_due asc

























