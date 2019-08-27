/*
R.001028

----------

Name: Overdue Items by Transacting Library
Created by: BALDWIN TECH

----------

Group: Circulation
     Overdues

Created on: 2011-01-14 10:07:50
Modified on: 2013-06-21 13:49:37
Date last run: 2018-09-26 14:42:08

----------

Public: 0
Expiry: 0

----------

Enhanced. Formerly  BCPL-OVD-TRANSACT.library. 

----------
*/

SELECT borrowers.surname, borrowers.firstname, borrowers.phone, borrowers.cardnumber, borrowers.email, borrowers.address, borrowers.city, borrowers.zipcode, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.itemcallnumber, items.barcode, items.homebranch, biblio.title, biblio.author FROM borrowers LEFT JOIN issues USING (borrowernumber) LEFT JOIN items USING (itemnumber) LEFT JOIN biblio USING (biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > <<Number of Days Overdue>> and issues.branchcode = <<Pick Transacting Branch|branches>> order by borrowers.surname asc, issues.date_due asc



