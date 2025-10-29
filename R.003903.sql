/*
R.003903

----------

Name: GHW patronpurge 07
Created by: George Williams

----------

Group: -
     -

Created on: 2025-07-30 10:02:38
Modified on: 2025-07-30 10:02:38
Date last run: 2025-10-23 14:12:32

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Upper(borrowers.cardnumber) AS cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode,
  borrowers.categorycode
FROM
  borrowers JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      authorised_values.lib,
      borrower_attributes.attribute
    FROM
      borrower_attributes JOIN
      authorised_values ON borrower_attributes.attribute =
          authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'EXPIRED' AND
      authorised_values.category = 'EXPIRED'
    GROUP BY
      borrower_attributes.borrowernumber,
      borrower_attributes.attribute,
      borrower_attributes.code) expired_account ON
      expired_account.borrowernumber = borrowers.borrowernumber
WHERE
  expired_account.attribute < '30'

























