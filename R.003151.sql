/*
R.003151

----------

Name: GHW - Mapping Helper
Created by: George Williams

----------

Group: -
     -

Created on: 2018-12-27 18:03:14
Modified on: 2023-09-27 09:37:45
Date last run: 2023-09-27 09:38:10

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.address,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.branchcode,
  borrowers.categorycode,
  ROUND((DateDiff(CurDate(), borrowers.dateofbirth) / 365.25)) AS AGES
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE <> AND
  borrowers.city LIKE Concat(<>, "%") AND
  borrowers.state LIKE Concat(<>, "%") AND
  borrowers.zipcode LIKE Concat(<>, "%")
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.state,
  borrowers.city,
  borrowers.zipcode,
  borrowers.address,
  AGES DESC

























