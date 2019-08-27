/*
R.001497

----------

Name: Rossville fines paid
Created by: ROSSVILLE TECH

----------

Group: Library-Specific
     -

Created on: 2012-08-10 12:43:39
Modified on: 2014-01-15 00:18:58
Date last run: 2018-08-30 10:06:47

----------

Public: 0
Expiry: 0

----------

enter date parameters #fines

----------
*/

SELECT round(Sum(accountlines.amount),2) AS 'Fines Paid', CONCAT('<a href=\"/cgi-bin/koha/members/boraccount.pl?borrowernumber=',borrowers.borrowernumber,'" target="_blank">',borrowers.cardnumber,'</a>') as "link to borrower", borrowers.firstname, borrowers.surname, biblio.title, accountlines.timestamp as 'paid date' FROM accountlines LEFT JOIN borrowers USING (borrowernumber) LEFT join items using (itemnumber) LEFT join biblio using(biblionumber) WHERE borrowers.branchcode= 'rossville' AND (accounttype = 'PAY' ) AND date BETWEEN <<Between (YYYY-MM-DD)>> AND <<and (YYYY-MM-DD>> GROUP BY accountlines.timestamp




