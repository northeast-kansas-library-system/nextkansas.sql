/*
R.003368

----------

Name: GHW - LINWOOD patrons without Kanopy access
Created by: George Williams

----------

Group:  LINWOOD
     -

Created on: 2020-11-13 13:33:15
Modified on: 2025-04-04 15:54:30
Date last run: 2025-04-04 15:54:30

----------

Public: 0
Expiry: 300

----------

 
Shows patrons with a LINWOOD home library but without a "Kanopy (LINWOOD): Allowed . . ." borrower attribute.
Shows borrwoers that currently lack this attribute
grouped by categorycode and borrowernumber
sorted by library card number
links to the borrower account

Notes:

Should be run monthly at LINWOOD so the attribute can be added to those accounts
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
  borrowers.branchcode = 'LINWOOD' AND
  kanopy.attribute IS NULL AND
  borrowers.categorycode &lt;&gt; 'STAFF' AND
  borrowers.categorycode &lt;&gt; "ILL" AND
  borrowers.categorycode &lt;&gt; "INHOUSE" AND
  borrowers.categorycode &lt;&gt; "STATISTIC" AND
  borrowers.categorycode &lt;&gt; "S_SIP" AND 
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























