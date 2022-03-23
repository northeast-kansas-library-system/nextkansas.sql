/*
R.003650

----------

Name: GHW - Holds policy report
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-02-23 17:51:00
Modified on: 2022-02-23 17:51:00
Date last run: 2022-02-24 11:45:59

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branchess.branchcode,
  holdallowed.itemtype,
  holdallowed.rule_value,
  hold_fulfillment_policy.rule_value AS rule_value1,
  returnbranch.rule_value AS rule_value2
FROM
  (SELECT
      branches.branchcode
    FROM
      branches
    UNION
    SELECT
      "All branches" AS branchcode) branchess LEFT JOIN
  (SELECT
      Coalesce(circulation_rules.branchcode, "All branches") AS branchcode,
      circulation_rules.categorycode,
      circulation_rules.itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'holdallowed' AND
      circulation_rules.itemtype LIKE <<Enter item type code>>
    GROUP BY
      Coalesce(circulation_rules.branchcode, "All branches"),
      circulation_rules.categorycode,
      circulation_rules.itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value) holdallowed ON holdallowed.branchcode =
      branchess.branchcode LEFT JOIN
  (SELECT
      Coalesce(circulation_rules.branchcode, "All branches") AS branchcode,
      circulation_rules.categorycode,
      circulation_rules.itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'hold_fulfillment_policy' AND
      circulation_rules.itemtype LIKE <<Enter item type code>>
    GROUP BY
      Coalesce(circulation_rules.branchcode, "All branches"),
      circulation_rules.categorycode,
      circulation_rules.itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value) hold_fulfillment_policy ON
      hold_fulfillment_policy.branchcode = branchess.branchcode LEFT JOIN
  (SELECT
      Coalesce(circulation_rules.branchcode, "All branches") AS branchcode,
      circulation_rules.categorycode,
      circulation_rules.itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'returnbranch' AND
      circulation_rules.itemtype LIKE <<Enter item type code>>
    GROUP BY
      Coalesce(circulation_rules.branchcode, "All branches"),
      circulation_rules.categorycode,
      circulation_rules.itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value) returnbranch ON returnbranch.branchcode =
      branchess.branchcode
GROUP BY
  branchess.branchcode,
  holdallowed.itemtype,
  holdallowed.rule_value,
  hold_fulfillment_policy.rule_value,
  returnbranch.rule_value
ORDER BY
  branchess.branchcode,
  holdallowed.itemtype

























