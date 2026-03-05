/*
R.003884

----------

Name: Default checkout, hold and return policy
Created by: George Williams

----------

Group: -
     -

Created on: 2025-04-30 18:32:45
Modified on: 2025-04-30 18:32:49
Date last run: 2025-07-09 11:09:23

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  branchess.branchname,
  'Default rule' As `DEFAULT`,
  patron_maxissueqty.rule_value As `Total current checkouts allowed`,
  patron_maxonsiteissueqty.rule_value As `Total current on-site checkouts allowed`,
  max_holds.rule_value As `Maximum total holds allowed (count)`,
  holdallowed.rule_value As `Hold policy`,
  hold_fulfillment_policy.rule_value As `Hold pickup library match"`,
  bookings_lead_period.rule_name As `Booking pre-processing (days)`,
  bookings_trail_period.rule_name As `Booking post-processing (days)`,
  returnbranch.rule_value As `Return policy`
From
  (Select
      branches.branchcode,
      branches.branchname
    From
      branches
    UNION
    Select
      Concat('ALL') As branchcode,
      Concat('All libraries') As branchname) branchess Join
  (Select
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode) As branchcode,
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) As categorycode,
      If(categories.description Is Null, "All borrowers", categories.description) As BORROWER_CATEGORY,
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype) As itemtype,
      If(itemtypes.description Is Null, "All item types", itemtypes.description) As ITEM_TYPE
    From
      circulation_rules Left Join
      categories On circulation_rules.categorycode = categories.categorycode Left Join
      itemtypes On circulation_rules.itemtype = itemtypes.itemtype
    Where
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) = 'All' And
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype) = 'All'
    Group By
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode),
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode),
      If(categories.description Is Null, "All borrowers", categories.description),
      circulation_rules.itemtype,
      itemtypes.description) categorytypes On categorytypes.branchcode = branchess.branchcode Left Join
  (Select
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode) As branchcode,
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) As categorycode,
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype) As itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    From
      circulation_rules
    Where
      circulation_rules.rule_name = 'patron_maxissueqty' And
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) = 'ALL') patron_maxissueqty On
      patron_maxissueqty.branchcode = categorytypes.branchcode And
      patron_maxissueqty.categorycode = categorytypes.categorycode And
      patron_maxissueqty.itemtype = categorytypes.itemtype Left Join
  (Select
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode) As branchcode,
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) As categorycode,
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype) As itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    From
      circulation_rules
    Where
      circulation_rules.rule_name = 'patron_maxonsiteissueqty' And
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) =
      'ALL') patron_maxonsiteissueqty On patron_maxonsiteissueqty.branchcode = categorytypes.branchcode And
      patron_maxonsiteissueqty.categorycode = categorytypes.categorycode And
      patron_maxonsiteissueqty.itemtype = categorytypes.itemtype Left Join
  (Select
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode) As branchcode,
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) As categorycode,
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype) As itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    From
      circulation_rules
    Where
      circulation_rules.rule_name = 'max_holds' And
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) = 'ALL') max_holds On
      max_holds.branchcode = categorytypes.branchcode And
      max_holds.categorycode = categorytypes.categorycode And
      max_holds.itemtype = categorytypes.itemtype Left Join
  (Select
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode) As branchcode,
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) As categorycode,
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype) As itemtype,
      circulation_rules.rule_name,
      Case
          When circulation_rules.rule_value = ''
          Then 'Not set'
          When circulation_rules.rule_value = 'from_any_library'
          Then 'From any library'
          When circulation_rules.rule_value = 'from_local_hold_group'
          Then 'From local hold group'
          When circulation_rules.rule_value = 'from_home_library'
          Then 'From home library'
          When circulation_rules.rule_value = 'not_allowed'
          Then 'No holds allowed'
          Else 'Not set'
      End As rule_value
    From
      circulation_rules
    Where
      circulation_rules.rule_name = 'holdallowed' And
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) = 'ALL') holdallowed On
      holdallowed.branchcode = categorytypes.branchcode And
      holdallowed.categorycode = categorytypes.categorycode And
      holdallowed.itemtype = categorytypes.itemtype Left Join
  (Select
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode) As branchcode,
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) As categorycode,
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype) As itemtype,
      circulation_rules.rule_name,
      Case
          When circulation_rules.rule_value = ''
          Then 'Not set'
          When circulation_rules.rule_value = 'any'
          Then 'any library'
          When circulation_rules.rule_value = 'holdgroup'
          Then 'item\'s hold group'
          When circulation_rules.rule_value = 'patrongroup'
          Then 'patron\'s hold group'
          When circulation_rules.rule_value = 'homebranch'
          Then 'item\'s home library'
          When circulation_rules.rule_value = 'holdingbranch'
          Then 'item\'s holding library'
          Else 'Not set'
      End As rule_value
    From
      circulation_rules
    Where
      circulation_rules.rule_name = 'hold_fulfillment_policy' And
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) = 'ALL') hold_fulfillment_policy
    On hold_fulfillment_policy.branchcode = categorytypes.branchcode And
      hold_fulfillment_policy.categorycode = categorytypes.categorycode And
      hold_fulfillment_policy.itemtype = categorytypes.itemtype Left Join
  (Select
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode) As branchcode,
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) As categorycode,
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype) As itemtype,
      circulation_rules.rule_name
    From
      circulation_rules
    Where
      circulation_rules.rule_name = 'bookings_lead_period' And
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) = 'ALL') bookings_lead_period On
      bookings_lead_period.branchcode = categorytypes.branchcode And
      bookings_lead_period.categorycode = categorytypes.categorycode And
      bookings_lead_period.itemtype = categorytypes.itemtype Left Join
  (Select
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode) As branchcode,
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) As categorycode,
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype) As itemtype,
      circulation_rules.rule_name
    From
      circulation_rules
    Where
      circulation_rules.rule_name = 'bookings_trail_period' And
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) = 'ALL') bookings_trail_period
    On bookings_trail_period.branchcode = categorytypes.branchcode And
      bookings_trail_period.categorycode = categorytypes.categorycode And
      bookings_trail_period.itemtype = categorytypes.itemtype Left Join
  (Select
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode) As branchcode,
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) As categorycode,
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype) As itemtype,
      circulation_rules.rule_name,
      Case
          When circulation_rules.rule_value = ''
          Then 'Not set'
          When circulation_rules.rule_value = 'homebranch'
          Then 'Item returns home'
          When circulation_rules.rule_value = 'holdingbranch'
          Then 'Item returns to issuing library'
          When circulation_rules.rule_value = 'noreturn'
          Then 'Item floats'
          When circulation_rules.rule_value = 'returnbylibrarygroup'
          Then 'Item floats by library group'
          Else 'Not set'
      End As rule_value
    From
      circulation_rules
    Where
      circulation_rules.rule_name = 'returnbranch' And
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) = 'ALL') returnbranch On
      returnbranch.branchcode = categorytypes.branchcode And
      returnbranch.categorycode = categorytypes.categorycode And
      returnbranch.itemtype = categorytypes.itemtype
Where
  (categorytypes.branchcode Like <<Choose your library|LBRANCH>> Or
      categorytypes.branchcode Like "ALL")
Group By
  branchess.branchcode
Order By
  If(branchess.branchcode = "ALL", "ZZZZZ", branchess.branchcode),
  If(categorytypes.BORROWER_CATEGORY = "All borrowers", "ZZZZZ", categorytypes.BORROWER_CATEGORY),
  If(categorytypes.ITEM_TYPE = "All item types", "ZZZZZ", categorytypes.ITEM_TYPE)

























