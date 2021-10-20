/*
R.003316

----------

Name: Update all 2020 patron expirations to 2021
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-03-22 20:56:24
Modified on: 2020-03-22 21:48:13
Date last run: 2020-03-23 00:37:18

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.cardnumber,
  REGEXP_REPLACE(Trim(borrowers.surname), '[[:space:]]+', ' ') AS surname,
  REGEXP_REPLACE(Trim(borrowers.firstname), '[[:space:]]+', ' ') AS firstname,
  REGEXP_REPLACE(Trim(Replace(borrowers.address, ".", "")), '[[:space:]]+', ' ') AS address,
  borrowers.city,
  If(borrowers.state LIKE "Kans%", "KS", If(borrowers.state LIKE "co%", "CO", If(borrowers.state LIKE "Neb%", "NE", upper(borrowers.state)))) AS state,
  LEFT(borrowers.zipcode, 5) AS zipcode,
  borrowers.country,
  borrowers.email,
  borrowers.phone,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateexpiry + INTERVAL 1 YEAR AS dateexpiry
FROM
  borrowers
WHERE
  borrowers.categorycode <> "STAFF" AND
  Year(borrowers.dateexpiry) = 2020 AND
  borrowers.branchcode LIKE <<Choose your library|ZBRAN>>

























