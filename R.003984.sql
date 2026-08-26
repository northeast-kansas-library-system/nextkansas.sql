/*
R.003984

----------

Name: GHW - Rules 001c - Default rules report - Fines
Created by: George Williams

----------

Group: Rules
     -

Created on: 2026-08-16 17:41:56
Modified on: 2026-08-16 20:58:20
Date last run: 2026-08-16 18:19:06

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
  rules_table.fine AS 'Fine amount',
  rules_table.chargeperiod AS 'Fine charging interval',
  CASE
    WHEN rules_table.chargeperiod_charge_at = 0 THEN 'End of interval'
    WHEN rules_table.chargeperiod_charge_at = 1 THEN 'Start of interval'
    ELSE rules_table.chargeperiod_charge_at
  END AS 'When to charge',
  rules_table.firstremind AS 'Fine/suspension grace period',
  rules_table.overduefinescap AS 'Overdue fines cap (amount)',
  rules_table.cap_fine_to_replacement_price AS 'Cap fine at replacement price',
  rules_table.expire_reserves_charge AS 'Expired hold charge',
  rules_table.finedays AS 'Suspension in days (day)',
  rules_table.maxsuspensiondays AS 'Max. suspension duration (day)',
  rules_table.suspension_chargeperiod AS 'Suspension charging interval'
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
          WHEN circulation_rules.rule_name = 'fine' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS fine,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'chargeperiod' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS chargeperiod,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'chargeperiod_charge_at' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS chargeperiod_charge_at,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'firstremind' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS firstremind,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'overduefinescap' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS overduefinescap,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'cap_fine_to_replacement_price' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS cap_fine_to_replacement_price,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'expire_reserves_charge' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS expire_reserves_charge,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'finedays' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS finedays,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'maxsuspensiondays' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS maxsuspensiondays,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'suspension_chargeperiod' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS suspension_chargeperiod
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

























