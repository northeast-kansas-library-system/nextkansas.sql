/*
R.003301

----------

Name: GHW - Non-OTTAWA patrons with OTTAWA Kanopy access
Created by: George H Williams

----------

Group: Library-Specific
     Ottawa

Created on: 2020-01-09 15:33:11
Modified on: 2020-01-09 15:33:24
Date last run: 2020-01-28 00:26:26

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat('<a href="/cgi-bin/koha/members/memberentry.pl?op=modify&borrowernumber=', borrowers.borrowernumber, '&step=4" target="_blank">Go to patron account</a>') AS LINK,
  borrowers.cardnumber
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
  borrowers.branchcode <> 'OTTAWA' AND
  kanopy.attribute = 'OTTAWA' AND
  borrowers.othernames <> 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber



