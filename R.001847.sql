/*
R.001847

----------

Name: List of Checkouts by Doniphan Troy Statistical Patron Category
Created by: Heather Braum

----------

Group: Library-Specific
     -

Created on: 2013-05-17 12:08:51
Modified on: 2014-04-25 16:06:01
Date last run: 2018-03-15 01:07:09

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT statistics.datetime, borrowers.borrowernumber, CONCAT (borrowers.firstname, ' ', borrowers.surname) AS 'name', statistics.type, borrowers.cardnumber, biblio.title, biblio.biblionumber, items.itemnumber, items.barcode, items.itype FROM borrowers LEFT JOIN statistics USING(borrowernumber) LEFT JOIN items USING(itemnumber) LEFT JOIN biblio USING(biblionumber) WHERE borrowers.categorycode='STATISTIC' AND borrowers.branchcode='DONITROY' AND statistics.type IN ('issue','renew','localuse') ORDER BY statistics.datetime DESC LIMIT 20000



