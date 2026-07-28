/*
R.003530

----------

Name: 0105 - 2024_99_f_item_count_item_type monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-07-26 11:25:35
Modified on: 2026-01-30 17:30:39
Date last run: 2026-07-01 01:05:02

----------

Public: 0
Expiry: 300

----------

<div> 
 
  <div> 
 
    <p>Items and holdings statistics - item count by item type</p> 
 
    <ul> 
      <li>Generates a count of items all items owned at the time the report is run plus items added and deleted in the previous calendar month</li> 
      <li>columns are grouped by shelving locations</li> 
      <li>at all system libraries</li> 
      <li>grouped and sorted by item home library</li> 
      <li>sorted by</li> 
      <li>links</li> 
    </ul> 
 
    <p> 
      Notes: 
    </p> 
 
    <p> 
 
    </p> 
 
    <p>Items with blank item types are counted as "(Unclassified)."</p> 

    <ul> 
      <li>"ADULT" includes items with these permanent shelving locations:</li> 

      <ul> 
        <li>Adult</li> 
        <li>~Display - BALDWIN - Adult</li> 
        <li>~Display - LEAVENWRTH - Adult</li> 
        <li>~Display - PAOLA - Adult</li> 
        <li>Cataloging</li> 
        <li>Processing Center</li> 
        <li>Any items where the permanent shelving location is blank or ambiguous</li> 
      </ul> 

      <br /> 

      <li>"YOUNG ADULT" includes items with these permanent shelving locations:</li> 

      <ul> 
        <li>Young adult</li> 
        <li>~Display - BALDWIN - Young Adult</li> 
        <li>~Display - LEAVENWRTH - Young adult</li> 
        <li>~Display - PAOLA - Young adult</li> 
        <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Young adult" locations</li> 
      </ul> 

      <br /> 

      <li>"JUVENILE" includes items with these permanent shelving locations:</li>

      <ul> 
        <li>Childrens</li> 
        <li>~Display - BALDWIN - Childrens</li> 
        <li>~Display - LEAVENWRTH - Children's</li> 
        <li>~Display - PAOLA - Children's</li> 
        <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Childrens" locations</li> 
      </ul> 

    </ul> 
 
    <p> 
 
    </p> 

    <p>
      This report and these notes updated on 2022.03.10
    </p> 

    <p>

    </p>

    <p>
      This report cannot track changes made to existing records over time.  Therefore, if staff change the home library, location, or item type of an item, those changes will not be reflected in the additions or deletions columns.  This means that the numbers may look inconsistent from month to month if changes are made to item records.
    </p> 
    
    <p>

    </p> 
 
  </div> 
 
  <div> 
 
    <p> 
       
        Download as a .csv file 
       
    </p> 
 
    <p> 
      #statistics
      #monthlyStatistics 
      #itemCount 
      #itemType 
    </p> 
 
     
 
  </div>
 
</div> 

----------
*/



SELECT 
  'branchname' AS 'branchname',
  'ITEM TYPE' AS 'ITEM TYPE',
  'TOTAL ITEMS' AS 'TOTAL ITEMS',
  'ADULT ITEMS' AS 'ADULT ITEMS',
  'YOUNG ADULT ITEMS' AS 'YOUNG ADULT ITEMS',
  'JUVENILE ITEMS' AS 'JUVENILE ITEMS',
  'TOTAL ADDED LM' AS 'TOTAL ADDED LM',
  'ADULT ADDED LM' AS 'ADULT ADDED LM',
  'YOUNG ADULT ADDED LM' AS 'YOUNG ADULT ADDED LM',
  'JUVENILE ADDED LM' AS 'JUVENILE ADDED LM',
  'TOTAL DELETED LM' AS 'TOTAL DELETED LM',
  'ADULT DELETED LM' AS 'ADULT DELETED LM',
  'YOUNG ADULT DELETED LM' AS 'YOUNG ADULT DELETED LM',
  'JUVENILE DELETED LM' AS 'JUVENILE DELETED LM'
