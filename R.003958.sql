/*
R.003958

----------

Name: Koha-US Sample 1
Created by: George Williams

----------

Group: -
     -

Created on: 2026-04-20 13:22:11
Modified on: 2026-04-20 13:36:00
Date last run: 2026-04-21 17:55:11

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
  borrowers.branchcode,
  borrowers.categorycode
FROM
  borrowers
WHERE
  borrowers.cardnumber LIKE "85899%"

























