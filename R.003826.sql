/*
R.003826

----------

Name: GHW - Borrower city and state by library and category
Created by: George Williams

----------

Group: -
     -

Created on: 2024-04-11 16:15:32
Modified on: 2024-04-11 16:15:32
Date last run: 2024-04-11 16:16:18

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches.branchname,
  categories.description,
  Concat_Ws('', borrowers.city, ', ', borrowers.state) AS CITY_STATE
FROM
  borrowers JOIN
  branches ON borrowers.branchcode = branches.branchcode INNER JOIN
  categories ON borrowers.categorycode = categories.categorycode
WHERE
  borrowers.branchcode LIKE <<Choose your library|ZBRAN>> AND
  borrowers.categorycode = <<Choose a borrower category|categorycode:all>>
GROUP BY
  branches.branchname,
  categories.description,
  Concat_Ws('', borrowers.city, ', ', borrowers.state)

























