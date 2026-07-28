/*
R.003884

----------

Name: GHW - Rules 002 - Default checkout, hold and return policy
Created by: George Williams

----------

Group: Rules
     -

Created on: 2025-04-30 18:32:45
Modified on: 2026-03-27 15:01:45
Date last run: 2026-07-23 16:50:19

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branchess.branchname,
  'Default rule' AS `DEFAULT`,
  patron_maxissueqty.rule_value AS `Total current checkouts allowed`,
  patron_maxonsiteissueqty.rule_value AS `Total current on-site checkouts allowed`,
  max_holds.rule_value AS `Maximum total holds allowed (count)`,
  holdallowed.rule_value AS `Hold policy`,
  hold_fulfillment_policy.rule_value AS `Hold pickup library match"`,
  bookings_lead_period.rule_value AS `Booking pre-processing (days)`,
  bookings_trail_period.rule_value AS `Booking post-processing (days)`,
  returnbranch.rule_value AS `Return policy`
FROM
  (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
    UNION
    SELECT
      Concat ('ALL') AS branchcode,
      Concat ('All libraries') AS branchname
  ) branchess
  JOIN (
    SELECT
      If (
        circulation_rules.branchcode IS NULL,
        "ALL",
        circulation_rules.branchcode
      ) AS branchcode,
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) AS categorycode,
      If (
        categories.description IS NULL,
        "All borrowers",
        categories.description
      ) AS BORROWER_CATEGORY,
      If (
        circulation_rules.itemtype IS NULL,
        "ALL",
        circulation_rules.itemtype
      ) AS itemtype,
      If (
        itemtypes.description IS NULL,
        "All item types",
        itemtypes.description
      ) AS ITEM_TYPE
    FROM
      circulation_rules
      LEFT JOIN categories ON circulation_rules.categorycode = categories.categorycode
      LEFT JOIN itemtypes ON circulation_rules.itemtype = itemtypes.itemtype
    WHERE
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) = 'All' AND
      If (
        circulation_rules.itemtype IS NULL,
        "ALL",
        circulation_rules.itemtype
      ) = 'All'
    GROUP BY
      If (
        circulation_rules.branchcode IS NULL,
        "ALL",
        circulation_rules.branchcode
      ),
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ),
      If (
        categories.description IS NULL,
        "All borrowers",
        categories.description
      ),
      circulation_rules.itemtype,
      itemtypes.description
  ) categorytypes ON categorytypes.branchcode = branchess.branchcode
  LEFT JOIN (
    SELECT
      If (
        circulation_rules.branchcode IS NULL,
        "ALL",
        circulation_rules.branchcode
      ) AS branchcode,
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) AS categorycode,
      If (
        circulation_rules.itemtype IS NULL,
        "ALL",
        circulation_rules.itemtype
      ) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'patron_maxissueqty' AND
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) = 'ALL'
  ) patron_maxissueqty ON patron_maxissueqty.branchcode = categorytypes.branchcode AND
  patron_maxissueqty.categorycode = categorytypes.categorycode AND
  patron_maxissueqty.itemtype = categorytypes.itemtype
  LEFT JOIN (
    SELECT
      If (
        circulation_rules.branchcode IS NULL,
        "ALL",
        circulation_rules.branchcode
      ) AS branchcode,
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) AS categorycode,
      If (
        circulation_rules.itemtype IS NULL,
        "ALL",
        circulation_rules.itemtype
      ) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'patron_maxonsiteissueqty' AND
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) = 'ALL'
  ) patron_maxonsiteissueqty ON patron_maxonsiteissueqty.branchcode = categorytypes.branchcode AND
  patron_maxonsiteissueqty.categorycode = categorytypes.categorycode AND
  patron_maxonsiteissueqty.itemtype = categorytypes.itemtype
  LEFT JOIN (
    SELECT
      If (
        circulation_rules.branchcode IS NULL,
        "ALL",
        circulation_rules.branchcode
      ) AS branchcode,
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) AS categorycode,
      If (
        circulation_rules.itemtype IS NULL,
        "ALL",
        circulation_rules.itemtype
      ) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'max_holds' AND
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) = 'ALL'
  ) max_holds ON max_holds.branchcode = categorytypes.branchcode AND
  max_holds.categorycode = categorytypes.categorycode AND
  max_holds.itemtype = categorytypes.itemtype
  LEFT JOIN (
    SELECT
      If (
        circulation_rules.branchcode IS NULL,
        "ALL",
        circulation_rules.branchcode
      ) AS branchcode,
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) AS categorycode,
      If (
        circulation_rules.itemtype IS NULL,
        "ALL",
        circulation_rules.itemtype
      ) AS itemtype,
      circulation_rules.rule_name,
      CASE
        WHEN circulation_rules.rule_value = '' THEN 'Not set'
        WHEN circulation_rules.rule_value = 'from_any_library' THEN 'From any library'
        WHEN circulation_rules.rule_value = 'from_local_hold_group' THEN 'From local hold group'
        WHEN circulation_rules.rule_value = 'from_home_library' THEN 'From home library'
        WHEN circulation_rules.rule_value = 'not_allowed' THEN 'No holds allowed'
        ELSE 'Not set'
      END AS rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'holdallowed' AND
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) = 'ALL'
  ) holdallowed ON holdallowed.branchcode = categorytypes.branchcode AND
  holdallowed.categorycode = categorytypes.categorycode AND
  holdallowed.itemtype = categorytypes.itemtype
  LEFT JOIN (
    SELECT
      If (
        circulation_rules.branchcode IS NULL,
        "ALL",
        circulation_rules.branchcode
      ) AS branchcode,
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) AS categorycode,
      If (
        circulation_rules.itemtype IS NULL,
        "ALL",
        circulation_rules.itemtype
      ) AS itemtype,
      circulation_rules.rule_name,
      CASE
        WHEN circulation_rules.rule_value = '' THEN 'Not set'
        WHEN circulation_rules.rule_value = 'any' THEN 'any library'
        WHEN circulation_rules.rule_value = 'holdgroup' THEN 'item\'s hold group'
        WHEN circulation_rules.rule_value = 'patrongroup' THEN 'patron\'s hold group'
        WHEN circulation_rules.rule_value = 'homebranch' THEN 'item\'s home library'
        WHEN circulation_rules.rule_value = 'holdingbranch' THEN 'item\'s holding library'
        ELSE 'Not set'
      END AS rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'hold_fulfillment_policy' AND
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) = 'ALL'
  ) hold_fulfillment_policy ON hold_fulfillment_policy.branchcode = categorytypes.branchcode AND
  hold_fulfillment_policy.categorycode = categorytypes.categorycode AND
  hold_fulfillment_policy.itemtype = categorytypes.itemtype
  LEFT JOIN (
    SELECT
      If (
        circulation_rules.branchcode IS NULL,
        "ALL",
        circulation_rules.branchcode
      ) AS branchcode,
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) AS categorycode,
      If (
        circulation_rules.itemtype IS NULL,
        "ALL",
        circulation_rules.itemtype
      ) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'bookings_lead_period' AND
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) = 'ALL'
  ) bookings_lead_period ON bookings_lead_period.branchcode = categorytypes.branchcode AND
  bookings_lead_period.categorycode = categorytypes.categorycode AND
  bookings_lead_period.itemtype = categorytypes.itemtype
  LEFT JOIN (
    SELECT
      If (
        circulation_rules.branchcode IS NULL,
        "ALL",
        circulation_rules.branchcode
      ) AS branchcode,
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) AS categorycode,
      If (
        circulation_rules.itemtype IS NULL,
        "ALL",
        circulation_rules.itemtype
      ) AS itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'bookings_trail_period' AND
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) = 'ALL'
  ) bookings_trail_period ON bookings_trail_period.branchcode = categorytypes.branchcode AND
  bookings_trail_period.categorycode = categorytypes.categorycode AND
  bookings_trail_period.itemtype = categorytypes.itemtype
  LEFT JOIN (
    SELECT
      If (
        circulation_rules.branchcode IS NULL,
        "ALL",
        circulation_rules.branchcode
      ) AS branchcode,
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) AS categorycode,
      If (
        circulation_rules.itemtype IS NULL,
        "ALL",
        circulation_rules.itemtype
      ) AS itemtype,
      circulation_rules.rule_name,
      CASE
        WHEN circulation_rules.rule_value = '' THEN 'Not set'
        WHEN circulation_rules.rule_value = 'homebranch' THEN 'Item returns home'
        WHEN circulation_rules.rule_value = 'holdingbranch' THEN 'Item returns to issuing library'
        WHEN circulation_rules.rule_value = 'noreturn' THEN 'Item floats'
        WHEN circulation_rules.rule_value = 'returnbylibrarygroup' THEN 'Item floats by library group'
        ELSE 'Not set'
      END AS rule_value
    FROM
      circulation_rules
    WHERE
      circulation_rules.rule_name = 'returnbranch' AND
      If (
        circulation_rules.categorycode IS NULL,
        "ALL",
        circulation_rules.categorycode
      ) = 'ALL'
  ) returnbranch ON returnbranch.branchcode = categorytypes.branchcode AND
  returnbranch.categorycode = categorytypes.categorycode AND
  returnbranch.itemtype = categorytypes.itemtype
WHERE
  (
    categorytypes.branchcode LIKE <<Library|LBRANCH>> Or
    categorytypes.branchcode Like "ALL"
  )
GROUP BY
  bookings_trail_period.rule_value,
  branchess.branchcode
ORDER BY
  If (
    branchess.branchcode = "ALL",
    "ZZZZZ",
    branchess.branchcode
  ),
  If (
    categorytypes.BORROWER_CATEGORY = "All borrowers",
    "ZZZZZ",
    categorytypes.BORROWER_CATEGORY
  ),
  If (
    categorytypes.ITEM_TYPE = "All item types",
    "ZZZZZ",
    categorytypes.ITEM_TYPE
  )

























