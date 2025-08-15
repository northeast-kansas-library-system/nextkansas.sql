/*
R.003301

----------

Name: GHW - Non-OTTAWA patrons with OTTAWA Kanopy access
Created by: George Williams

----------

Group:  OTTAWA
     -

Created on: 2020-01-09 15:33:11
Modified on: 2025-04-04 15:55:51
Date last run: 2025-04-04 15:55:51

----------

Public: 0
Expiry: 300

----------

 
Shows patrons with a "Kanopy (OTTAWA): Allowed . . ." patron attribute but without a OTTAWA homebranch
Shows borrwoers that currently have this attribute
grouped by categorycode and borrowernumber
sorted by library card number
links to the borrower account

Notes:

Should be run monthly at OTTAWA so the attribute can be removed from those accounts
Go to the training information for the Kanopy (OTTAWA) extended borrower attribute.

Click here to run in a new window
kanopy; patron-extended-attributes; OTTAWA;


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
      borrower_attributes.code = 'OTTAKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode &lt;&gt; 'OTTAWA' AND
  kanopy.attribute = 'OTTAWA' AND
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























