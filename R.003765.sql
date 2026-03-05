/*
R.003765

----------

Name: Holds policy by item type rules
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-11 16:54:07
Modified on: 2024-05-28 15:17:31
Date last run: 2025-07-09 11:19:25

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportInfo noprint"&gt; 
 
  &lt;div class="reportInfoContent"&gt; 

    &lt;p&gt; 
      Holds policy by item type rules are hierarchical - First Koha will try to apply the most specific rule at a library first.  If no rule is set (as indicated by "---") then the next broadest rule will be followed. 
    &lt;/p&gt;
 
    &lt;p&gt;Rules are applied in this order:&lt;/p&gt; 
 
    &lt;ul&gt; 
      &lt;li&gt;LIBRARY &gt; SPECIFIC ITEM TYPE&lt;/li&gt;
      &lt;li&gt;LIBRARY &gt; ALL ITEM TYPES&lt;/li&gt;
      &lt;li&gt;ALL LIBRARIES &gt; SPECIFIC ITEM TYPE&lt;/li&gt;
      &lt;li&gt;ALL LIBRARIES &gt; ALL ITEM TYPES&lt;/li&gt;
    &lt;/ul&gt; 
 
  &lt;/div&gt; 
 
  &lt;div class="reportInfoNotes"&gt; 
 
    &lt;p&gt;The default ALL LIBRARIES &gt; ALL ITEM TYPES rule is:&lt;/p&gt;


    &lt;p&gt;All libraries &gt; All item types &gt; Requests can be placed by borrowers at any library &gt; Item can be picked up at any library &gt; Item returns to its home library when checked in&lt;/p&gt; 
 
 
    &lt;p&gt; 
 
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;div id="reportInfoTags"&gt; 
 
    &lt;p style="display: none;"&gt; 
      #tags_go_here 
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
 
&lt;/div&gt; 

----------
*/



Select 
  branches_itemtypess.branchname As BRANCH,
  branches_itemtypess.description As ITEM_TYPE,
  If(
    holdallowed.rule_value = 'from_any_library',
    'From any library',
    If(
      holdallowed.rule_value = 'from_local_hold_group',
      'From local hold group',
      If(
        holdallowed.rule_value = 'from_home_library',
        'From home library',
        If(
          holdallowed.rule_value = 'not_allowed',
          'No holds allowed',
          '---'
        )
      )
    )
  ) As 'Requests can be placed by borrowers from',
  If(
    hold_fulfillment_policy.rule_value = 'any',
    'any library',
    If(
      hold_fulfillment_policy.rule_value = 'holdgroup',
      'item\s hold group',
      If(
        hold_fulfillment_policy.rule_value = 'patrongroup',
        'patron\s hold group',
        If(
          hold_fulfillment_policy.rule_value = 'homebranch',
          'item\s home library',
          If(
            hold_fulfillment_policy.rule_value = 'holdingbranch',
            'item\s holding library',
            '---'
          )
        )
      )
    )
  ) As 'for pickup at',
  If(
    returnbranch.rule_value = 'homebranch',
    'Item returns home',
    If(
      returnbranch.rule_value = 'holdingbranch',
      'Item returns to issuing library',
      If(
        returnbranch.rule_value = 'noreturn',
        'Item floats',
        '---'
      )
    )
  ) As 'When checked in, the item will'
From (
    Select 
      branchess.branchcode,
      branchess.branchname,
      itemtypes.itemtype,
      itemtypes.description
    From (
        Select 
          branches.branchcode,
          branches.branchname
        From branches
        UNION
        Select Concat('&ast;') As branchcode,
          Concat(' All libraries') As branchname
        From branches
      ) branchess,
      (
        Select 
          itemtypes.itemtype,
          itemtypes.description
        From itemtypes
        UNION
        Select 
          Concat('&ast;') As itemtype,
          Concat(' All item types') As description
        From itemtypes
      ) itemtypes
    Where (
        branchess.branchcode Like &lt;&gt;
        Or branchess.branchcode Like '&ast;'
      )
  ) branches_itemtypess
  Left Join (
    Select 
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, '&ast;') As branchcode,
      Coalesce(circulation_rules.categorycode, '&ast;') As categorycode,
      circulation_rules.itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    From circulation_rules
    Where circulation_rules.rule_name = 'holdallowed'
  ) holdallowed On holdallowed.branchcode = branches_itemtypess.branchcode
  And holdallowed.itemtype = branches_itemtypess.itemtype
  Left Join (
    Select 
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, '&ast;') As branchcode,
      Coalesce(circulation_rules.categorycode, '&ast;') As categorycode,
      circulation_rules.itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    From circulation_rules
    Where circulation_rules.rule_name = 'hold_fulfillment_policy'
  ) hold_fulfillment_policy On hold_fulfillment_policy.branchcode = branches_itemtypess.branchcode
  And hold_fulfillment_policy.itemtype = branches_itemtypess.itemtype
  Left Join (
    Select 
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, '&ast;') As branchcode,
      Coalesce(circulation_rules.categorycode, '&ast;') As categorycode,
      circulation_rules.itemtype,
      circulation_rules.rule_name,
      circulation_rules.rule_value
    From circulation_rules
    Where circulation_rules.rule_name = 'returnbranch'
  ) returnbranch On returnbranch.branchcode = branches_itemtypess.branchcode
  And returnbranch.itemtype = branches_itemtypess.itemtype
Group By 
  branches_itemtypess.branchname,
  branches_itemtypess.description
Order By 
  If(
    BRANCH = ' All libraries', 
    'Z', 
    BRANCH
  ),
  If(
    branches_itemtypess.description = ' All item types',
    'Z',
    branches_itemtypess.description
  )
LIMIT 50000

























