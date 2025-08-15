/*
R.003370

----------

Name: GHW - Non-LINWOOD patrons with LINWOOD Kanopy access 
Created by: George Williams

----------

Group:  LINWOOD
     -

Created on: 2020-11-13 14:42:51
Modified on: 2025-04-04 15:54:35
Date last run: 2025-04-04 15:54:35

----------

Public: 0
Expiry: 300

----------

 
Shows patrons with a "Kanopy (LINWOOD): Allowed . . ." patron attribute but without a LINWOOD homebranch
Shows borrwoers that currently have this attribute
grouped by categorycode and borrowernumber
sorted by library card number
links to the borrower account

Notes:

Should be run monthly at LINWOOD so the attribute can be removed from those accounts
Go to the training information for the Kanopy (LINWOOD) extended borrower attribute.

Click here to run in a new window
kanopy; patron-extended-attributes; LINWOOD;


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
      borrower_attributes.code = 'LINWKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode &lt;&gt; 'LINWOOD' AND
  kanopy.attribute = 'LINWOOD' AND
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























