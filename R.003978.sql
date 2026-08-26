/*
R.003978

----------

Name: sandbox
Created by: George Williams

----------

Group: -
     -

Created on: 2026-08-11 14:59:20
Modified on: 2026-08-23 20:00:35
Date last run: 2026-08-23 20:01:08

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches_categories_itypes.branchname AS 'Library',
  rules_table.patron_maxissueqty AS 'Total current checkouts allowed',
  rules_table.patron_maxonsiteissueqty AS 'Total current on-site checkouts allowed',
  rules_table.max_holds AS 'Maximum total holds allowed (count)',
  CASE
    WHEN rules_table.holdallowed IS NULL
    THEN 'Not set'
    WHEN rules_table.holdallowed = ''
    THEN 'Not set'
    WHEN rules_table.holdallowed = 'from_any_library'
    THEN 'From any library'
    WHEN rules_table.holdallowed = 'from_local_hold_group'
    THEN 'From local hold group'
    WHEN rules_table.holdallowed = 'from_home_library'
    THEN 'From home library'
    WHEN rules_table.holdallowed = 'not_allowed'
    THEN 'No holds allowed'
    ELSE '-----'
  END AS 'Hold policy',
  CASE
    WHEN rules_table.hold_fulfillment_policy IS NULL
    THEN 'Not set'
    WHEN rules_table.hold_fulfillment_policy = ''
    THEN 'Not set'
    WHEN rules_table.hold_fulfillment_policy = 'any'
    THEN 'any library'
    WHEN rules_table.hold_fulfillment_policy = 'holdgroup'
    THEN 'item\'s hold group'
    WHEN rules_table.hold_fulfillment_policy = 'patrongroup'
    THEN 'patron\'s hold group'
    WHEN rules_table.hold_fulfillment_policy = 'homebranch'
    THEN 'item\'s home library'
    WHEN rules_table.hold_fulfillment_policy = 'holdingbranch'
    THEN 'item\'s holding library'
    ELSE '-----'
  END AS 'Hold and booking pickup library match',
  rules_table.bookings_lead_period AS 'Booking pre-processing (days)',
  CASE
    WHEN rules_table.returnbranch IS NULL
    THEN 'Not set'
    WHEN rules_table.returnbranch = ''
    THEN 'Not set'
    WHEN rules_table.returnbranch = 'homebranch'
    THEN 'Item returns home'
    WHEN rules_table.returnbranch = 'holdingbranch'
    THEN 'Item returns to issuing library'
    WHEN rules_table.returnbranch = 'noreturn'
    THEN 'Item floats'
    WHEN rules_table.returnbranch = 'returnbylibrarygroup'
    THEN 'Item floats by library group'
    ELSE '-----'
  END AS 'Return policy'
FROM
  (SELECT
     branchess.branchcode,
     branchess.branchname,
     categoriess.categorycode,
     categoriess.description,
     itypess.itemtype,
     itypess.description AS description1
   FROM
     (SELECT
        'all' AS branchcode,
        ' All Libraries' AS branchname
      FROM
        branches
      UNION
      SELECT
        branches.branchcode,
        branches.branchname
      FROM
        branches) branchess,
     (SELECT
        'all' AS categorycode,
        ' All categories' AS description
      UNION
      SELECT
        categories.categorycode,
        categories.description
      FROM
        categories) categoriess,
     (SELECT
        'all' AS itemtype,
        ' All item types' AS description
      UNION
      SELECT
        itemtypes.itemtype,
        itemtypes.description
      FROM
        itemtypes) itypess) branches_categories_itypes
  JOIN (SELECT
     Coalesce(circulation_rules.branchcode, 'all') AS branch,
     Coalesce(circulation_rules.categorycode, 'all') AS cat,
     Coalesce(circulation_rules.itemtype, 'all') AS type,
     Max(CASE
       WHEN circulation_rules.rule_name = 'patron_maxissueqty'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS patron_maxissueqty,
     Max(CASE
       WHEN circulation_rules.rule_name = 'patron_maxonsiteissueqty'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS patron_maxonsiteissueqty,
     Max(CASE
       WHEN circulation_rules.rule_name = 'max_holds'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS max_holds,
     Max(CASE
       WHEN circulation_rules.rule_name = 'holdallowed'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS holdallowed,
     Max(CASE
       WHEN circulation_rules.rule_name = 'hold_fulfillment_policy'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS hold_fulfillment_policy,
     Max(CASE
       WHEN circulation_rules.rule_name = 'bookings_lead_period'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS bookings_lead_period,
     Max(CASE
       WHEN circulation_rules.rule_name = 'returnbranch'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS returnbranch
   FROM
     circulation_rules
   WHERE
     Coalesce(circulation_rules.categorycode, 'all') = 'all' AND
     Coalesce(circulation_rules.itemtype, 'all') = 'all'
   GROUP BY
     Coalesce(circulation_rules.branchcode, 'all'),
     Coalesce(circulation_rules.categorycode, 'all'),
     Coalesce(circulation_rules.itemtype, 'all')) rules_table
    ON rules_table.branch = branches_categories_itypes.branchcode AND
      rules_table.cat = branches_categories_itypes.categorycode AND
      rules_table.type = branches_categories_itypes.itemtype
WHERE
  (branches_categories_itypes.branchcode LIKE 'all' OR 
    branches_categories_itypes.branchcode LIKE CONCAT('%', <<Choose your library|branches:all>>, '%'))
ORDER BY
  If(branches_categories_itypes.branchname = ' All libraries', 'Z', branches_categories_itypes.branchname),
  If(branches_categories_itypes.description = ' All categories', 'Z', branches_categories_itypes.description),
  If(branches_categories_itypes.description1 = ' All item types', 'Z', branches_categories_itypes.description1)

























