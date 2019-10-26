/*
R.002925

----------

Name: GHW - Basic circulation/fines/fees rules
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-03-21 16:09:30
Modified on: 2019-01-23 16:53:03
Date last run: 2019-10-15 09:31:04

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
  issuingrules.branchcode,
  If(issuingrules.categorycode = "*", "All patrons not specified below", categories.description) AS PATRON_CATEGORY,
  If(Coalesce(itemtypes.description, 0) = "0", "All ITYPES not specified below for this patron category", itemtypes.description) AS ITEM_TYPE,
  If(issuingrules.maxissueqty IS NULL, "Unlimited", issuingrules.maxissueqty) AS CURRENT_CHECKOUTS_ALLOWED,
  issuingrules.issuelength AS LOAN_PERIOD,
  Format(issuingrules.fine, 2) AS FINE_AMOUNT,
  issuingrules.chargeperiod AS FINE_CHARGING_INTERVAL,
  issuingrules.firstremind AS FINE_GRACE_PERIOD,
  IF(issuingrules.overduefinescap is null, "Replacement price of item", Format(issuingrules.overduefinescap, 2)) AS OVERDUE_FINES_CAP,
  issuingrules.renewalsallowed AS RENEWALS_ALLOWED,
  issuingrules.renewalperiod AS RENEWAL_PERIOD,
  issuingrules.reservesallowed AS HOLDS_ALLOWED_COUNT,
  issuingrules.onshelfholds AS ON_SHELF_HOLDS_ALLOWED,
  issuingrules.opacitemholds AS ITEM_LEVEL_HOLDS
FROM
  issuingrules
  LEFT JOIN itemtypes ON issuingrules.itemtype = itemtypes.itemtype
  LEFT JOIN categories ON categories.categorycode = issuingrules.categorycode
WHERE
  issuingrules.branchcode LIKE <<Choose your library|LBRANCH>>



