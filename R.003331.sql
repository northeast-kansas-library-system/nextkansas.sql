/*
R.003331

----------

Name: GHW Adminreport - Long states
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-06-09 13:17:12
Modified on: 2020-06-09 13:17:12
Date last run: 2020-06-09 14:48:08

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.country,
  borrowers.branchcode,
  borrowers.categorycode
FROM
  borrowers
WHERE
  borrowers.branchcode NOT LIKE "HIGH_CC" AND
  borrowers.branchcode NOT LIKE "PH%" AND
  borrowers.branchcode LIKE '%' AND
  borrowers.categorycode <> "STAFF" AND
  borrowers.cardnumber NOT LIKE "0%" AND
  borrowers.cardnumber IS NOT NULL AND
  borrowers.cardnumber NOT LIKE "" AND
  Length(borrowers.state) > 2

