UNION 
(Select 
  branchtypes.branchname,
  branchtypes.description As 'ITEM TYPE',
  Sum(itemss.Count_itemnumber) As 'TOTAL ITEMS',
  Sum(adultitems.Count_itemnumber) As 'ADULT ITEMS',
  Sum(yaitems.Count_itemnumber) As 'YOUNG ADULT ITEMS',
  Sum(juvenileitems.Count_itemnumber) As 'JUVENILE ITEMS',
  Sum(items_added.Count_itemnumber) As 'TOTAL ADDED LM',
  Sum(adult_added.Count_itemnumber) As 'ADULT ADDED LM',
  Sum(ya_added.Count_itemnumber) As 'YOUNG ADULT ADDED LM',
  Sum(juvenile_added.Count_itemnumber) As 'JUVENILE ADDED LM',
  Sum(items_deleted.Count_itemnumber) As 'TOTAL DELETED LM',
  Sum(adult_deleted.Count_itemnumber) As 'ADULT DELETED LM',
  Sum(ya_deleted.Count_itemnumber) As 'YOUNG ADULT DELETED LM',
  Sum(juvenile_deleted.Count_itemnumber) As 'JUVENILE DELETED LM'
From (
    Select 
      branches.branchcode,
      branches.branchname,
      itemtypes.itemtype,
      itemtypes.description
    From itemtypes,
      branches
    Where branches.branchcode Like '%'
  ) branchtypes
  Left Join (
    Select 
      items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype) As itype,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Group By items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype)
  ) itemss On itemss.homebranch = branchtypes.branchcode
  And itemss.itype = branchtypes.itemtype
  Left Join (
    Select 
      items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype) As itype,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Where (
        items.permanent_location Like '%AD%'
        Or items.permanent_location = 'CART'
        Or items.permanent_location = 'CATALOGING'
        Or items.permanent_location = 'PROC'
        Or items.permanent_location Is Null
      )
    Group By items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype)
  ) adultitems On adultitems.homebranch = branchtypes.branchcode
  And adultitems.itype = branchtypes.itemtype
  Left Join (
    Select 
      items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype) As itype,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Where items.permanent_location Like '%JU%'
    Group By items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype)
  ) juvenileitems On juvenileitems.homebranch = branchtypes.branchcode
  And juvenileitems.itype = branchtypes.itemtype
  Left Join (
    Select 
      items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype) As itype,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Where items.permanent_location Like '%YA%'
    Group By items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype)
  ) yaitems On yaitems.homebranch = branchtypes.branchcode
  And yaitems.itype = branchtypes.itemtype
  Left Join (
    Select 
      items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype) As itype,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Where Month(items.dateaccessioned) = Month(Now() - Interval 1 Month)
      And Year(items.dateaccessioned) = Year(Now() - Interval 1 Month)
    Group By items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype)
  ) items_added On items_added.homebranch = branchtypes.branchcode
  And items_added.itype = branchtypes.itemtype
  Left Join (
    Select 
      items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype) As itype,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Where Month(items.dateaccessioned) = Month(Now() - Interval 1 Month)
      And Year(items.dateaccessioned) = Year(Now() - Interval 1 Month)
      And (
        items.permanent_location Like '%AD%'
        Or items.permanent_location = 'CART'
        Or items.permanent_location = 'CATALOGING'
        Or items.permanent_location = 'PROC'
        Or items.permanent_location Is Null
      )
    Group By items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype)
  ) adult_added On adult_added.homebranch = branchtypes.branchcode
  And adult_added.itype = branchtypes.itemtype
  Left Join (
    Select 
      items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype) As itype,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Where Month(items.dateaccessioned) = Month(Now() - Interval 1 Month)
      And Year(items.dateaccessioned) = Year(Now() - Interval 1 Month)
      And items.permanent_location Like '%JU%'
    Group By items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype)
  ) juvenile_added On juvenile_added.homebranch = branchtypes.branchcode
  And juvenile_added.itype = branchtypes.itemtype
  Left Join (
    Select 
      items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype) As itype,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Where Month(items.dateaccessioned) = Month(Now() - Interval 1 Month)
      And Year(items.dateaccessioned) = Year(Now() - Interval 1 Month)
      And items.permanent_location Like '%YA%'
    Group By items.homebranch,
      If(items.itype Is Null, 'XXX', items.itype)
  ) ya_added On ya_added.homebranch = branchtypes.branchcode
  And ya_added.itype = branchtypes.itemtype
  Left Join (
    Select 
      deleteditems.homebranch,
      If(
        deleteditems.itype Is Null,
        'XXX',
        If(
          deleteditems.itype = '',
          'XXX',
          deleteditems.itype
        )
      ) As ccode,
      Count(deleteditems.itemnumber) As Count_itemnumber
    From deleteditems
    Where Month(deleteditems.timestamp) = Month(Now() - Interval 1 Month)
      And Year(deleteditems.timestamp) = Year(Now() - Interval 1 Month)
    Group By deleteditems.homebranch,
      If(
        deleteditems.itype Is Null,
        'XXX',
        If(
          deleteditems.itype = '',
          'XXX',
          deleteditems.itype
        )
      )
  ) items_deleted On items_deleted.homebranch = branchtypes.branchcode
  And items_deleted.ccode = branchtypes.itemtype
  Left Join (
    Select 
      deleteditems.homebranch,
      If(
        deleteditems.itype Is Null,
        'XXX',
        If(
          deleteditems.itype = '',
          'XXX',
          deleteditems.itype
        )
      ) As ccode,
      Count(deleteditems.itemnumber) As Count_itemnumber
    From deleteditems
    Where Month(deleteditems.dateaccessioned) = Month(Now() - Interval 1 Month)
      And Year(deleteditems.dateaccessioned) = Year(Now() - Interval 1 Month)
      And (
        deleteditems.permanent_location Like '%AD%'
        Or deleteditems.permanent_location = 'CART'
        Or deleteditems.permanent_location = 'CATALOGING'
        Or deleteditems.permanent_location = 'PROC'
        Or deleteditems.permanent_location Is Null
      )
    Group By deleteditems.homebranch,
      If(
        deleteditems.itype Is Null,
        'XXX',
        If(
          deleteditems.itype = '',
          'XXX',
          deleteditems.itype
        )
      )
  ) adult_deleted On adult_deleted.homebranch = branchtypes.branchcode
  And adult_deleted.ccode = branchtypes.itemtype
  Left Join (
    Select 
      deleteditems.homebranch,
      If(
        deleteditems.itype Is Null,
        'XXX',
        If(
          deleteditems.itype = '',
          'XXX',
          deleteditems.itype
        )
      ) As ccode,
      Count(deleteditems.itemnumber) As Count_itemnumber
    From deleteditems
    Where Month(deleteditems.dateaccessioned) = Month(Now() - Interval 1 Month)
      And Year(deleteditems.dateaccessioned) = Year(Now() - Interval 1 Month)
      And (deleteditems.permanent_location Like '%JU%' 
      OR deleteditems.permanent_location Like '%CHILD%')
    Group By deleteditems.homebranch,
      If(
        deleteditems.itype Is Null,
        'XXX',
        If(
          deleteditems.itype = '',
          'XXX',
          deleteditems.itype
        )
      )
  ) juvenile_deleted On juvenile_deleted.homebranch = branchtypes.branchcode
  And juvenile_deleted.ccode = branchtypes.itemtype
  Left Join (
    Select 
      deleteditems.homebranch,
      If(
        deleteditems.itype Is Null,
        'XXX',
        If(
          deleteditems.itype = '',
          'XXX',
          deleteditems.itype
        )
      ) As ccode,
      Count(deleteditems.itemnumber) As Count_itemnumber
    From deleteditems
    Where Month(deleteditems.dateaccessioned) = Month(Now() - Interval 1 Month)
      And Year(deleteditems.dateaccessioned) = Year(Now() - Interval 1 Month)
      And deleteditems.permanent_location Like '%YA%'
    Group By deleteditems.homebranch,
      If(
        deleteditems.itype Is Null,
        'XXX',
        If(
          deleteditems.itype = '',
          'XXX',
          deleteditems.itype
        )
      )
  ) ya_deleted On ya_deleted.homebranch = branchtypes.branchcode
  And ya_deleted.ccode = branchtypes.itemtype
Group By 
  branchtypes.branchname,
  branchtypes.description
Order By 
  branchtypes.branchname,
  'ITEM TYPE' 
) 

























