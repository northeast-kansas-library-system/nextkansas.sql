/*
R.003885

----------

Name: Checkout, hold policy by patron category
Created by: George Williams

----------

Group: -
     -

Created on: 2025-04-30 21:44:39
Modified on: 2025-04-30 21:44:39
Date last run: 2025-07-09 11:10:43

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  branchess.branchname,
  categorytypes.BORROWER_CATEGORY,
  If(
    Coalesce(patron_maxissueqty.rule_value, '') = '', 
    'Unlimited', 
    patron_maxissueqty.rule_value
  ) As `Total current checkouts allowed`,
  If(
    Coalesce(patron_maxonsiteissueqty.rule_value, '') = '', 
    'Unlimited', 
    patron_maxonsiteissueqty.rule_value
  ) As `Total current on-site checkouts allowed`,
  If(
    Coalesce(max_holds.rule_value, '') = '', 
    'Unlimited', 
    max_holds.rule_value
  ) As `Maximum total holds allowed (count)`
From
  (
    Select
      branches.branchcode,
      branches.branchname
    From
      branches
    UNION
    Select
      Concat('ALL') As branchcode,
      Concat('All libraries') As branchname
  ) branchess 
  Join
  (
    Select
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
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) &lt;&gt; 'ALL'
    Group By
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode),
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode),
      If(categories.description Is Null, "All borrowers", categories.description),
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype),
      If(itemtypes.description Is Null, "All item types", itemtypes.description)
    ) categorytypes 
    On categorytypes.branchcode = branchess.branchcode 
  Left Join
  (
    Select
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode) As branchcode,
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) As categorycode,
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype) As itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    From
      circulation_rules
    Where
      circulation_rules.rule_name = 'patron_maxissueqty'
  ) patron_maxissueqty 
    On patron_maxissueqty.branchcode = categorytypes.branchcode And
      patron_maxissueqty.categorycode = categorytypes.categorycode And
      patron_maxissueqty.itemtype = categorytypes.itemtype Left 
  Join
  (
    Select
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode) As branchcode,
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) As categorycode,
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype) As itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    From
      circulation_rules
    Where
      circulation_rules.rule_name = 'patron_maxonsiteissueqty'
    ) patron_maxonsiteissueqty 
      On patron_maxonsiteissueqty.branchcode = categorytypes.branchcode And
      patron_maxonsiteissueqty.categorycode = categorytypes.categorycode And
      patron_maxonsiteissueqty.itemtype = categorytypes.itemtype Left Join
  (
    Select
      If(circulation_rules.branchcode Is Null, "ALL", circulation_rules.branchcode) As branchcode,
      If(circulation_rules.categorycode Is Null, "ALL", circulation_rules.categorycode) As categorycode,
      If(circulation_rules.itemtype Is Null, "ALL", circulation_rules.itemtype) As itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    From
      circulation_rules
    Where
      circulation_rules.rule_name = 'max_holds'
  ) max_holds 
    On max_holds.branchcode = categorytypes.branchcode And
    max_holds.categorycode = categorytypes.categorycode And
    max_holds.itemtype = categorytypes.itemtype
Where
  (Coalesce(patron_maxissueqty.rule_value, '-10') + 
    Coalesce(patron_maxonsiteissueqty.rule_value, '-10') + 
    Coalesce(max_holds.rule_value, '-10')
  ) &lt;&gt; -30 And
  (categorytypes.branchcode Like &lt;&gt; Or
      categorytypes.branchcode Like "ALL")
Group By
  categorytypes.BORROWER_CATEGORY,
  branchess.branchcode
Order By
  If(branchess.branchcode = "ALL", "ZZZZZ", branchess.branchcode),
  If(categorytypes.BORROWER_CATEGORY = "All borrowers", "ZZZZZ", categorytypes.BORROWER_CATEGORY),
  If(categorytypes.ITEM_TYPE = "All item types", "ZZZZZ", categorytypes.ITEM_TYPE)

























