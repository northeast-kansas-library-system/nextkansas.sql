/*
R.003496

----------

Name: GHW - Non-LANSING patrons with LANSING Kanopy access 
Created by: George Williams

----------

Group:  LANSING
     -

Created on: 2021-04-22 16:55:19
Modified on: 2025-04-04 15:52:20
Date last run: 2025-05-16 11:04:24

----------

Public: 0
Expiry: 300

----------

 
Shows patrons with a "Kanopy (LANSING): Allowed . . ." patron attribute but without a LANSING homebranch
Shows borrwoers that currently have this attribute
grouped by categorycode and borrowernumber
sorted by library card number
links to the borrower account

Notes:

Should be run monthly at LANSING so the attribute can be removed from those accounts
Go to the training information for the Kanopy (LANSING) extended borrower attribute.

kanopy; patron-extended-attributes; LANSING;


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
      borrower_attributes.code = 'LANSKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode &lt;&gt; 'LANSING' AND
  kanopy.attribute = 'LANSING' AND
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























