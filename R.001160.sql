/*
R.001160

----------

Name: ILL patron accounts: Loaned to other libraries OVERDUE
Created by: -

----------

Group: Interlibrary Loan
     -

Created on: 2011-08-11 14:08:00
Modified on: 2018-04-06 20:46:40
Date last run: 2019-07-30 17:35:39

----------

Public: 0
Expiry: 0

----------

Overdue >30 days report for materials loaned to other libraries through non-NExpress ILL services. MC/8/11 #overdues

<p><span style="background-color: darkred; color: white">Report upgrade needed.</p>

----------
*/

SELECT items.homebranch, borrowers.surname, borrowers.firstname, borrowers.cardnumber, issues.date_due, (TO_DAYS(curdate())-TO_DAYS( date_due)) as 'days overdue', items.itype, items.itemcallnumber, items.replacementprice, items.barcode FROM borrowers LEFT JOIN issues USING(borrowernumber) LEFT JOIN items USING(itemnumber) LEFT JOIN biblio USING(biblionumber) WHERE (TO_DAYS(curdate())-TO_DAYS(date_due)) > '30' and borrowers.categorycode= 'ILL' order by items.homebranch asc, issues.date_due asc



