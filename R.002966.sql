/*
R.002966

----------

Name: GHW - Collection agency report 03 - Unique management
Created by: George Williams

----------

Group:  OTTAWA
     -

Created on: 2017-06-27 17:08:37
Modified on: 2024-01-17 11:51:43
Date last run: 2025-10-24 11:54:46

----------

Public: 0
Expiry: 300

----------

 
Shows patrons that OTTAWA has turned over to their collection agency
Shows patrons who currently have collection agency flags on their account.
regardless of the patron's home library
grouped by borrowernumber and sort1
sorted by borrowers name, last name first

Notes:

Click here to run in a new window


----------
*/



SELECT
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  Format(Sum(accountlines.amountoutstanding), 2) AS Due
FROM
  accountlines
  LEFT JOIN borrowers ON accountlines.borrowernumber = borrowers.borrowernumber
  LEFT JOIN categories ON borrowers.categorycode = categories.categorycode
  LEFT JOIN (SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      authorised_values.category,
      authorised_values.lib
    FROM
      borrower_attributes
      JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'CAOTTAWA' AND
      authorised_values.category = 'COLLAGEN') collagen ON borrowers.borrowernumber = collagen.borrowernumber
WHERE
  collagen.attribute LIKE "OTTA%"
GROUP BY
  borrowers.borrowernumber,
  borrowers.cardnumber
ORDER BY
  borrowers.surname,
  borrowers.firstname

























