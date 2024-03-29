/*
R.003013

----------

Name: GHW - Unneeded restrictions II
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-11-16 08:38:02
Modified on: 2017-11-16 22:09:08
Date last run: 2021-07-20 08:44:47

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/members/boraccount.pl?borrowernumber=', borrowers.borrowernumber,'\" target="_blank">Link to patron</a>') AS LINK_TO_PATRON,
  borrowers.cardnumber,
  borrowers.branchcode,
  borrower_debarments.created,
  borrower_debarments.updated,
  borrower_debarments.expiration,
  borrower_debarments.comment
FROM
  borrowers
  LEFT JOIN accountlines ON accountlines.borrowernumber = borrowers.borrowernumber
  LEFT JOIN issues ON issues.borrowernumber = borrowers.borrowernumber
  INNER JOIN borrower_debarments ON borrower_debarments.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Choose library|LBRANCH>>
GROUP BY
  borrowers.borrowernumber,
  borrower_debarments.borrower_debarment_id,
  borrower_debarments.comment
HAVING
  Sum(accountlines.amountoutstanding) = 0 AND
  Count(issues.issue_id) = 0
ORDER BY
  borrowers.branchcode,
  borrower_debarments.created

























