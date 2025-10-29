/*
R.003486

----------

Name: GHW - Circulation/fees/request rules 1 - circulation and renewal
Created by: George Williams

----------

Group: -
     -

Created on: 2021-03-30 09:13:51
Modified on: 2025-07-11 23:04:53
Date last run: 2025-10-17 13:55:15

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
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

<div style="display: none;">
<ul>
<li>Branchcode</li>
<li>Patron category</li>
<li>Item type</li>
<li>Note</li>
<li></li>
<li>Current checkouts allowed</li>
<li>Current on-site checkouts allowed</li>
<li>Loan period</li>
<li>Days mode</li>
<li>Unit</li>
<li>Hard due date - comparison</li>
<li>Hard due date - date</li>
<li>Decreased loan period for high holds (day)</li>
<li>Renewals allowed (count)</li>
<li>Renewal period</li>
<li>No renewal before</li>
<li>No automatic renewal before</li>
<li>Automatic renewal</li>
<li>No automatic renewal after</li>
<li>No automatic renewal after (hard limit)</li>
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
      When circulation_rules_sq.rule_name = 'note' Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'Note',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'maxissueqty' Then If(
        Coalesce(circulation_rules_sq.rule_value, '') = '',
        'Unlimited',
        circulation_rules_sq.rule_value
      )
      Else Null
    End
  ) As 'Current checkouts allowed',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'maxonsiteissueqty' Then If(
        Coalesce(circulation_rules_sq.rule_value, '') = '',
        'Unlimited',
        circulation_rules_sq.rule_value
      )
      Else Null
    End
  ) As 'Current on-site checkouts allowed',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'issuelength' Then If(
        Coalesce(circulation_rules_sq.rule_value, '') = '',
        'Unlimited',
        circulation_rules_sq.rule_value
      )
      Else Null
    End
  ) As 'Loan period',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'daysmode' Then (
        Case
          When circulation_rules_sq.rule_value Is Null Then 'Default'
          When circulation_rules_sq.rule_value = 'Calendar' Then 'Skip closed days'
          When circulation_rules_sq.rule_value = 'Datedue' Then 'Next open day'
          When circulation_rules_sq.rule_value = 'Days' Then 'Ignore the calendar'
          When circulation_rules_sq.rule_value = 'Dayweek' Then 'Same week day'
          Else circulation_rules_sq.rule_value
        End
      )
      Else 'Default'
    End
  ) As 'Days mode',
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
  Concat_Ws(
    ' ',
    If(
      Max(
        Case
          When circulation_rules_sq.rule_name = 'hardduedate' Then circulation_rules_sq.rule_value
          Else Null
        End
      ) = '',
      '',
      Max(
        Case
          When circulation_rules_sq.rule_name = 'hardduedatecompare' Then (
            Case
              When circulation_rules_sq.rule_value = '-1' Then 'Before'
              When circulation_rules_sq.rule_value = '0' Then 'Exactly on'
              When circulation_rules_sq.rule_value = '1' Then 'After'
              Else circulation_rules_sq.rule_value
            End
          )
          Else ''
        End
      )
    ),
    Max(
      Case
        When circulation_rules_sq.rule_name = 'hardduedate' Then circulation_rules_sq.rule_value
        Else Null
      End
    )
  ) As 'Hard due date',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'decreaseloanholds' Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'Decreased loan period for high holds (day)',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'renewalsallowed' Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'Renewals allowed (count)',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'renewalperiod' Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'Renewal period',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'norenewalbefore' Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'No renewal before',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'noautorenewalbefore' Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'No automatic renewal before',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'auto_renew' Then (
        Case
          When circulation_rules_sq.rule_value = '0' Then 'No'
          When circulation_rules_sq.rule_value = '1' Then 'Yes'
          Else circulation_rules_sq.rule_value
        End
      )
      Else ''
    End
  ) As 'Automatic renewal',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'no_auto_renewal_after' Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'No automatic renewal after',
  Max(
    Case
      When circulation_rules_sq.rule_name = 'no_auto_renewal_after_hard_limit' Then circulation_rules_sq.rule_value
      Else Null
    End
  ) As 'No automatic renewal after (hard limit)'
From (
  Select 
    circulation_rules.id,
    Coalesce(circulation_rules.branchcode, 'all') As branchcode,
    Coalesce(circulation_rules.categorycode, 'all') As categorycode,
    Coalesce(circulation_rules.itemtype, 'all') As itemtype,
    circulation_rules.rule_name,
    circulation_rules.rule_value
  From circulation_rules
  Where 
    circulation_rules.rule_name &lt;&gt; 'accountsent'
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
  Group By 
    circulation_rules.id,
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

























