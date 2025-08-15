/*
R.003523

----------

Name: GHW - Non-BASEHOR patrons with BASEHOR Kanopy access 
Created by: George Williams

----------

Group:  BASEHOR
     -

Created on: 2021-06-14 11:44:12
Modified on: 2025-04-04 15:30:14
Date last run: 2025-08-06 09:48:55

----------

Public: 0
Expiry: 300

----------

 
Shows patrons with a "Kanopy (BASEHOR): Allowed . . ." patron attribute but without a BASEHOR homebranch
Shows borrwoers that currently have this attribute
grouped by categorycode and borrowernumber
sorted by library card number
links to the borrower account

Notes:

Should be run monthly at BASEHOR so the attribute can be removed from those accounts
Go to the training information for the Kanopy (BASEHOR) extended borrower attribute.

kanopy; patron-extended-attributes; BASEHOR;


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
      borrower_attributes.code = 'BASEKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode &lt;&gt; 'BASEHOR' AND
  kanopy.attribute = 'BASEHOR' AND
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























