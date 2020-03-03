/*
R.000801

----------

Name: Wellsville Overdue
Created by: WELLSVILLE TECH

----------

Group: Library-Specific
     Wellsville

Created on: 2010-01-27 14:12:16
Modified on: 2015-12-05 20:45:18
Date last run: 2020-02-17 17:13:38

----------

Public: 0
Expiry: 0

----------

Set for 1 day or more overdue - you can edit this as needed

----------
*/

SELECT borrowers.surname, borrowers.firstname, borrowers.phone, borrowers.cardnumber, borrowers.address, borrowers.city, borrowers.zipcode, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.itemcallnumber, items.barcode, items.homebranch, biblio.title, biblio.author FROM borrowers left join issues on (borrowers.borrowernumber=issues.borrowernumber) left join items on (issues.itemnumber=items.itemnumber) LEFT JOIN biblio on (items.biblionumber=biblio.biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > '1' and issues.branchcode = 'wellsville' order by borrowers.surname asc, issues.date_due asc



