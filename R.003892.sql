/*
R.003892

----------

Name: GHW - Circulation/fees/request rules 4 - Misceleaneous
Created by: George Williams

----------

Group: -
     -

Created on: 2025-07-10 17:21:36
Modified on: 2025-07-11 23:17:13
Date last run: 2025-07-11 23:17:22

----------

Public: 0
Expiry: 300

----------



----------
*/



Select 
  Coalesce(branches.branchname, 'All libraries') As 'Library',
  Coalesce(categories.description, 'All categories') As 'Patron category',
  Coalesce(itemtypes.description, 'All item types') As 'Item type',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'note' 
        Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'Note',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'fined' 
        Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'Suspension in days (day)',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'maxsuspensiondays' 
        Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'Max. suspension duration (day)',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'suspension_chargeperiod' 
        Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'Suspension charging interval',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'article_requests' 
        Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'Article requests xx',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'article_requests' 
        Then (
          Case
            When circulation_rules_sq.rule_value = 'no' 
              Then 'No'
            When circulation_rules_sq.rule_value = 'yes' 
              Then 'Yes'
            When circulation_rules_sq.rule_value = 'bib_only' 
              Then 'Record only'
            When circulation_rules_sq.rule_value = 'item_only' 
              Then 'Item only'
            Else circulation_rules_sq.rule_value
          End
        )
      Else ''
    End
  ) As 'Article requests',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'rentaldiscount' 
        Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'Rental discount (%)'
From (
    Select circulation_rules.id,
      Coalesce(circulation_rules.branchcode, 'all') As branchcode,
      Coalesce(circulation_rules.categorycode, 'all') As categorycode,
      Coalesce(circulation_rules.itemtype, 'all') As itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    From circulation_rules
    Where circulation_rules.rule_name <> 'accountsent'
      And circulation_rules.rule_name <> 'bookings_lead_period'
      And circulation_rules.rule_name <> 'bookings_trail_period'
      And circulation_rules.rule_name <> 'finedays'
      And circulation_rules.rule_name <> 'hold_fulfillment_policy'
      And circulation_rules.rule_name <> 'holdallowed'
      And circulation_rules.rule_name <> 'lostreturn'
      And circulation_rules.rule_name <> 'max_holds'
      And circulation_rules.rule_name <> 'patron_maxissueqty'
      And circulation_rules.rule_name <> 'patron_maxonsiteissueqty'
      And circulation_rules.rule_name <> 'restrictedtype'
      And circulation_rules.rule_name <> 'returnbranch'
      And circulation_rules.rule_name <> 'unseen_renewals_allowed'
      And circulation_rules.rule_name <> 'waiting_hold_cancellation'
    Group By circulation_rules.id,
      Coalesce(circulation_rules.branchcode, 'all'),
      Coalesce(circulation_rules.categorycode, 'all'),
      Coalesce(circulation_rules.itemtype, 'all'),
      circulation_rules.rule_name,
      circulation_rules.rule_value
  ) circulation_rules_sq
  Left Join branches 
    On branches.branchcode = circulation_rules_sq.branchcode
  Left Join categories 
    On categories.categorycode = circulation_rules_sq.categorycode
  Left Join itemtypes 
    On itemtypes.itemtype = circulation_rules_sq.itemtype
Where
  (
    circulation_rules_sq.branchcode Like <> OR
    circulation_rules_sq.branchcode Like 'all'
  )
Group By 
  circulation_rules_sq.branchcode,
  circulation_rules_sq.categorycode,
  circulation_rules_sq.itemtype
Order By 
  Coalesce(branches.branchname, 'ZZZZZ'),
  Coalesce(categories.description, 'ZZZZZ'),
  Coalesce(itemtypes.description, 'ZZZZZ')

























