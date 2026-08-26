/*
R.003990

----------

Name: GHW - Rules 003 - Checkout, hold policy by patron category
Created by: George Williams

----------

Group: -
     -

Created on: 2026-08-16 23:21:50
Modified on: 2026-08-23 23:53:25
Date last run: 2026-08-23 23:55:10

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches_categories_itypes.branchname AS 'Library',
  branches_categories_itypes.description AS 'Patron category',
  CASE
    WHEN rules_table.patron_maxissueqty IS NULL
    THEN 'UNLIMITED'
    WHEN rules_table.patron_maxissueqty = ''
    THEN 'UNLIMITED'
    ELSE rules_table.patron_maxissueqty
  END AS 'Total current checkouts allowed',
  CASE
    WHEN rules_table.patron_maxonsiteissueqty IS NULL
    THEN 'UNLIMITED'
    WHEN rules_table.patron_maxonsiteissueqty = ''
    THEN 'UNLIMITED'
    ELSE rules_table.patron_maxonsiteissueqty
  END AS 'Total current on-site checkouts allowed',
  CASE
    WHEN rules_table.max_holds IS NULL
    THEN 'UNLIMITED'
    WHEN rules_table.max_holds = ''
    THEN 'UNLIMITED'
    ELSE rules_table.max_holds
  END AS 'Total holds allowed'
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
     END) AS max_holds
   FROM
     circulation_rules
   WHERE
     Coalesce(circulation_rules.categorycode, 'all') NOT LIKE 'all'
   GROUP BY
     Coalesce(circulation_rules.branchcode, 'all'),
     Coalesce(circulation_rules.categorycode, 'all')) rules_table
    ON rules_table.branch = branches_categories_itypes.branchcode AND
      rules_table.cat = branches_categories_itypes.categorycode
WHERE
  rules_table.patron_maxissueqty IS NOT NULL AND
  (branches_categories_itypes.branchcode LIKE 'all' OR
    branches_categories_itypes.branchcode LIKE <<Your library|branches:all>>)
GROUP BY
  branches_categories_itypes.branchname,
  branches_categories_itypes.description,
  rules_table.patron_maxonsiteissueqty,
  rules_table.max_holds,
  rules_table.patron_maxissueqty
ORDER BY
  If(branches_categories_itypes.branchname = ' All libraries', 'Z', branches_categories_itypes.branchname),
  If(branches_categories_itypes.description = ' All categories', 'Z', branches_categories_itypes.description),
  If(branches_categories_itypes.description1 = ' All item types', 'Z', branches_categories_itypes.description1)

























