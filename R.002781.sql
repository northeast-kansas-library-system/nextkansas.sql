/*
R.002781

----------

Name: GHW - test for duplicate cards
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-09-28 11:45:44
Modified on: 2016-09-28 22:38:37
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  Concat_Ws(' ', SubString(borrowers.surname FROM 1 FOR 3 ),SubString(borrowers.firstname FROM 1 FOR 3 )) AS FIRST,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.othernames,
  borrowers.address,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.dateofbirth,
  borrowers.branchcode,
  borrowers.borrowernumber
FROM
  borrowers
WHERE
  borrowers.surname LIKE <<Enter first letter of patron's last name plus a percent symbol>>
GROUP BY
  FIRST, borrowers.surname, borrowers.firstname



