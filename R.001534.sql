/*
R.001534

----------

Name: Borrowers in a given zipcode for a given branch
Created by: Heather Braum

----------

Group: Borrowers
     -

Created on: 2012-09-05 10:56:12
Modified on: 2022-12-21 10:23:01
Date last run: 2025-09-17 14:34:31

----------

Public: 0
Expiry: 0

----------

Enhanced: RUN AS IS. This report will report all patrons/addresses in a given zipcode for a given library.

----------
*/



SELECT
  borrowers.borrowernumber,
  borrowers.branchcode,
  borrowers.cardnumber,
  borrowers.zipcode,
  borrowers.city,
  borrowers.state,
  borrowers.country
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE <> AND
  borrowers.city LIKE Concat('%', <>, '%')  AND
  borrowers.zipcode LIKE Concat('%', <>, '%') 
ORDER BY 
  borrowers.city,
  borrowers.zipcode

























