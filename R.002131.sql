/*
R.002131

----------

Name: Circ History for a Patron (Simple)
Created by: Heather Braum

----------

Group: Borrowers
     -

Created on: 2013-12-18 16:43:48
Modified on: 2014-08-11 14:18:52
Date last run: 2021-04-07 17:08:33

----------

Public: 0
Expiry: 0

----------

Lists item callnumber, title, author, checked out date

----------
*/

SELECT items.itemcallnumber, biblio.title, biblio.author, items.ccode, old_issues.issuedate FROM old_issues LEFT JOIN borrowers USING(borrowernumber) LEFT JOIN items USING(itemnumber) LEFT JOIN biblio USING(biblionumber) WHERE borrowers.cardnumber=<<enter patron cardnumber>> AND items.itemnumber IS NOT NULL
UNION ALL 
SELECT items.itemcallnumber, biblio.title, biblio.author, items.ccode,  issues.issuedate FROM issues LEFT JOIN borrowers USING(borrowernumber) LEFT JOIN items USING(itemnumber) LEFT JOIN biblio USING(biblionumber) WHERE borrowers.cardnumber=<<enter patron cardnumber a second time>> AND items.itemnumber IS NOT NULL
ORDER BY issuedate
LIMIT 10000



