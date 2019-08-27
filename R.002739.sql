/*
R.002739

----------

Name: GHW - Borrowers test-template
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-08-23 17:47:41
Modified on: 2016-08-24 10:25:13
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  borrowers.branchcode AS BORROWERS_HOME_LIBRARY,
  borrowers.categorycode AS BORROWERS_CATEGORY_CODE,
  Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE <<Borrower's home library|branches>>
GROUP BY
  BORROWERS_HOME_LIBRARY, BORROWERS_CATEGORY_CODE
  WITH ROLLUP



