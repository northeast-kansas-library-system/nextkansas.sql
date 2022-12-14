/*
R.003346

----------

Name: GHW - Sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-08-14 15:14:53
Modified on: 2022-12-14 09:30:56
Date last run: 2022-12-14 09:31:05

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.categorycode,
  borrowers.dateofbirth,
  borrowers.branchcode
FROM
  borrowers
WHERE
  borrowers.branchcode = 'SABETHA' AND
  borrowers.categorycode = 'TEACHER'

























