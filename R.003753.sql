/*
R.003753

----------

Name: GHW - sandbox ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2023-08-22 09:53:19
Modified on: 2023-08-22 10:19:14
Date last run: 2023-08-22 10:19:16

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.cardnumber,
  borrower_attributes.borrowernumber,
  borrower_attribute_types.description,
  borrower_attributes.code,
  borrower_attributes.attribute
FROM
  borrower_attributes JOIN
  borrowers ON borrower_attributes.borrowernumber = borrowers.borrowernumber
  INNER JOIN
  borrower_attribute_types ON borrower_attributes.code =
      borrower_attribute_types.code
WHERE
  borrower_attributes.code LIKE "%" AND
  borrower_attributes.attribute LIKE "%"
GROUP BY
  borrower_attribute_types.description,
  borrower_attributes.id

























