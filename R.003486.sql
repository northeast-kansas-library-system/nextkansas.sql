/*
R.003486

----------

Name: GHW - Circulation/fees/request rules 1 - circulation and renewal
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-03-30 09:13:51
Modified on: 2021-03-30 11:18:05
Date last run: 2021-10-19 14:43:08

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Verbose listing of circulation/fees/request rules regarding circulation and renewal rules</p>
<ul><li>Shows the current rules</li>
<li>at the library you specify</li>
<li>grouped and sorted by rule branchcode, borrower category, and item type</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Rules are applied from most specific to least specific and the rules in this report are set to display from most specific to least specific.  The higher a rule is in the results of this report, the higher its priority.</p>
<p></p>
<p>Rules regarding circulation are applied based on the library where the items are being checked out.  If an item is shipped from SENECA to OTTAWA to fill a request, it will follow the check-out and renewal rules at OTTAWA when it is checked out at OTTAWA.<br />(Based on the CircControl system preference - 2021.03.10)</p></p></p>
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
  notes.rule_value AS NOTE,
  If(maxissueqty.rule_value = "", "Unlimited", maxissueqty.rule_value) AS CKOS_ALLOWED,
  If(maxonsiteissueqty.rule_value = "", "Unlimited", maxissueqty.rule_value) AS ONSITE_ALLOWED,
  issuelength.rule_value AS LOAN_PERIOD,
  lengthunit.rule_value AS LOAN_UNIT,
  If(hardduedate.rule_value = "", "", 
    If(hardduedatecompare.rule_value = "-1", "Before", 
      If(hardduedatecompare.rule_value = "0", "Exactly on", 
        If(hardduedatecompare.rule_value = "1", "After", 
          hardduedatecompare.rule_value
        )
      )
    )
  ) AS HDD_ITEMS_DUE_,
  hardduedate.rule_value AS HARD_DATE,
  renewalsallowed.rule_value AS RENEWAL_ALLOWED,
  renewalperiod.rule_value AS RENEWAL_PERIOD,
  norenewalbefore.rule_value AS NO_RENEWAL_BEFORE,
  If(auto_renew.rule_value = 0, "Disabled", 
    If(auto_renew.rule_value = 1, "Enabled", auto_renew.rule_value
    )
  ) AS AUTO_RENEW_ENABLED,
  no_auto_renewal_after.rule_value AS NO_AUTO_RENEW_AFTER,
  no_auto_renewal_after_hard_limit.rule_value AS AUTO_RENEW_HDD
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
      If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
      If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
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
      circulation_rules.rule_name = 'note') notes ON notes.branchcode =
      categorytypes.branchcode AND
      notes.categorycode = categorytypes.categorycode AND
      notes.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
      If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
      If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
      If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'maxissueqty') maxissueqty ON
      maxissueqty.branchcode = categorytypes.branchcode AND
      maxissueqty.categorycode = categorytypes.categorycode AND
      maxissueqty.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
      If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
      If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
      If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'maxonsiteissueqty') maxonsiteissueqty ON
      maxonsiteissueqty.branchcode = categorytypes.branchcode AND
      maxonsiteissueqty.categorycode = categorytypes.categorycode AND
      maxonsiteissueqty.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
      If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
      If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
      If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'issuelength') issuelength ON
      issuelength.branchcode = categorytypes.branchcode AND
      issuelength.categorycode = categorytypes.categorycode AND
      issuelength.itemtype = categorytypes.itemtype LEFT JOIN
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
      circulation_rules.rule_name = 'hardduedatecompare') hardduedatecompare ON
      hardduedatecompare.branchcode = categorytypes.branchcode AND
      hardduedatecompare.categorycode = categorytypes.categorycode AND
      hardduedatecompare.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
      If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
      If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
      If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'hardduedate') hardduedate ON
      hardduedate.branchcode = categorytypes.branchcode AND
      hardduedate.categorycode = categorytypes.categorycode AND
      hardduedate.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
      If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
      If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
      If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'renewalsallowed') renewalsallowed
    ON renewalsallowed.branchcode = categorytypes.branchcode AND
      renewalsallowed.categorycode = categorytypes.categorycode AND
      renewalsallowed.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
      If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
      If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
      If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'renewalperiod') renewalperiod ON
      renewalperiod.branchcode = categorytypes.branchcode AND
      renewalperiod.categorycode = categorytypes.categorycode AND
      renewalperiod.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
      If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
      If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
      If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'norenewalbefore') norenewalbefore
    ON norenewalbefore.branchcode = categorytypes.branchcode AND
      norenewalbefore.categorycode = categorytypes.categorycode AND
      norenewalbefore.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
      If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
      If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
      If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'auto_renew') auto_renew ON
      auto_renew.branchcode = categorytypes.branchcode AND
      auto_renew.categorycode = categorytypes.categorycode AND
      auto_renew.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
      If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
      If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
      If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'no_auto_renewal_after')
  no_auto_renewal_after ON no_auto_renewal_after.branchcode =
      categorytypes.branchcode AND
      no_auto_renewal_after.categorycode = categorytypes.categorycode AND
      no_auto_renewal_after.itemtype = categorytypes.itemtype LEFT JOIN
  (SELECT
      If(circulation_rules.branchcode IS NULL, "ALL", circulation_rules.branchcode) AS branchcode,
      If(circulation_rules.categorycode IS NULL, "ALL", circulation_rules.categorycode) AS categorycode,
      If(circulation_rules.itemtype IS NULL, "ALL", circulation_rules.itemtype) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'no_auto_renewal_after_hard_limit')
  no_auto_renewal_after_hard_limit ON
      no_auto_renewal_after_hard_limit.branchcode = categorytypes.branchcode AND
      no_auto_renewal_after_hard_limit.categorycode = categorytypes.categorycode
      AND
      no_auto_renewal_after_hard_limit.itemtype = categorytypes.itemtype
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


























