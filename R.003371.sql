/*
R.003371

----------

Name: GHW - Non-SABETHA patrons with SABETHA Kanopy access 
Created by: George Williams

----------

Group:  SABETHA
     -

Created on: 2020-11-16 10:45:17
Modified on: 2025-04-04 15:53:10
Date last run: 2025-04-04 15:53:10

----------

Public: 0
Expiry: 300

----------

 
Shows patrons with a "Kanopy (SABETHA): Allowed . . ." patron attribute but without a SABETHA homebranch
Shows borrwoers that currently have this attribute
grouped by categorycode and borrowernumber
sorted by library card number
links to the borrower account

Notes:

Should be run monthly at SABETHA so the attribute can be removed from those accounts
Go to the training information for the Kanopy (SABETHA) extended borrower attribute.

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
      borrower_attributes.code = 'SABEKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode &lt;&gt; 'SABETHA' AND
  kanopy.attribute = 'SABETHA' AND
  borrowers.othernames &lt;&gt; 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber

























