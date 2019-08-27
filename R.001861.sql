/*
R.001861

----------

Name: COLL-newdelinq-Ottawa
Created by: Robin Hastings

----------

Group: Library-Specific
     Ottawa

Created on: 2013-05-21 13:35:28
Modified on: 2017-06-27 16:19:21
Date last run: 2017-07-03 17:20:39

----------

Public: 0
Expiry: 0

----------

Shows delinquent borrowers from Ottawa library with more than $25 owed in the last year.

----------
*/

SELECT borrowers.cardnumber,
  borrowers.borrowernumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.address,
  borrowers.city,
  borrowers.zipcode,
  borrowers.phone,
  borrowers.mobile,
  borrowers.phonepro AS "Alt Ph 1",
  borrowers.B_phone AS "Alt Ph 2",
  borrowers.branchcode,
  categories.category_type AS "Adult or Child",
  borrowers.dateofbirth,
  MAX(accountlines.date) AS "Most recent charge",
  FORMAT(SUM(accountlines.amountoutstanding),2) AS Due 
FROM accountlines 
LEFT JOIN borrowers USING(borrowernumber)
LEFT JOIN categories USING(categorycode) 
WHERE borrowers.branchcode IN ('OTTAWA') 
AND borrowers.sort1 != 'yes'
AND accountlines.date > DATE_SUB(CURDATE(), INTERVAL 1 year) 
AND accountlines.date < DATE_SUB(CURDATE(), INTERVAL 60 day) 
GROUP BY borrowers.borrowernumber 
HAVING Due >=25.00 
ORDER BY borrowers.surname ASC



