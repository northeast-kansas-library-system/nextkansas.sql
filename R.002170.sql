/*
R.002170

----------

Name: Clear Sort1 Field
Created by: Robin Hastings

----------

Group:  HIAWATHA
     -

Created on: 2014-01-21 10:00:57
Modified on: 2021-08-16 20:39:30
Date last run: 2019-02-26 15:55:20

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
WHERE borrowers.categorycode IN ('HIAW-BWN','HIAW-BWNJ','HIAW-CITY','HIAW-CITYJ','HIAW-OTHER','HIAW-OTHERJ') 
AND borrowers.sort1 = 'yes'
GROUP BY borrowers.borrowernumber 
HAVING DUE = 0.00
ORDER BY borrowers.surname ASC

























