/*
R.000744

----------

Name: Osawatomie Overdues
Created by:  Tongie Book Club

----------

Group:  OSAWATOMIE
     -

Created on: 2009-12-21 15:06:18
Modified on: 2021-08-16 13:45:41
Date last run: 2018-09-28 13:06:03

----------

Public: 0
Expiry: 0

----------

Set for 7 days overdue.  Lists all items checked out at your Library.

----------
*/

SELECT borrowers.surname, borrowers.firstname, borrowers.phone, borrowers.cardnumber, borrowers.address, borrowers.city, borrowers.zipcode, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.itemcallnumber, items.barcode, items.homebranch, biblio.title, biblio.author FROM borrowers left join issues on (borrowers.borrowernumber=issues.borrowernumber) left join items on (issues.itemnumber=items.itemnumber) LEFT JOIN biblio on (items.biblionumber=biblio.biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > '7' and issues.branchcode = 'osawatomie' order by borrowers.surname asc, issues.date_due asc



