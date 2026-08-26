/*
R.003988

----------

Name: GHW - Rules 001g - Default rules report - Recalls
Created by: George Williams

----------

Group: Rules
     -

Created on: 2026-08-16 17:48:05
Modified on: 2026-08-16 20:57:48
Date last run: 2026-08-16 17:54:32

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches_categories_itypes.branchname AS 'Library',
  branches_categories_itypes.description AS 'Patron category',
  branches_categories_itypes.description1 AS 'Item type',
  rules_table.recalls_allowed AS 'Recalls allowed (total)',
  rules_table.recalls_per_record AS 'Recalls per record (count)',
  CASE
    WHEN rules_table.on_shelf_recalls = 'any' THEN "If any unavailable"
    WHEN rules_table.on_shelf_recalls = 'all' THEN 'If all unavailable'
    ELSE rules_table.on_shelf_recalls
  END AS 'On shelf recalls allowed',
  rules_table.recall_due_date_interval AS 'Recall due date interval (day)',
  rules_table.recall_overdue_fine AS 'Recall overdue fine amount',
  rules_table.recall_shelf_time AS 'Recall pickup period (day)'
FROM
  (
    SELECT
      branchess.branchcode,
      branchess.branchname,
      categoriess.categorycode,
      categoriess.description,
      itypess.itemtype,
      itypess.description AS description1
    FROM
      (
        SELECT
          'all' AS branchcode,
          ' All Libraries' AS branchname
        FROM
          branches
        UNION
        SELECT
          branches.branchcode,
          branches.branchname
        FROM
          branches
      ) branchess,
      (
        SELECT
          'all' AS categorycode,
          ' All categories' AS description
        UNION
        SELECT
          categories.categorycode,
          categories.description
        FROM
          categories
      ) categoriess,
      (
        SELECT
          'all' AS itemtype,
          ' All item types' AS description
        UNION
        SELECT
          itemtypes.itemtype,
          itemtypes.description
        FROM
          itemtypes
      ) itypess
  ) branches_categories_itypes
  JOIN (
    SELECT
      Coalesce(circulation_rules.branchcode, 'all') AS branch,
      Coalesce(circulation_rules.categorycode, 'all') AS cat,
      Coalesce(circulation_rules.itemtype, 'all') AS type,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'recalls_allowed' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS recalls_allowed,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'recalls_per_record' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS recalls_per_record,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'on_shelf_recalls' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS on_shelf_recalls,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'recall_due_date_interval' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS recall_due_date_interval,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'recall_overdue_fine' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS recall_overdue_fine,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'recall_shelf_time' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS recall_shelf_time
    FROM
      circulation_rules
    GROUP BY
      Coalesce(circulation_rules.branchcode, 'all'),
      Coalesce(circulation_rules.categorycode, 'all'),
      Coalesce(circulation_rules.itemtype, 'all')
    HAVING
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'lengthunit' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) IS NOT NULL
  ) rules_table ON rules_table.branch = branches_categories_itypes.branchcode AND
  rules_table.cat = branches_categories_itypes.categorycode AND
  rules_table.type = branches_categories_itypes.itemtype,
  (
    SELECT
      Coalesce(
        Max(
          CASE
            WHEN circulation_rules.rule_name = 'maxissueqty' AND
            Concat_Ws(
              '_',
              circulation_rules.branchcode,
              Coalesce(circulation_rules.categorycode, 'all'),
              Coalesce(circulation_rules.itemtype, 'all')
            ) = Concat(<<Your library|branches:all>>, '_all_all') THEN '1'
          END
        ),
        0
      ) AS All_Rule
    FROM
      circulation_rules
  ) rule_check
WHERE
  (
    branches_categories_itypes.branchcode LIKE <<Your library|branches:all>> OR
    branches_categories_itypes.branchcode LIKE CASE
      WHEN rule_check.All_Rule = 0 THEN 'all'
      ELSE 'x'
    END
  )
ORDER BY
  If(
    branches_categories_itypes.branchname = ' All libraries',
    'Z',
    branches_categories_itypes.branchname
  ),
  If(
    branches_categories_itypes.description = ' All categories',
    'Z',
    branches_categories_itypes.description
  ),
  If(
    branches_categories_itypes.description1 = ' All item types',
    'Z',
    branches_categories_itypes.description1
  )

























