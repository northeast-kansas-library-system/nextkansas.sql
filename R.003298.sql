/*
R.003298

----------

Name: GHW - LEAVENWRTH patrons without Kanopy access
Created by: George H Williams

----------

Group: Library-Specific
     Leavenworth

Created on: 2020-01-09 15:12:38
Modified on: 2020-01-09 15:34:15
Date last run: 2020-05-29 16:29:27

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
  borrowers.branchcode = 'LEAVENWRTH' AND
  kanopy.attribute IS NULL AND
  borrowers.categorycode <> 'STAFF' AND
  borrowers.categorycode <> "ILL" AND
  borrowers.categorycode <> "INHOUSE" AND
  borrowers.categorycode <> "STATISTIC" AND
  borrowers.othernames <> 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber



