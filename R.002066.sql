/*
R.002066

----------

Name: coll-updatedel-HIAW-linked
Created by: Robin Hastings

----------

Group:  HIAWATHA
     -

Created on: 2013-10-25 14:14:12
Modified on: 2021-08-16 20:39:27
Date last run: 2019-02-26 15:55:55

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT CONCAT ('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=',borrowers.borrowernumber,'\" target="_blank">',borrowers.cardnumber,'</a>') AS "Link to Patron", borrowers.borrowernumber, borrowers.surname, borrowers.firstname, FORMAT(SUM(accountlines.amountoutstanding),2) AS Due 
FROM accountlines 
LEFT JOIN borrowers USING(borrowernumber) 
LEFT JOIN categories USING(categorycode) 
WHERE borrowers.branchcode IN ('HIAWATHA') 
AND borrowers.sort1 = 'yes'
GROUP BY borrowers.borrowernumber 
HAVING Due >=25.00 
ORDER BY borrowers.surname ASC 

























