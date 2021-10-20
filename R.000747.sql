/*
R.000747

----------

Name: Bern Overdues
Created by:  Tongie Book Club

----------

Group:  BERN
     -

Created on: 2009-12-21 16:33:48
Modified on: 2021-08-16 20:42:53
Date last run: 2018-01-05 16:08:06

----------

Public: 0
Expiry: 0

----------

Set for 7 days or more overdue. Shows items circulated at your location.

----------
*/



SELECT borrowers.surname, borrowers.firstname, borrowers.phone, borrowers.cardnumber, borrowers.address, borrowers.city, borrowers.zipcode, issues.date_due, (TO_DAYS(curdate())-TO_DAYS(date_due)) as 'days overdue', items.itype, items.itemcallnumber, items.barcode, items.homebranch, biblio.title, biblio.author FROM borrowers left join issues on (borrowers.borrowernumber=issues.borrowernumber) left join items on (issues.itemnumber=items.itemnumber) LEFT JOIN biblio on (items.biblionumber=biblio.biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > '7' and issues.branchcode = 'bern' order by borrowers.surname asc, issues.date_due asc

























