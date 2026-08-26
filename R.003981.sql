/*
R.003981

----------

Name: GHW - Rules 001 - Default rules report - Full table
Created by: George Williams

----------

Group: Rules
     -

Created on: 2026-08-16 17:36:11
Modified on: 2026-08-16 20:58:43
Date last run: 2026-08-23 15:43:08

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
  rules_table.maxissueqty AS 'Current checkouts allowed',
  rules_table.maxonsiteissueqty AS 'Current on-site checkouts allowed',
  rules_table.issuelength AS 'Loan period',
  CASE
    WHEN rules_table.daysmode = 0 THEN 'Default'
    WHEN rules_table.daysmode IS NULL THEN 'Default'
    WHEN rules_table.daysmode = '' THEN 'Default'
    WHEN rules_table.daysmode = 'Calendar' THEN 'Skip'
    WHEN rules_table.daysmode = 'Datedue' THEN 'Next open day'
    WHEN rules_table.daysmode = 'Days' THEN 'Ignore the calendar'
    WHEN rules_table.daysmode = 'Dayweek' THEN 'Same week day'
    ELSE rules_table.daysmode
  END AS 'Days mode',
  rules_table.lengthunit AS 'Unit',
  CASE
    WHEN rules_table.hardduedatecompare = -1 THEN 'Before'
    WHEN rules_table.hardduedatecompare = 0 THEN 'After'
    WHEN rules_table.hardduedatecompare = 1 THEN 'Exactly on'
    ELSE rules_table.hardduedatecompare
  END AS 'Hard due date (comparison)',
  rules_table.hardduedate AS 'Hard due date',
  rules_table.decreaseloanholds AS 'Decreased loan period for high holds (day)',
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
  rules_table.suspension_chargeperiod AS 'Suspension charging interval',
  rules_table.renewalsallowed AS 'Renewals allowed (count)',
  rules_table.unseen_renewals_allowed AS 'Unseen renewals allowed (count)',
  rules_table.renewalperiod AS 'Renewal period',
  rules_table.norenewalbefore AS 'No renewal before',
  rules_table.noautorenewalbefore AS 'No automatic renewal before',
  rules_table.auto_renew AS 'Automatic renewal',
  rules_table.no_auto_renewal_after AS 'No automatic renewal after',
  rules_table.no_auto_renewal_after_hard_limit AS 'No automatic renewal after (hard limit)',
  rules_table.reservesallowed AS 'Holds allowed (total)',
  rules_table.holds_per_day AS 'Holds allowed (daily)',
  rules_table.holds_per_record AS 'Holds per record (count)',
  rules_table.onshelfholds AS 'On shelf holds allowed',
  CASE
    WHEN rules_table.opacitemholds = 'N' THEN "Don't allow"
    WHEN rules_table.opacitemholds = 'Y' THEN 'Allow'
    WHEN rules_table.opacitemholds = 'F' THEN 'Force'
    ELSE rules_table.opacitemholds
  END AS 'OPAC item level holds',
  rules_table.holds_pickup_period AS 'Holds pickup period (day)',
  rules_table.hold_fee AS 'Hold fee',
  rules_table.article_requests AS 'Article requests',
  rules_table.rentaldiscount AS 'Rental discount (%)',
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
          WHEN circulation_rules.rule_name = 'maxissueqty' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS maxissueqty,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'maxonsiteissueqty' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS maxonsiteissueqty,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'issuelength' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS issuelength,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'daysmode' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS daysmode,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'lengthunit' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS lengthunit,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'hardduedatecompare' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS hardduedatecompare,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'hardduedate' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS hardduedate,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'decreaseloanholds' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS decreaseloanholds,
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
      ) AS suspension_chargeperiod,
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
      ) AS no_auto_renewal_after_hard_limit,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'reservesallowed' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS reservesallowed,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'holds_per_day' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS holds_per_day,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'holds_per_record' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS holds_per_record,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'onshelfholds' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS onshelfholds,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'opacitemholds' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS opacitemholds,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'holds_pickup_period' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS holds_pickup_period,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'hold_fee' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS hold_fee,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'article_requests' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS article_requests,
      Max(
        CASE
          WHEN circulation_rules.rule_name = 'rentaldiscount' THEN circulation_rules.rule_value
          ELSE NULL
        END
      ) AS rentaldiscount,
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

























