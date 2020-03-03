/*
R.002925

----------

Name: GHW - Basic circulation/fines/fees rules
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-03-21 16:09:30
Modified on: 2020-02-25 11:17:38
Date last run: 2020-02-25 11:59:26

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows the current basic circulation rules at your library</p>
<ul><li>Shows the current circulation rules</li>
<li>at the library you specify</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Circulation rules are applied from most specific to most general.  Therefore, if you have a rule that specifies a patron category and an item type, that rule will be applied before a rule that specifies an item type but not a patron category or one that specifies a patron category but not an item type.  All patron categories/All item type rules only apply if no category or item type rule is specified.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2925&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  If(issuingrules.branchcode = '*', 'All libraries not specified above', issuingrules.branchcode) AS LIBRARY,
  If(issuingrules.categorycode = "*", "All patrons not specified above", categories.description) AS PATRON_CATEGORY,
  If(Coalesce(itemtypes.description, 0) = "0", "All ITYPES not specified above for this patron category", itemtypes.description) AS ITEM_TYPE,
  If(maxissueqtys.rule_value = '', 'Unlimited', maxissueqtys.rule_value) AS CKO_ALLOWED,
  issuingrules.issuelength AS LOAN_PERIOD,
  Format(issuingrules.fine, 2) AS FINE_AMOUNT,
  issuingrules.chargeperiod AS FINE_CHARGING_INTERVAL,
  issuingrules.firstremind AS FINE_GRACE_PERIOD,
  If(issuingrules.overduefinescap IS NULL, "Replacement price of item", Format(issuingrules.overduefinescap, 2)) AS OVERDUE_FINES_CAP,
  issuingrules.renewalsallowed AS RENEWALS_ALLOWED,
  issuingrules.renewalperiod AS RENEWAL_PERIOD,
  issuingrules.reservesallowed AS HOLDS_ALLOWED_COUNT,
  issuingrules.onshelfholds AS ON_SHELF_HOLDS_ALLOWED,
  issuingrules.note AS NOTES
FROM
  issuingrules LEFT JOIN
  itemtypes ON issuingrules.itemtype = itemtypes.itemtype LEFT JOIN
  categories ON categories.categorycode = issuingrules.categorycode,
  (SELECT
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, 'All') AS branchcode,
      Coalesce(circulation_rules.categorycode, 'All') AS categorycode,
      Coalesce(circulation_rules.itemtype, 'All') AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'maxissueqty'
    GROUP BY
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, 'All'),
      Coalesce(circulation_rules.categorycode, 'All'),
      Coalesce(circulation_rules.itemtype, 'All'),
      circulation_rules.rule_name,
      circulation_rules.rule_value) maxissueqtys
WHERE
  If(issuingrules.categorycode = '*', 'All', issuingrules.categorycode) = maxissueqtys.categorycode AND
  If(issuingrules.itemtype = '*', 'All', issuingrules.itemtype) = maxissueqtys.itemtype AND
  If(issuingrules.branchcode = '*', 'All', issuingrules.branchcode) = maxissueqtys.branchcode AND
  If(issuingrules.branchcode = '*', 'All libraries not specified above', issuingrules.branchcode) LIKE <<Choose your library|LBRANCH>>
ORDER BY
  If(issuingrules.branchcode = '*', 'Z', issuingrules.branchcode),
  If(issuingrules.categorycode = "*", "Z", categories.description),
  If(issuingrules.itemtype = '*', 'Z', issuingrules.itemtype)



