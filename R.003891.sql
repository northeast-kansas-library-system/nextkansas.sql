/*
R.003891

----------

Name: GHW - Maximum circulation rules
Created by: George Williams

----------

Group: -
     -

Created on: 2025-06-23 13:32:21
Modified on: 2025-06-23 13:32:21
Date last run: 2025-12-19 14:55:34

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  (Count(DISTINCT branches.branchcode) + 1) AS BRANCH_COUNT,
  (Count(DISTINCT categories.categorycode) + 1) AS CATEGORY_COUNT,
  (Count(DISTINCT itemtypes.itemtype) + 1) AS TYPE_COUNT,
  ((Count(DISTINCT branches.branchcode) + 1) * (Count(DISTINCT
  categories.categorycode) + 1) * (Count(DISTINCT itemtypes.itemtype) +
  1)) AS MAX_RULES
FROM
  branches,
  categories,
  itemtypes

























