/*
R.003340

----------

Name: GHW - Circulation rules
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-07-20 10:35:24
Modified on: 2020-07-20 10:35:24
Date last run: 2021-02-05 09:33:23

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  If(branches.branchname IS NULL, " All libraries", branches.branchname) AS
  branchname,
  Coalesce(categories.description, " All categories") AS PATRON_CATEGORY,
  Coalesce(itemtypes.description, " All item types") AS ITYPES,
  issueingruless.note,
  maxissueqty.rule_value AS CKO_allowed,
  maxonsiteissueqty.rule_value AS CKO_ONSITE_ALLOWED,
  issueingruless.issuelength,
  issueingruless.lengthunit,
  issueingruless.hardduedate,
  issueingruless.hardduedatecompare,
  issueingruless.fine,
  issueingruless.chargeperiod,
  issueingruless.chargeperiod_charge_at,
  issueingruless.firstremind AS GRACE_PERIOD,
  issueingruless.overduefinescap,
  issueingruless.cap_fine_to_replacement_price,
  issueingruless.finedays AS SUSPENSION,
  issueingruless.maxsuspensiondays,
  issueingruless.suspension_chargeperiod,
  issueingruless.renewalsallowed,
  issueingruless.renewalperiod,
  issueingruless.norenewalbefore,
  issueingruless.auto_renew,
  issueingruless.no_auto_renewal_after,
  issueingruless.no_auto_renewal_after_hard_limit,
  issueingruless.reservesallowed,
  issueingruless.holds_per_day,
  issueingruless.holds_per_record,
  issueingruless.onshelfholds,
  issueingruless.opacitemholds,
  issueingruless.article_requests,
  issueingruless.rentaldiscount,
  branches.branchcode
FROM
  branches RIGHT JOIN
  (SELECT
      If(issuingrules.branchcode = "*", " all_branchcodes",
      issuingrules.branchcode) AS branchcode,
      If(issuingrules.categorycode = "*", " all_categories",
      issuingrules.categorycode) AS categorycode,
      If(issuingrules.itemtype = "*", " all_itemtypes", issuingrules.itemtype)
      AS itemtype,
      issuingrules.note,
      issuingrules.issuelength,
      issuingrules.lengthunit,
      issuingrules.hardduedatecompare,
      issuingrules.hardduedate,
      issuingrules.fine,
      issuingrules.chargeperiod,
      If(issuingrules.chargeperiod_charge_at = 1, "Start of interval",
      "End of interval") AS chargeperiod_charge_at,
      issuingrules.firstremind,
      issuingrules.overduefinescap,
      If(issuingrules.cap_fine_to_replacement_price = 0, "",
      "Max fine =  item cost") AS cap_fine_to_replacement_price,
      issuingrules.finedays,
      issuingrules.maxsuspensiondays,
      issuingrules.suspension_chargeperiod,
      issuingrules.renewalsallowed,
      issuingrules.renewalperiod,
      issuingrules.norenewalbefore,
      If(issuingrules.auto_renew = 0, "", "allowed") AS auto_renew,
      issuingrules.no_auto_renewal_after,
      issuingrules.no_auto_renewal_after_hard_limit,
      issuingrules.reservesallowed,
      issuingrules.holds_per_day,
      issuingrules.holds_per_record,
      If(issuingrules.onshelfholds = 1, "allowed", "not_allowed") AS
      onshelfholds,
      issuingrules.opacitemholds,
      issuingrules.article_requests,
      issuingrules.rentaldiscount
    FROM
      issuingrules) issueingruless ON issueingruless.branchcode =
      branches.branchcode LEFT JOIN
  (SELECT
      circulation_rules.rule_name,
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, " all_branchcodes") AS branchcode,
      Coalesce(circulation_rules.categorycode, " all_categories") AS
      categorycode,
      Coalesce(circulation_rules.itemtype, " all_itemtypes") AS itemtype,
      circulation_rules.branchcode AS branchcode1,
      circulation_rules.categorycode AS categorycode1,
      circulation_rules.itemtype AS itemtype1,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'maxissueqty') maxissueqty ON
      maxissueqty.branchcode = issueingruless.branchcode AND
      maxissueqty.categorycode = issueingruless.categorycode AND
      maxissueqty.itemtype = issueingruless.itemtype LEFT JOIN
  (SELECT
      circulation_rules.rule_name,
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, " all_branchcodes") AS branchcode,
      Coalesce(circulation_rules.categorycode, " all_categories") AS
      categorycode,
      Coalesce(circulation_rules.itemtype, " all_itemtypes") AS itemtype,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'maxonsiteissueqty') maxonsiteissueqty ON
      maxonsiteissueqty.branchcode = issueingruless.branchcode AND
      maxonsiteissueqty.categorycode = issueingruless.categorycode AND
      maxonsiteissueqty.itemtype = issueingruless.itemtype LEFT JOIN
  itemtypes ON itemtypes.itemtype = issueingruless.itemtype LEFT JOIN
  categories ON categories.categorycode = issueingruless.categorycode
WHERE
  branches.branchcode LIKE <<Choose your library|ZBRAN>>
ORDER BY
  branchname,
  PATRON_CATEGORY,
  ITYPES,
  issueingruless.note



