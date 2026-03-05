/*
R.003895

----------

Name: GHW - Framework for deduplicating circulation rules
Created by: George Williams

----------

Group: -
     -

Created on: 2025-07-11 13:52:24
Modified on: 2025-07-11 13:52:24
Date last run: 2025-07-11 22:47:56

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Group_Concat(DISTINCT dedupe.branch) AS Group_Concat_branch,
  dedupe.cat,
  dedupe.type,
  dedupe.categorycode,
  dedupe.matrixitemtype,
  dedupe.note,
  dedupe.maxissueqty,
  dedupe.maxonsiteissueqty,
  dedupe.issuelength,
  dedupe.daysmode,
  dedupe.lengthunit,
  dedupe.hardduedatecompare,
  dedupe.hardduedate,
  dedupe.decreaseloanholds,
  dedupe.fine,
  dedupe.chargeperiod,
  dedupe.chargeperiod_charge_at,
  dedupe.firstremind,
  dedupe.overduefinescap,
  dedupe.cap_fine_to_replacement_price,
  dedupe.fined,
  dedupe.maxsuspensiondays,
  dedupe.suspension_chargeperiod,
  dedupe.renewalsallowed,
  dedupe.renewalperiod,
  dedupe.norenewalbefore,
  dedupe.noautorenewalbefore,
  dedupe.auto_renew,
  dedupe.no_auto_renewal_after,
  dedupe.no_auto_renewal_after_hard_limit,
  dedupe.reservesallowed,
  dedupe.holds_per_day,
  dedupe.holds_per_record,
  dedupe.onshelfholds,
  dedupe.opacitemholds,
  dedupe.holds_pickup_period,
  dedupe.article_requests,
  dedupe.rentaldiscount
FROM
  (SELECT
      Coalesce(circulation_rules.branchcode, 'all') AS branch,
      Coalesce(circulation_rules.categorycode, 'all') AS cat,
      Coalesce(circulation_rules.itemtype, 'all') AS type,
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'categorycode'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'categorycode',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'itemtype'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'matrixitemtype',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'note'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'note',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'maxissueqty'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'maxissueqty',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'maxonsiteissueqty'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'maxonsiteissueqty',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'issuelength'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'issuelength',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'daysmode'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'daysmode',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'lengthunit'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'lengthunit',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'hardduedatecompare'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'hardduedatecompare',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'hardduedate'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'hardduedate',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'decreaseloanholds'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'decreaseloanholds',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'fine'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'fine',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'chargeperiod'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'chargeperiod',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'chargeperiod_charge_at'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'chargeperiod_charge_at',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'firstremind'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'firstremind',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'overduefinescap'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'overduefinescap',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'cap_fine_to_replacement_price'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'cap_fine_to_replacement_price',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'fined'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'fined',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'maxsuspensiondays'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'maxsuspensiondays',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'suspension_chargeperiod'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'suspension_chargeperiod',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'renewalsallowed'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'renewalsallowed',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'renewalperiod'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'renewalperiod',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'norenewalbefore'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'norenewalbefore',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'noautorenewalbefore'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'noautorenewalbefore',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'auto_renew'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'auto_renew',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'no_auto_renewal_after'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'no_auto_renewal_after',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'no_auto_renewal_after_hard_limit'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'no_auto_renewal_after_hard_limit',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'reservesallowed'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'reservesallowed',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'holds_per_day'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'holds_per_day',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'holds_per_record'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'holds_per_record',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'onshelfholds'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'onshelfholds',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'opacitemholds'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'opacitemholds',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'holds_pickup_period'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'holds_pickup_period',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'article_requests'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'article_requests',
      Max(CASE
        WHEN
          circulation_rules.rule_name = 'rentaldiscount'
        THEN circulation_rules.rule_value
        ELSE NULL
      END) AS 'rentaldiscount'
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name NOT IN ('unseen_renewals_allowed',
      'restrictedtype', 'patron_maxissueqty', 'patron_maxonsiteissueqty',
      'max_holds', 'lostreturn', 'hold_fulfillment_policy', 'holdallowed',
      'returnbranch', 'hardduedatecompare', 'accountsent')
    GROUP BY
      Coalesce(circulation_rules.branchcode, 'all'),
      Coalesce(circulation_rules.categorycode, 'all'),
      Coalesce(circulation_rules.itemtype, 'all')) dedupe
WHERE
  dedupe.cat = 'all' AND
  dedupe.type = 'all' AND
  dedupe.issuelength = 21
GROUP BY
  dedupe.cat,
  dedupe.type,
  dedupe.categorycode,
  dedupe.matrixitemtype,
  dedupe.note,
  dedupe.maxissueqty,
  dedupe.maxonsiteissueqty,
  dedupe.issuelength,
  dedupe.daysmode,
  dedupe.lengthunit,
  dedupe.hardduedatecompare,
  dedupe.hardduedate,
  dedupe.decreaseloanholds,
  dedupe.fine,
  dedupe.chargeperiod,
  dedupe.chargeperiod_charge_at,
  dedupe.firstremind,
  dedupe.overduefinescap,
  dedupe.cap_fine_to_replacement_price,
  dedupe.fined,
  dedupe.maxsuspensiondays,
  dedupe.suspension_chargeperiod,
  dedupe.renewalsallowed,
  dedupe.renewalperiod,
  dedupe.norenewalbefore,
  dedupe.noautorenewalbefore,
  dedupe.auto_renew,
  dedupe.no_auto_renewal_after,
  dedupe.no_auto_renewal_after_hard_limit,
  dedupe.reservesallowed,
  dedupe.holds_per_day,
  dedupe.holds_per_record,
  dedupe.onshelfholds,
  dedupe.opacitemholds,
  dedupe.holds_pickup_period,
  dedupe.article_requests,
  dedupe.rentaldiscount
ORDER BY
  If(Group_Concat(DISTINCT dedupe.branch) = 'all', 'ZZZZZ',
  Group_Concat(DISTINCT dedupe.branch)),
  If(dedupe.cat = 'all', 'ZZZZZ', dedupe.cat),
  If(dedupe.type = 'all', 'ZZZZZ', dedupe.type)

























