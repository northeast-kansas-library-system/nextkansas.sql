/*
R.000801

----------

Name: Wellsville Overdue
Created by: WELLSVILLE TECH

----------

Group:  WELLSVILLE
     -

Created on: 2010-01-27 14:12:16
Modified on: 2021-08-16 13:39:32
Date last run: 2021-07-16 14:20:27

----------

Public: 0
Expiry: 0

----------

Set for 1 day or more overdue - you can edit this as needed

----------
*/

SELECT borrowers.surname, borrowers.firstname, borrowers.phone, borrowers.cardnumber, borrowers.address, borrowers.city, borrowers.zipcode, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.itemcallnumber, items.barcode, items.homebranch, biblio.title, biblio.author FROM borrowers left join issues on (borrowers.borrowernumber=issues.borrowernumber) left join items on (issues.itemnumber=items.itemnumber) LEFT JOIN biblio on (items.biblionumber=biblio.biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > '1' and issues.branchcode = 'wellsville' order by borrowers.surname asc, issues.date_due asc



