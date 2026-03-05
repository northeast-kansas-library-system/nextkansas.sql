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

<div class="reportInfo noprint"> 
 
  <div class="reportInfoContent"> 

    <p> 
      Holds policy by item type rules are hierarchical - First Koha will try to apply the most specific rule at a library first.  If no rule is set (as indicated by "---") then the next broadest rule will be followed. 
    </p>
 
    <p>Rules are applied in this order:</p> 
 
    <ul> 
      <li>LIBRARY > SPECIFIC ITEM TYPE</li>
      <li>LIBRARY > ALL ITEM TYPES</li>
      <li>ALL LIBRARIES > SPECIFIC ITEM TYPE</li>
      <li>ALL LIBRARIES > ALL ITEM TYPES</li>
    </ul> 
 
  </div> 
 
  <div class="reportInfoNotes"> 
 
    <p>The default ALL LIBRARIES > ALL ITEM TYPES rule is:</p>


    <p>All libraries > All item types > Requests can be placed by borrowers at any library > Item can be picked up at any library > Item returns to its home library when checked in</p> 
 
 
    <p> 
 
    </p> 
 
  </div> 
 
  <div id="reportInfoTags"> 
 
    <p style="display: none;"> 
      #tags_go_here 
    </p> 
 
  </div> 
 
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
 
</div> 

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
        Select Concat('*') As branchcode,
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
          Concat('*') As itemtype,
          Concat(' All item types') As description
        From itemtypes
      ) itemtypes
    Where (
        branchess.branchcode Like <<Choose your library|ZBRAN>>
        Or branchess.branchcode Like '*'
      )
  ) branches_itemtypess
  Left Join (
    Select 
      circulation_rules.id,
      Coalesce(circulation_rules.branchcode, '*') As branchcode,
      Coalesce(circulation_rules.categorycode, '*') As categorycode,
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
      Coalesce(circulation_rules.branchcode, '*') As branchcode,
      Coalesce(circulation_rules.categorycode, '*') As categorycode,
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
      Coalesce(circulation_rules.branchcode, '*') As branchcode,
      Coalesce(circulation_rules.categorycode, '*') As categorycode,
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

























