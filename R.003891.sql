/*
R.003891

----------

Name: GHW - Rules matrix possible vs actual
Created by: George Williams

----------

Group: Rules
     -

Created on: 2025-06-23 13:32:21
Modified on: 2026-03-27 14:00:26
Date last run: 2026-03-27 14:00:26

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  'Rules matrix - actual rules in matrix' AS 'Type of count',
  Count(*) AS 'Rule count'
FROM
  circulation_rules
WHERE
  circulation_rules.rule_name = 'maxissueqty'
UNION
SELECT
  'Rules matrix - maximum possible' AS 'Type of count',
  ((Count(DISTINCT branches.branchcode) + 1) * (Count(DISTINCT
  categories.categorycode) + 1) * (Count(DISTINCT itemtypes.itemtype) +
  1)) AS 'Rule count'
FROM
  branches,
  categories,
  itemtypes

























