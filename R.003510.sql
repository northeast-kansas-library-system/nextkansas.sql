/*
R.003510

----------

Name: GHW - Tempsville ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-05-21 17:00:57
Modified on: 2021-05-21 17:00:57
Date last run: 2021-06-06 19:10:53

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.branchcode,
  borrowers.categorycode
FROM
  borrowers
WHERE
  borrowers.branchcode = 'OTTAWA' AND
  borrowers.categorycode = 'ASSOCIATE'



