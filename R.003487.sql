/*
R.003487

----------

Name: GHW - Circulation/fees/request rules 2 - late fees and suspensions
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-03-30 09:23:49
Modified on: 2021-03-30 11:18:15
Date last run: 2021-05-05 12:08:02

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Verbose listing of circulation/fees/request rules regarding late fees and "suspensions"</p>
<ul><li>Shows the current rules</li>
<li>at the library you specify</li>
<li>grouped and sorted by rule branchcode, borrower category, and item type</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Rules are applied from most specific to least specific and the rules in this report are set to display from most specific to least specific.  The higher a rule is in the results of this report, the higher its priority.</p>
<p></p>
<p>In Next Search Catalog, late fee rules follow the rules at the library where an item is checked out.  If an item is shipped from ATCHISON to SILVERLAKE to fill a request and it is kept overdue, the borrower will be billed following the rules at SILVERLAKE.<br />(Based on the CircControl system preference - 2021.03.12)</p></p>
<p></p>
<p>"Suspensions" in the case of this report relate to a type of late "fee" we are not currently using.  Some libraries in Europe use "Suspensions" or "Debarrments" in place of library late fees.  If a borrower keeps a book overdue for 5 days, their account is "suspended" or "debarred" from borrowing materials for 5 days.  If they keep something overdue 18 days, their account is suspended for 18 days, etc. etc.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3486&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">rules, circulation</p>
</div>

----------
*/

SELECT
  branchess.branchcode,
  categorytypes.BORROWER_CATEGORY,
  categorytypes.ITEM_TYPE,
  Format(fine.rule_value, 2) AS LATE_FEE,
  chargeperiod.rule_value AS FEE_PERIOD,
  lengthunit.rule_value AS FEE_INTERVAL,
  chargeperiod_charge_at.rule_value AS CHARGED_AT,
  firstremind.rule_value AS GRACE_PERIOD,
  lengthunit.rule_value AS GRACE_INTERVAL,
  Concat(
    If(overduefinescap.rule_value = 0, "", 
      Format(overduefinescap.rule_value, 2)), 
      cap_fine_to_replacement_price.rule_value
    ) AS LATE_FEE_CAP,
  finedays.rule_value AS SUSPENSION_DAYS,
  maxsuspensiondays.rule_value AS MAX_SUSPENSION,
  If(finedays.rule_value = "", "", suspension_chargeperiod.rule_value) AS SUSPENSION_INTERVAL
FROM
  (SELECT
     branches.branchcode,
     branches.branchname
   FROM
     branches
   UNION
   SELECT
     Concat('ALL') AS branchcode,
     Concat('All libraries') AS branchname) branchess INNER JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL",  circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL",  circulation_rules.categorycode) AS categorycode,
     If(categories.description IS NULL, "All borrowers", categories.description) AS BORROWER_CATEGORY,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     If(itemtypes.description IS NULL, "All item types", itemtypes.description) AS ITEM_TYPE
   FROM
     circulation_rules LEFT JOIN
     categories ON circulation_rules.categorycode = categories.categorycode
     LEFT JOIN
     itemtypes ON circulation_rules.itemtype = itemtypes.itemtype
   WHERE
     circulation_rules.rule_name <> '''accountsent"' AND
     circulation_rules.rule_name <> "hold_fulfillment_policy" AND
     circulation_rules.rule_name <> "holdallowed" AND
     circulation_rules.rule_name <> "max_holds" AND
     circulation_rules.rule_name <> "patron_maxissueqty" AND
     circulation_rules.rule_name <> "patron_maxonsiteissueqty" AND
     circulation_rules.rule_name <> "refund" AND
     circulation_rules.rule_name <> "restrictedtype" AND
     circulation_rules.rule_name <> "returnbranch"
   GROUP BY
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode),
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode),
     If(categories.description IS NULL, "All borrowers", categories.description),
     circulation_rules.itemtype,
     itemtypes.description) categorytypes ON categorytypes.branchcode =
      branchess.branchcode LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'fine') fine ON fine.branchcode =
      categorytypes.branchcode AND
      fine.categorycode = categorytypes.categorycode AND
      fine.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'lengthunit') lengthunit ON
      lengthunit.branchcode = categorytypes.branchcode AND
      lengthunit.categorycode = categorytypes.categorycode AND
      lengthunit.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'chargeperiod') chargeperiod ON
      chargeperiod.branchcode = categorytypes.branchcode AND
      chargeperiod.categorycode = categorytypes.categorycode AND
      chargeperiod.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     If(circulation_rules.rule_value = 0, "End of interval", 
       If(circulation_rules.rule_value = 1, "Start of interval", 
         circulation_rules.rule_value
       )
     ) AS rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'chargeperiod_charge_at')
  chargeperiod_charge_at ON chargeperiod_charge_at.branchcode =
      categorytypes.branchcode AND
      chargeperiod_charge_at.categorycode = categorytypes.categorycode AND
      chargeperiod_charge_at.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'firstremind') firstremind ON
      firstremind.branchcode = categorytypes.branchcode AND
      firstremind.categorycode = categorytypes.categorycode AND
      firstremind.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'overduefinescap') overduefinescap ON
      overduefinescap.branchcode = categorytypes.branchcode AND
      overduefinescap.categorycode = categorytypes.categorycode AND
      overduefinescap.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     If(circulation_rules.rule_value = 0, "", 
       If(circulation_rules.rule_value = 1, "Item replacement cost", 
         circulation_rules.rule_value
       )
     ) AS rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'cap_fine_to_replacement_price')
  cap_fine_to_replacement_price ON cap_fine_to_replacement_price.branchcode =
      categorytypes.branchcode AND
      cap_fine_to_replacement_price.categorycode = categorytypes.categorycode
      AND
      cap_fine_to_replacement_price.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'finedays') finedays ON finedays.branchcode =
      categorytypes.branchcode AND
      finedays.categorycode = categorytypes.categorycode AND
      finedays.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'maxsuspensiondays') maxsuspensiondays ON
      maxsuspensiondays.branchcode = categorytypes.branchcode AND
      maxsuspensiondays.categorycode = categorytypes.categorycode AND
      maxsuspensiondays.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
     If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
     If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
     If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
     circulation_rules.rule_name,
     circulation_rules.rule_value
   FROM
     circulation_rules
   WHERE
     circulation_rules.rule_name = 'suspension_chargeperiod')
  suspension_chargeperiod ON suspension_chargeperiod.branchcode =
      categorytypes.branchcode AND
      suspension_chargeperiod.categorycode = categorytypes.categorycode AND
      suspension_chargeperiod.itemtype = categorytypes.itemtype
WHERE
  (categorytypes.branchcode LIKE <<Choose your library|branches:all>> OR
    categorytypes.branchcode LIKE "ALL")
GROUP BY
  branchess.branchcode,
  categorytypes.BORROWER_CATEGORY,
  categorytypes.ITEM_TYPE
ORDER BY
  IF(branchess.branchcode = "ALL", "ZZZZZ", branchess.branchcode),
  IF(categorytypes.BORROWER_CATEGORY = "All borrowers", "ZZZZZ", categorytypes.BORROWER_CATEGORY),
  IF(categorytypes.ITEM_TYPE = "All item types", "ZZZZZ", categorytypes.ITEM_TYPE)




