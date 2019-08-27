/*
R.002972

----------

Name: GHW - EOM 002
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-07-05 16:06:40
Modified on: 2017-07-05 16:09:03
Date last run: 2018-06-01 15:06:46

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  borrowers.borrowernumber,
  Concat(borrowers.cardnumber) AS cardnumber,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.address,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode
FROM
  borrowers
WHERE
  borrowers.state <> "AL" AND
  borrowers.state <> "AK" AND
  borrowers.state <> "AZ" AND
  borrowers.state <> "AR" AND
  borrowers.state <> "CA" AND
  borrowers.state <> "CO" AND
  borrowers.state <> "CT" AND
  borrowers.state <> "DE" AND
  borrowers.state <> "DC" AND
  borrowers.state <> "FL" AND
  borrowers.state <> "GA" AND
  borrowers.state <> "HI" AND
  borrowers.state <> "ID" AND
  borrowers.state <> "IL" AND
  borrowers.state <> "IN" AND
  borrowers.state <> "IA" AND
  borrowers.state <> "KS" AND
  borrowers.state <> "KY" AND
  borrowers.state <> "LA" AND
  borrowers.state <> "ME" AND
  borrowers.state <> "MD" AND
  borrowers.state <> "MA" AND
  borrowers.state <> "MI" AND
  borrowers.state <> "MN" AND
  borrowers.state <> "MS" AND
  borrowers.state <> "MO" AND
  borrowers.state <> "MT" AND
  borrowers.state <> "NE" AND
  borrowers.state <> "NV" AND
  borrowers.state <> "NH" AND
  borrowers.state <> "NJ" AND
  borrowers.state <> "NM" AND
  borrowers.state <> "NY" AND
  borrowers.state <> "NC" AND
  borrowers.state <> "ND" AND
  borrowers.state <> "OH" AND
  borrowers.state <> "OK" AND
  borrowers.state <> "OR" AND
  borrowers.state <> "PA" AND
  borrowers.state <> "PR" AND
  borrowers.state <> "RI" AND
  borrowers.state <> "SC" AND
  borrowers.state <> "SD" AND
  borrowers.state <> "TN" AND
  borrowers.state <> "TX" AND
  borrowers.state <> "UT" AND
  borrowers.state <> "VT" AND
  borrowers.state <> "VA" AND
  borrowers.state <> "VI" AND
  borrowers.state <> "WA" AND
  borrowers.state <> "WV" AND
  borrowers.state <> "WI" AND
  borrowers.state <> "WY" AND
  borrowers.branchcode NOT LIKE "PH%" AND
  borrowers.branchcode NOT LIKE "LOU%"
GROUP BY
  borrowers.borrowernumber,
  Concat(borrowers.cardnumber),
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.address,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode
ORDER BY
  borrowers.state,
  borrowers.branchcode,
  borrowers.categorycode



