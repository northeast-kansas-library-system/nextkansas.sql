/*
R.003636

----------

Name: GHW - Circ rules test pattern
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-01-04 23:10:19
Modified on: 2022-01-07 21:54:29
Date last run: 2023-02-15 11:08:45

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  circulation_rules.id,
  Coalesce(circulation_rules.branchcode, " All"),
  Coalesce(circulation_rules.categorycode, " All"),
  Coalesce(circulation_rules.itemtype, " All"),
  circulation_rules.rule_name,
  circulation_rules.rule_value
FROM
  circulation_rules
WHERE
  Coalesce(circulation_rules.branchcode, " All") LIKE <<branch|branches:all>> AND
  Coalesce(circulation_rules.categorycode, " All") LIKE <<borrower category|categorycode:all>> AND
  Coalesce(circulation_rules.itemtype, " All") LIKE <<item type|itemtypes:all>> AND
  circulation_rules.rule_name LIKE "%"
GROUP BY
  circulation_rules.id,
  Coalesce(circulation_rules.branchcode, " All"),
  Coalesce(circulation_rules.categorycode, " All"),
  Coalesce(circulation_rules.itemtype, " All"),
  circulation_rules.rule_name,
  circulation_rules.rule_value
ORDER BY
  Coalesce(circulation_rules.branchcode, " All"),
  Coalesce(circulation_rules.categorycode, " All"),
  Coalesce(circulation_rules.itemtype, " All"),
  circulation_rules.rule_name,
  circulation_rules.rule_value

























