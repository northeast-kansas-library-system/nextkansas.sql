/*
R.002265

----------

Name: Overdues for Borrowers without Emails (not linked) XX days past due
Created by: Heather Braum

----------

Group: Circulation
     Overdues

Created on: 2014-05-20 14:29:25
Modified on: 2014-05-20 14:29:25
Date last run: 2021-08-11 12:42:36

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT borrowers.surname AS "borrowers.surname", borrowers.firstname, borrowers.phone, borrowers.cardnumber, borrowers.email, borrowers.address, borrowers.address2, borrowers.city, borrowers.zipcode, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.itemcallnumber, items.barcode AS barcode, items.replacementprice, items.homebranch, biblio.title, biblio.author FROM borrowers join issues USING (borrowernumber) join items USING (itemnumber) JOIN biblio USING (biblionumber) join biblioitems USING (biblionumber) WHERE issues.branchcode = <<Pick your branch|branches>> AND borrowers.email = '' AND (TO_DAYS(curdate())-TO_DAYS(date_due)) > <<number of days>> order by borrowers.surname asc, issues.date_due asc



