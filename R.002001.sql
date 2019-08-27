/*
R.002001

----------

Name: COLL-updatedel-linked
Created by: Robin Hastings

----------

Group: Library-Specific
     Ottawa

Created on: 2013-08-16 08:20:56
Modified on: 2015-02-27 14:28:17
Date last run: -

----------

Public: 0
Expiry: 0

----------

Update report run for Ottowa Unique Report

----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowers.borrowernumber,'\" target="_blank">',borrowers.cardnumber,'</a>') AS "Link to Patron", borrowers.borrowernumber, borrowers.surname, borrowers.firstname, FORMAT(SUM(accountlines.amountoutstanding),2) AS Due 
FROM accountlines 
LEFT JOIN borrowers USING(borrowernumber) 
LEFT JOIN categories USING(categorycode) 
WHERE borrowers.branchcode IN ('OTTAWA') 
AND borrowers.sort1 = 'yes'
GROUP BY borrowers.borrowernumber 
ORDER BY borrowers.surname ASC



