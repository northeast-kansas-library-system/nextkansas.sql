/*
R.003522

----------

Name: GHW - BASEHOR patrons without Kanopy access
Created by: George Williams

----------

Group:  BASEHOR
     -

Created on: 2021-06-14 11:39:47
Modified on: 2025-04-04 15:33:44
Date last run: 2025-08-06 09:47:22

----------

Public: 0
Expiry: 300

----------

 
Shows patrons with a BASEHOR home library but without a "Kanopy (BASEHOR): Allowed . . ." borrower attribute.
Shows borrwoers that currently lack this attribute
grouped by categorycode and borrowernumber
sorted by library card number
links to the borrower account

Notes:

Should be run monthly at BASEHOR so the attribute can be added to those accounts
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
  borrowers.branchcode = 'BASEHOR' AND
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

























