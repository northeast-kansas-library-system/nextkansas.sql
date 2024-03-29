/*
R.000697

----------

Name: Items from other libraries overdue at your library 
Created by:  Tongie Book Club

----------

Group: Circulation
     Overdues

Created on: 2009-10-15 16:24:36
Modified on: 2013-06-18 09:35:05
Date last run: 2023-05-19 13:20:16

----------

Public: 0
Expiry: 0

----------

Enhanced. Do not edit.

----------
*/



SELECT borrowers.surname, borrowers.firstname, borrowers.cardnumber, borrowers.branchcode, borrowers.city, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.replacementprice, items.itemcallnumber, items.barcode, items.homebranch, biblio.title, biblio.author FROM borrowers LEFT JOIN issues USING (borrowernumber) LEFT JOIN items USING (itemnumber) LEFT JOIN biblio USING (biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > <<Number of Days Overdue>> and issues.branchcode =<<Your Library|branches>> and items.homebranch <> <<Your Library|branches>> order by borrowers.surname asc, issues.date_due asc

























