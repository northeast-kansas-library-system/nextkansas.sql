/*
R.003965

----------

Name: GHW - sandbox
Created by: George Williams

----------

Group: -
     -

Created on: 2026-07-16 10:16:10
Modified on: 2026-07-20 10:04:13
Date last run: 2026-07-20 10:04:13

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  categories.description,
  categories.categorycode
FROM
  categories INNER JOIN
  categories_branches ON categories_branches.categorycode =
      categories.categorycode
WHERE
  categories_branches.branchcode = 'SENECA'

























