/*
R.003488

----------

Name: GHW - Circulation/fees/request rules 3 - requests
Created by: George Williams

----------

Group: -
     -

Created on: 2021-03-30 09:53:38
Modified on: 2025-07-11 23:04:16
Date last run: 2025-07-11 23:04:19

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Verbose listing of circulation/fees/request rules regarding requests and some miscellaneous rules</p>
<ul><li>Shows the current rules</li>
<li>at the library you specify</li>
<li>grouped and sorted by rule branchcode, borrower category, and item type</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Rules are applied from most specific to least specific and the rules in this report are set to display from most specific to least specific.  The higher a rule is in the results of this report, the higher its priority.</p>
<p></p>
<p>In Next Search Catalog, rules for requests are applied following the rules at the library that owns an item.<br />(Based on the ReservesControlBranch system preference - 2021.03.10)</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3486&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">rules, circulation</p>

<div style="display: none;">
<ul>
<li>branchcode</li>
<li>Patron category</li>
<li>Item type</li>
<li></li>
<li>Holds allowed (total)</li>
<li>Holds allowed (daily)</li>
<li>Holds per record (count)</li>
<li>On shelf holds allowed</li>
<li>OPAC item level holds</li>
<li>Holds pickup period (day)</li>
<li>Article requests</li>
<li>Rental discount (%)</li>
</ul>
</div>

</div>

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
      When circulation_rules_sq.rule_name = 'reservesallowed' 
      Then 
        If(
          Coalesce(circulation_rules_sq.rule_value, '') = '',
          'Unlimited',
          circulation_rules_sq.rule_value
        )
      Else Null
    End
  ) As 'Holds allowed (total)',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'holds_per_day' 
      Then 
        If(
          Coalesce(circulation_rules_sq.rule_value, '') = '',
          'Unlimited',
          circulation_rules_sq.rule_value
        )
      Else Null
    End
  ) As 'Holds allowed (daily)',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'holds_per_record' 
      Then 
        If(
          Coalesce(circulation_rules_sq.rule_value, '') = '',
          'Unlimited',
          circulation_rules_sq.rule_value
        )
      Else Null
    End
  ) As 'Holds per record (count)',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'onshelfholds' 
      Then (
        Case
          When circulation_rules_sq.rule_value = '0' 
          Then 'No'
          When circulation_rules_sq.rule_value = '1' 
          Then 'Yes'
          Else circulation_rules_sq.rule_value
        End
      )
      Else ''
    End
  ) As 'On shelf holds allowed',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'opacitemholds' 
      Then (
        Case
          When circulation_rules_sq.rule_value = 'N' Then 'Don\'t allow'
          When circulation_rules_sq.rule_value = 'Y' Then 'Allow'
          When circulation_rules_sq.rule_value = 'F' Then 'Force'
          Else circulation_rules_sq.rule_value
        End
      )
      Else ''
    End
  ) As 'OPAC item level holds',
  IF(
    Max(
      Case
        When circulation_rules_sq.rule_name = 'holds_pickup_period' 
        Then circulation_rules_sq.rule_value
        Else ''
      End
    ) &gt; 0,
    Max(
      Case
        When circulation_rules_sq.rule_name = 'holds_pickup_period' 
        Then circulation_rules_sq.rule_value
        Else ''
      End
    ),
    'Default'
  ) As 'Holds pickup period (day)'
From (
    Select circulation_rules.id,
      Coalesce(circulation_rules.branchcode, 'all') As branchcode,
      Coalesce(circulation_rules.categorycode, 'all') As categorycode,
      Coalesce(circulation_rules.itemtype, 'all') As itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    From circulation_rules
    Where circulation_rules.rule_name &lt;&gt; 'accountsent'
      And circulation_rules.rule_name &lt;&gt; 'bookings_lead_period'
      And circulation_rules.rule_name &lt;&gt; 'bookings_trail_period'
      And circulation_rules.rule_name &lt;&gt; 'finedays'
      And circulation_rules.rule_name &lt;&gt; 'hold_fulfillment_policy'
      And circulation_rules.rule_name &lt;&gt; 'holdallowed'
      And circulation_rules.rule_name &lt;&gt; 'lostreturn'
      And circulation_rules.rule_name &lt;&gt; 'max_holds'
      And circulation_rules.rule_name &lt;&gt; 'patron_maxissueqty'
      And circulation_rules.rule_name &lt;&gt; 'patron_maxonsiteissueqty'
      And circulation_rules.rule_name &lt;&gt; 'restrictedtype'
      And circulation_rules.rule_name &lt;&gt; 'returnbranch'
      And circulation_rules.rule_name &lt;&gt; 'unseen_renewals_allowed'
      And circulation_rules.rule_name &lt;&gt; 'waiting_hold_cancellation'
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
    circulation_rules_sq.branchcode Like &lt;&gt; OR
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

























