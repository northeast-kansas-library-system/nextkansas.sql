/*
R.003487

----------

Name: GHW - Circulation/fees/request rules 2 - late fees
Created by: George Williams

----------

Group: -
     -

Created on: 2021-03-30 09:23:49
Modified on: 2025-07-11 23:03:34
Date last run: 2025-07-11 23:03:44

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Verbose listing of circulation/fees/request rules regarding late fees</p>
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
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3486&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">rules, circulation</p>

<div style="display: none;">
<ul>
<li>branchcode</li>
<li>Patron category</li>
<li>Item type</li>
<li></li>
<li></li>
<li>Fine amount</li>
<li>Fine charging interval</li>
<li>Unit</li>
<li>When to charge</li>
<li>Fine/suspension grace period</li>
<li>Overdue fines cap</li>
<li>Suspension in days (day)</li>
<li>Max. suspension duration (day)</li>
<li>Suspension charging interval</li>
</ul>
</div>

</div>

----------
*/



Select
  Coalesce(branches.branchname, 'All libraries') As 'Library',
  Coalesce(categories.description, 'All categories') As 'Patron category',
  Coalesce(itemtypes.description, 'All item types') As 'Item type',
  Max(Case
      When circulation_rules_sq.rule_name = 'note'
      Then circulation_rules_sq.rule_value
      Else Null
  End) As 'Note',
  Max(Case
      When circulation_rules_sq.rule_name = 'fine'
      Then Format(circulation_rules_sq.rule_value, 2)
      Else Null
  End) As 'Fine amount',
  Max(Case
      When circulation_rules_sq.rule_name = 'chargeperiod'
      Then circulation_rules_sq.rule_value
      Else Null
  End) As 'Fine charging interval',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'lengthunit' Then If(
        Coalesce(circulation_rules_sq.rule_value, '') = '',
        'Unlimited',
        circulation_rules_sq.rule_value
      )
      Else Null
    End
  ) As 'Unit',
  Max(Case
      When circulation_rules_sq.rule_name = 'chargeperiod_charge_at'
      Then (Case
              When circulation_rules_sq.rule_value = '0'
              Then 'End of interval'
              When circulation_rules_sq.rule_value = '1'
              Then 'Start of interval'
              Else circulation_rules_sq.rule_value
          End)
      Else ''
  End) As 'When to charge',
  Max(Case
      When circulation_rules_sq.rule_name = 'firstremind'
      Then circulation_rules_sq.rule_value
      Else Null
  End) As 'Fine/suspension grace period',
  If(Max(Case
      When circulation_rules_sq.rule_name = 'cap_fine_to_replacement_price'
      Then If(circulation_rules_sq.rule_value = '1', '1', '')
      Else Null
  End) = 1, 'Cap fine at replacement price', Max(Case
      When circulation_rules_sq.rule_name = 'overduefinescap'
      Then Format(circulation_rules_sq.rule_value, 2)
      Else Null
  End)) As 'Overdue fines cap (amount)'
From
  (Select
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, 'all') As branchcode,
      Coalesce(circulation_rules.categorycode, 'all') As categorycode,
      Coalesce(circulation_rules.itemtype, 'all') As itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    From
      circulation_rules
    Where
      circulation_rules.rule_name <> 'accountsent' And
      circulation_rules.rule_name <> 'bookings_lead_period' And
      circulation_rules.rule_name <> 'bookings_trail_period' And
      circulation_rules.rule_name <> 'finedays' And
      circulation_rules.rule_name <> 'hold_fulfillment_policy' And
      circulation_rules.rule_name <> 'holdallowed' And
      circulation_rules.rule_name <> 'lostreturn' And
      circulation_rules.rule_name <> 'max_holds' And
      circulation_rules.rule_name <> 'patron_maxissueqty' And
      circulation_rules.rule_name <> 'patron_maxonsiteissueqty' And
      circulation_rules.rule_name <> 'restrictedtype' And
      circulation_rules.rule_name <> 'returnbranch' And
      circulation_rules.rule_name <> 'unseen_renewals_allowed' And
      circulation_rules.rule_name <> 'waiting_hold_cancellation'
    Group By
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, 'all'),
      Coalesce(circulation_rules.categorycode, 'all'),
      Coalesce(circulation_rules.itemtype, 'all'),
      circulation_rules.rule_name,
      circulation_rules.rule_value) circulation_rules_sq Left Join
  branches On branches.branchcode = circulation_rules_sq.branchcode Left Join
  categories On categories.categorycode = circulation_rules_sq.categorycode Left Join
  itemtypes On itemtypes.itemtype = circulation_rules_sq.itemtype
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

























