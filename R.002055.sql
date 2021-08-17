/*
R.002055

----------

Name: COLL-newdelinq-linked-HIAW
Created by: Robin Hastings

----------

Group:  HIAWATHA
     -

Created on: 2013-10-22 12:15:26
Modified on: 2021-08-16 20:39:24
Date last run: 2019-02-26 15:56:21

----------

Public: 0
Expiry: 0

----------

Linked version of the Unique Report for Hiawatha

----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/members/maninvoice.pl?borrowernumber=',borrowers.borrowernumber,'\" target="_blank">',borrowers.cardnumber,'</a>') AS "Link to Fines",   borrowers.borrowernumber, borrowers.surname, borrowers.firstname, borrowers.address, borrowers.address2, borrowers.city, borrowers.zipcode, borrowers.phone, borrowers.mobile, borrowers.phonepro AS "Alt Ph 1", borrowers.B_phone AS "Alt Ph 2", borrowers.branchcode, categories.category_type AS "Adult or Child", borrowers.dateofbirth, MAX(accountlines.date) AS "Most recent charge", FORMAT(SUM(accountlines.amountoutstanding),2) AS Due 
FROM accountlines 
LEFT JOIN borrowers USING(borrowernumber) 
LEFT JOIN categories USING(categorycode) 
WHERE borrowers.branchcode IN ('HIAWATHA') 
AND borrowers.sort1 != 'yes'
AND accountlines.date > DATE_SUB(CURDATE(), INTERVAL 3 year) 
AND accountlines.date < DATE_SUB(CURDATE(), INTERVAL 60 day) 
GROUP BY borrowers.borrowernumber 
HAVING Due >=25.00 
ORDER BY borrowers.surname ASC



