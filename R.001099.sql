/*
R.001099

----------

Name: My items overdue elsewhere
Created by: -

----------

Group: Circulation
     Overdues

Created on: 2011-05-13 15:26:24
Modified on: 2014-01-08 14:11:06
Date last run: 2021-10-28 16:01:52

----------

Public: 0
Expiry: 0

----------

Enter the number of days overdue you want to track (0 or more) and choose your branch twice from the dropdowns. The first dropdown looks at only your library's items and the second dropdown looks at where the checkout did not happen (your library). 

----------
*/



SELECT issues.branchcode as 'Transacting Library', borrowers.surname, borrowers.firstname, borrowers.phone, borrowers.cardnumber, borrowers.email, borrowers.address, borrowers.city, borrowers.zipcode, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.itemcallnumber, items.barcode, items.homebranch as 'Owning library', biblio.title, biblio.author FROM borrowers join issues USING (borrowernumber) join items USING (itemnumber) JOIN biblio USING (biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > <<number of days>> and items.homebranch = <<Pick your branch|branches>> AND issues.branchcode <> <<Pick your branch|branches>> order by borrowers.surname asc, issues.date_due asc

























