/*
R.001918

----------

Name: Circ History for a Patron (Complete)
Created by: Heather Braum

----------

Group: Patrons
     -

Created on: 2013-06-24 16:03:51
Modified on: 2013-12-18 16:41:08
Date last run: 2020-05-19 14:57:01

----------

Public: 0
Expiry: 0

----------

Full Report

----------
*/

SELECT biblio.title, biblio.author, items.itemnumber, items.itype, items.ccode, items.itemcallnumber, items.barcode, old_issues.branchcode, old_issues.issuedate, old_issues.renewals, old_issues.date_due, old_issues.returndate FROM old_issues LEFT JOIN borrowers USING(borrowernumber) LEFT JOIN items USING(itemnumber) LEFT JOIN biblio USING(biblionumber) WHERE borrowers.cardnumber=<<enter patron cardnumber>> AND items.itemnumber IS NOT NULL
UNION ALL 
SELECT biblio.title, biblio.author, items.itemnumber, items.itype, items.ccode, items.itemcallnumber, items.barcode, issues.branchcode, issues.issuedate, issues.renewals, issues.date_due, issues.returndate FROM issues LEFT JOIN borrowers USING(borrowernumber) LEFT JOIN items USING(itemnumber) LEFT JOIN biblio USING(biblionumber) WHERE borrowers.cardnumber=<<enter patron cardnumber a second time>> AND items.itemnumber IS NOT NULL
ORDER BY issuedate
LIMIT 10000



