/*
R.003645

----------

Name: GHW - Zipcodes with fewer than 10 borrowers
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-02-01 09:46:22
Modified on: 2022-02-01 09:46:22
Date last run: 2022-02-01 09:46:27

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Left(Trim(borrowers.zipcode), 5) AS ZIP,
  Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber
FROM
  borrowers
GROUP BY
  Left(Trim(borrowers.zipcode), 5)
HAVING
  Count(DISTINCT borrowers.borrowernumber) < 10

























