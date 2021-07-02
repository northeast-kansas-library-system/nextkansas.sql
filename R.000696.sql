/*
R.000696

----------

Name: Items from home library overdue at other libraries
Created by:  Tongie Book Club

----------

Group: Circulation
     Overdues

Created on: 2009-10-15 15:19:28
Modified on: 2017-01-03 14:53:42
Date last run: 2021-06-24 09:49:03

----------

Public: 0
Expiry: 0

----------

Enter your library in both dropdowns. Use for calling another library about your overdue items. Do not contact patron's directly.  

Enhanced.

----------
*/

SELECT borrowers.surname, borrowers.firstname, borrowers.cardnumber, borrowers.categorycode, borrowers.branchcode as "patron home library", issues.branchcode as "location checked out", borrowers.city, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.replacementprice, items.itemcallnumber, items.barcode, items.homebranch, biblio.title, biblio.author, items.itemlost FROM borrowers left join issues USING (borrowernumber) LEFT JOIN items USING (itemnumber) LEFT JOIN biblio USING (biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > <<Number of Days Overdue>> and issues.branchcode <> <<your branch|branches>> and items.homebranch = <<your branch|branches>> order by borrowers.surname asc, issues.date_due asc



