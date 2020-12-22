/*
R.003346

----------

Name: GHW - Sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-08-14 15:14:53
Modified on: 2020-10-28 19:04:08
Date last run: 2020-10-28 19:04:33

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  borrowers.borrowernumber,
  borrowers.branchcode,
  borrowers.categorycode
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE <<Choose your library|branches>> AND
  borrowers.categorycode LIKE <<Choose a patron category|categorycode>>



