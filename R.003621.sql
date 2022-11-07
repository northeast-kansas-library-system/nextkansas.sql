/*
R.003621

----------

Name: GHW - Pending borrower updates
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-11-09 00:22:51
Modified on: 2021-11-09 00:32:45
Date last run: 2022-11-07 09:37:06

----------

Public: 0
Expiry: 30

----------



----------
*/



SELECT
  "hidden" AS class
FROM
  borrower_modifications JOIN
  borrowers ON borrowers.borrowernumber = borrower_modifications.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Enter branchcode>>
GROUP BY
  borrowers.branchcode

























