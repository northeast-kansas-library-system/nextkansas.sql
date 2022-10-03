/*
R.003346

----------

Name: GHW - Sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-08-14 15:14:53
Modified on: 2022-08-30 16:35:53
Date last run: 2022-08-30 16:37:18

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
  borrower_attribute_types.code,
  borrower_attributes.attribute
FROM
  borrower_attribute_types INNER JOIN
  borrower_attributes ON
      borrower_attributes.code = borrower_attribute_types.code INNER JOIN
  borrowers ON borrower_attributes.borrowernumber = borrowers.borrowernumber
WHERE
  borrower_attribute_types.code = 'USD113_T'

























