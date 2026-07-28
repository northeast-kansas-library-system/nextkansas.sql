/*
R.003968

----------

Name: GHW - Rules 001a - circulation and renewal rules only
Created by: George Williams

----------

Group: -
     -

Created on: 2026-07-23 17:26:36
Modified on: 2026-07-25 22:36:57
Date last run: 2026-07-25 22:13:05

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
    WHEN rules_table.daysmode = 0
    THEN 'Default'
    WHEN rules_table.daysmode IS NULL
    THEN 'Default'
    WHEN rules_table.daysmode = ''
    THEN 'Default'
    WHEN rules_table.daysmode = 'Calendar'
    THEN 'Skip'
    WHEN rules_table.daysmode = 'Datedue'
    THEN 'Next open day'
    WHEN rules_table.daysmode = 'Days'
    THEN 'Ignore the calendar'
    WHEN rules_table.daysmode = 'Dayweek'
    THEN 'Same week day'
    ELSE rules_table.daysmode
  END AS 'Days mode',
  rules_table.lengthunit AS 'Unit',
  CASE
    WHEN rules_table.hardduedatecompare = -1
    THEN 'Before'
    WHEN rules_table.hardduedatecompare = 0
    THEN 'After'
    WHEN rules_table.hardduedatecompare = 1
    THEN 'Exactly on'
    ELSE rules_table.hardduedatecompare
  END AS 'Hard due date (comparison)',
  rules_table.hardduedate AS 'Hard due date',
  rules_table.decreaseloanholds AS 'Decreased loan period for high holds (day)',
  rules_table.expire_reserves_charge AS 'Expired hold charge',
  rules_table.renewalsallowed AS 'Renewals allowed (count)',
  rules_table.renewalperiod AS 'Renewal period',
  rules_table.norenewalbefore AS 'No renewal before',
  rules_table.noautorenewalbefore AS 'No automatic renewal before',
  rules_table.auto_renew AS 'Automatic renewal',
  rules_table.no_auto_renewal_after AS 'No automatic renewal after',
  rules_table.no_auto_renewal_after_hard_limit AS 'No automatic renewal after (hard limit)'
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
       WHEN circulation_rules.rule_name = 'maxissueqty'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS maxissueqty,
     Max(CASE
       WHEN circulation_rules.rule_name = 'maxonsiteissueqty'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS maxonsiteissueqty,
     Max(CASE
       WHEN circulation_rules.rule_name = 'issuelength'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS issuelength,
     Max(CASE
       WHEN circulation_rules.rule_name = 'daysmode'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS daysmode,
     Max(CASE
       WHEN circulation_rules.rule_name = 'lengthunit'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS lengthunit,
     Max(CASE
       WHEN circulation_rules.rule_name = 'hardduedatecompare'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS hardduedatecompare,
     Max(CASE
       WHEN circulation_rules.rule_name = 'hardduedate'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS hardduedate,
     Max(CASE
       WHEN circulation_rules.rule_name = 'decreaseloanholds'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS decreaseloanholds,
     Max(CASE
       WHEN circulation_rules.rule_name = 'fine'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS fine,
     Max(CASE
       WHEN circulation_rules.rule_name = 'chargeperiod'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS chargeperiod,
     Max(CASE
       WHEN circulation_rules.rule_name = 'chargeperiod_charge_at'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS chargeperiod_charge_at,
     Max(CASE
       WHEN circulation_rules.rule_name = 'firstremind'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS firstremind,
     Max(CASE
       WHEN circulation_rules.rule_name = 'overduefinescap'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS overduefinescap,
     Max(CASE
       WHEN circulation_rules.rule_name = 'cap_fine_to_replacement_price'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS cap_fine_to_replacement_price,
     Max(CASE
       WHEN circulation_rules.rule_name = 'expire_reserves_charge'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS expire_reserves_charge,
     Max(CASE
       WHEN circulation_rules.rule_name = 'finedays'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS finedays,
     Max(CASE
       WHEN circulation_rules.rule_name = 'maxsuspensiondays'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS maxsuspensiondays,
     Max(CASE
       WHEN circulation_rules.rule_name = 'suspension_chargeperiod'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS suspension_chargeperiod,
     Max(CASE
       WHEN circulation_rules.rule_name = 'renewalsallowed'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS renewalsallowed,
     Max(CASE
       WHEN circulation_rules.rule_name = 'renewalperiod'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS renewalperiod,
     Max(CASE
       WHEN circulation_rules.rule_name = 'norenewalbefore'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS norenewalbefore,
     Max(CASE
       WHEN circulation_rules.rule_name = 'noautorenewalbefore'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS noautorenewalbefore,
     Max(CASE
       WHEN circulation_rules.rule_name = 'auto_renew'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS auto_renew,
     Max(CASE
       WHEN circulation_rules.rule_name = 'no_auto_renewal_after'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS no_auto_renewal_after,
     Max(CASE
       WHEN circulation_rules.rule_name = 'no_auto_renewal_after_hard_limit'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS no_auto_renewal_after_hard_limit,
     Max(CASE
       WHEN circulation_rules.rule_name = 'reservesallowed'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS reservesallowed,
     Max(CASE
       WHEN circulation_rules.rule_name = 'holds_per_day'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS holds_per_day,
     Max(CASE
       WHEN circulation_rules.rule_name = 'holds_per_record'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS holds_per_record,
     Max(CASE
       WHEN circulation_rules.rule_name = 'onshelfholds'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS onshelfholds,
     Max(CASE
       WHEN circulation_rules.rule_name = 'opacitemholds'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS opacitemholds,
     Max(CASE
       WHEN circulation_rules.rule_name = 'holds_pickup_period'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS holds_pickup_period,
     Max(CASE
       WHEN circulation_rules.rule_name = 'article_requests'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS article_requests,
     Max(CASE
       WHEN circulation_rules.rule_name = 'rentaldiscount'
       THEN circulation_rules.rule_value
       ELSE NULL
     END) AS rentaldiscount
   FROM
     circulation_rules
   GROUP BY
     Coalesce(circulation_rules.branchcode, 'all'),
     Coalesce(circulation_rules.categorycode, 'all'),
     Coalesce(circulation_rules.itemtype, 'all')
   HAVING
     lengthunit IS NOT NULL) rules_table
    ON rules_table.branch = branches_categories_itypes.branchcode AND
      rules_table.cat = branches_categories_itypes.categorycode AND
      rules_table.type = branches_categories_itypes.itemtype,
  (SELECT
     Coalesce(Max(CASE
       WHEN circulation_rules.rule_name = 'maxissueqty' AND Concat_Ws('_', circulation_rules.branchcode,
           Coalesce(circulation_rules.categorycode, 'all'), Coalesce(circulation_rules.itemtype, 'all')) =
           Concat(<<Your library|branches:all>>, '_all_all')
       THEN '1'
     END), 0) AS All_Rule
   FROM
     circulation_rules) rule_check
WHERE
  (branches_categories_itypes.branchcode LIKE  <<Your library|branches:all>> OR
    branches_categories_itypes.branchcode LIKE CASE
      WHEN rule_check.All_Rule = 0
      THEN 'all'
      ELSE 'x'
    END)
ORDER BY
  If(branches_categories_itypes.branchname = ' All libraries', 'Z', branches_categories_itypes.branchname),
  If(branches_categories_itypes.description = ' All categories', 'Z', branches_categories_itypes.description),
  If(branches_categories_itypes.description1 = ' All item types', 'Z', branches_categories_itypes.description1)

























