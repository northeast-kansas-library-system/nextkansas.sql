/*
R.002065

----------

Name: coll-updatedel-HIAW
Created by: Robin Hastings

----------

Group: Library-Specific
     Hiawatha

Created on: 2013-10-25 14:12:53
Modified on: 2014-04-29 12:23:53
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowers.borrowernumber, borrowers.surname, borrowers.firstname, FORMAT(SUM(accountlines.amountoutstanding),2) AS Due 
FROM accountlines 
LEFT JOIN borrowers USING(borrowernumber) 
LEFT JOIN categories USING(categorycode) 
WHERE borrowers.branchcode IN ('HIAWATHA') 
AND borrowers.sort1 = 'yes'
GROUP BY borrowers.borrowernumber 
ORDER BY borrowers.surname ASC


