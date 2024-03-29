/*
R.000640

----------

Name: Overdue Materials that Checked Out at Your Library
Created by:  Tongie Book Club

----------

Group: Circulation
     Overdues

Created on: 2009-07-10 16:16:24
Modified on: 2014-01-08 14:59:44
Date last run: 2023-05-03 12:28:39

----------

Public: 0
Expiry: 0

----------

All materials that are overdue that checked out at your library. 

----------
*/



SELECT borrowers.surname, borrowers.firstname, borrowers.phone, borrowers.cardnumber, borrowers.address, borrowers.city, borrowers.zipcode, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.itemcallnumber, items.barcode, items.homebranch, biblio.title, biblio.author FROM borrowers left join issues  USING (borrowernumber) LEFT JOIN items USING (itemnumber) LEFT JOIN biblio USING (biblionumber)  WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > <<Number of Days Overdue>> and issues.branchcode = <<Pick your branch|branches>> order by borrowers.surname asc, issues.date_due asc

























