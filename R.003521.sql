/*
R.003521

----------

Name: GHW - Non-ATCHISON patrons with ATCHISON Kanopy access 
Created by: George Williams

----------

Group:  ATCHISON
     -

Created on: 2021-06-14 11:30:27
Modified on: 2025-04-04 15:51:33
Date last run: 2025-04-04 15:51:33

----------

Public: 0
Expiry: 300

----------

 
Shows patrons with a "Kanopy (ATCHISON): Allowed . . ." patron attribute but without a ATCHISON homebranch
Shows borrwowers that currently have this attribute
grouped by categorycode and borrowernumber
sorted by library card number
links to the borrower account

Notes:

Should be run monthly at ATCHISON so the attribute can be removed from those accounts
Go to the training information for the Kanopy (ATCHISON) extended borrower attribute.

kanopy; patron-extended-attributes; ATCHISON;


----------
*/



SELECT
  Concat(
    'Go to patron account'
  ) AS LINK,
  borrowers.cardnumber AS CARD_NUMBER
FROM
  borrowers
  LEFT JOIN (
    SELECT
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute
    FROM
      borrower_attributes
    WHERE
      borrower_attributes.code = 'ATCHKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode &lt;&gt; 'ATCHISON' AND
  kanopy.attribute = 'ATCHISON' AND
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























