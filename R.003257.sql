/*
R.003257

----------

Name: GHW - Patron output for input ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-24 00:37:54
Modified on: 2020-04-23 02:28:16
Date last run: 2021-05-18 17:40:53

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
  borrowers.branchcode LIKE <<Choose your library|branches>> AND
  borrowers.categorycode <> "STAFF" AND
  borrowers.cardnumber NOT LIKE "0%" AND
  borrowers.cardnumber IS NOT NULL AND
  borrowers.cardnumber NOT LIKE ""



