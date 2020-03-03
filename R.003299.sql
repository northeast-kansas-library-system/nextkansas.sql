/*
R.003299

----------

Name: GHW - Non-LEAVENWRTH patrons with LEAVENWRTH Kanopy access
Created by: George H Williams

----------

Group: Library-Specific
     Leavenworth

Created on: 2020-01-09 15:15:12
Modified on: 2020-01-09 15:28:02
Date last run: 2020-01-28 00:17:18

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
      borrower_attributes.code = 'LEAVKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode <> 'LEAVENWRTH' AND
  kanopy.attribute = 'LEAVENWRTH' AND
  borrowers.othernames <> 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber



