/*
R.003299

----------

Name: GHW - Non-LEAVENWRTH patrons with LEAVENWRTH Kanopy access
Created by: George Williams

----------

Group:  LEAVENWRTH
     -

Created on: 2020-01-09 15:15:12
Modified on: 2025-04-04 15:55:41
Date last run: 2025-10-23 18:07:00

----------

Public: 0
Expiry: 300

----------

 
Shows patrons with a "Kanopy (LEAVENWRTH): Allowed . . ." patron attribute but without a LEAVENWRTH homebranch
Shows borrwoers that currently have this attribute
grouped by categorycode and borrowernumber
sorted by library card number
links to the borrower account

Notes:

Should be run monthly at LEAVENWRTH so the attribute can be removed from those accounts
Go to the training information for the Kanopy (LEAVENWRTH) extended borrower attribute.

Click here to run in a new window
kanopy; patron-extended-attributes;


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
      borrower_attributes.code = 'LEAVKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode &lt;&gt; 'LEAVENWRTH' AND
  kanopy.attribute = 'LEAVENWRTH' AND
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























