/*
R.003140

----------

Name: Borrowers with non-existent guarantor
Created by: Bywater bwssupport

----------

Group: -
     -

Created on: 2018-12-10 14:27:52
Modified on: 2018-12-10 15:32:07
Date last run: 2021-04-22 15:09:48

----------

Public: 0
Expiry: 300

----------



----------
*/



select b1.surname, b1.firstname,b1.cardnumber,b1.guarantorid , b1.contactname AS guarantor_surname, b1.contactfirstname AS guarantor_firstname, b3.borrowernumber
FROM borrowers b1 
LEFT JOIN borrowers b2 ON b1.guarantorid=b2.borrowernumber 
LEFT JOIN borrowers b3 On b1.contactname=b3.surname AND b1.contactfirstname = b3.firstname
WHERE b1.guarantorid IS NOT NULL AND b1.guarantorid != 0 AND b2.borrowernumber IS NULL
ORDER BY
  b1.cardnumber

























