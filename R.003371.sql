/*
R.003371

----------

Name: GHW - Non-SABETHA patrons with SABETHA Kanopy access 
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-16 10:45:17
Modified on: 2020-11-16 15:53:49
Date last run: 2020-11-16 15:53:54

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
      borrower_attributes.code = 'SABEKANOPY'
  ) kanopy
    ON kanopy.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode <> 'SABETHA' AND
  kanopy.attribute = 'SABETHA' AND
  borrowers.othernames <> 'SIP2 test account'
GROUP BY
  borrowers.categorycode,
  borrowers.borrowernumber
ORDER BY
  borrowers.cardnumber



