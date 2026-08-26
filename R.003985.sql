/*
R.003985

----------

Name: GHW - Rules 001d - Default rules report - Renewals
Created by: George Williams

----------

Group: Rules
     -

Created on: 2026-08-16 17:44:04
Modified on: 2026-08-16 20:58:11
Date last run: 2026-08-16 17:53:22

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
  rules_table.renewalsallowed AS 'Renewals allowed (count)',
  rules_table.unseen_renewals_allowed AS 'Unseen renewals allowed (count)',
  rules_table.renewalperiod AS 'Renewal period',
  rules_table.norenewalbefore AS 'No renewal before',
  rules_table.noautorenewalbefore AS 'No automatic renewal before',
  rules_table.auto_renew AS 'Automatic renewal',
  rules_table.no_auto_renewal_after AS 'No automatic renewal after',
  rules_table.no_auto_renewal_after_hard_limit AS 'No automatic renewal after (hard limit)'
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
          WHEN circulation_rules.rule_name = 'renewalsallowed' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS renewalsallowed,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'unseen_renewals_allowed' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS unseen_renewals_allowed,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'renewalperiod' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS renewalperiod,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'norenewalbefore' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS norenewalbefore,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'noautorenewalbefore' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS noautorenewalbefore,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'auto_renew' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS auto_renew,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'no_auto_renewal_after' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS no_auto_renewal_after,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'no_auto_renewal_after_hard_limit' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS no_auto_renewal_after_hard_limit
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

























