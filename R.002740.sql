/*
R.002740

----------

Name: GHW - Borrowers count - date ranges
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2016-08-24 08:59:47
Modified on: 2016-08-24 16:46:37
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  borrowers.branchcode AS BORROWERS_HOME_LIBRARY,
  categories.description AS BORROWERS_CATEGORY,
  Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS
FROM
  borrowers JOIN
  categories
    ON borrowers.categorycode = categories.categorycode
WHERE
  borrowers.branchcode LIKE <<Borrowers branch|LBRANCH>> AND
  borrowers.categorycode LIKE <<Borrowers category|LBORROWERCAT >> AND
  (borrowers.dateenrolled BETWEEN <<Borrowers created after<br />(enter 01/01/1970 if you want all borrowers)|date>> AND (<<Borrowers created before<br />(enter today's date if you want all borrowers)|date>>))
GROUP BY
  BORROWERS_HOME_LIBRARY, BORROWERS_CATEGORY
  WITH ROLLUP



