/*
R.002579

----------

Name: Items from other libraris overdue by your patrons
Created by: Heather Braum

----------

Group: Circulation
     Overdues

Created on: 2015-08-19 15:50:10
Modified on: 2015-08-19 15:51:05
Date last run: 2017-08-04 17:00:20

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowers.surname, borrowers.firstname, borrowers.cardnumber, borrowers.branchcode as "patron home library", issues.branchcode as "location checked out", borrowers.city, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.replacementprice, items.itemcallnumber, items.barcode, items.homebranch as "item home library", biblio.title, biblio.author FROM borrowers left join issues USING (borrowernumber) LEFT JOIN items USING (itemnumber) LEFT JOIN biblio USING (biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > <<Number of Days Overdue>> and issues.branchcode = <<your branch|branches>> and items.homebranch <> <<your branch|branches>> order by borrowers.surname asc, issues.date_due asc



