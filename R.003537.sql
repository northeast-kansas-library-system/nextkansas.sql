/*
R.003537

----------

Name: F1 Items and holdings statistics - item count by collection code
Created by: George H Williams

----------

Group: Statistics
     2023 beginning of month statistics

Created on: 2021-07-29 16:35:30
Modified on: 2023-02-10 14:10:49
Date last run: 2023-03-01 01:10:01

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Gives a count of how many items are at the selected library based on collection code and Adult/Juvenile/YA permanent shelving locations.</p>
<ul><li>Shows count at the time the report is run</li>
<li>for all items system-wide</li>
<li>grouped and sorted by item home library and collection code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Non-standard shelving locations are counted as "Adult" locations.</p>
<p>Items with blank collection codes are counted as "(Unclassified)."</p>
<p></p>
<p>This report cannot track changes made to existing records over time.  Therefore, if staff change the home library, location, or collection code of an item, those changes will not be reflected in the additions or deletions columns.  This means that the numbers may look inconsistent from month to month if changes are made to item records.</p>
</div>

----------
*/



Select 
  branchtypes.branchname,
  branchtypes.lib As `"COLLECTION CODE"`,
  Sum(itemss.Count_itemnumber) As "TOTAL ITEMS",
  Sum(adultitems.Count_itemnumber) As "ADULT ITEMS",
  Sum(yaitems.Count_itemnumber) As "YOUNG ADULT ITEMS",
  Sum(juvenileitems.Count_itemnumber) As "JUVENILE ITEMS",
  Sum(items_added.Count_itemnumber) As "TOTAL ADDED LM",
  Sum(adult_added.Count_itemnumber) As "ADULT ADDED LM",
  Sum(ya_added.Count_itemnumber) As "YOUNG ADULT ADDED LM",
  Sum(juvenile_added.Count_itemnumber) As "JUVENILE ADDED LM",
  Sum(items_deleted.Count_itemnumber) As "TOTAL DELETED LM",
  Sum(adult_deleted.Count_itemnumber) As "ADULT DELETED LM",
  Sum(ya_deleted.Count_itemnumber) As "YOUNG ADULT DELETED LM",
  Sum(juvenile_deleted.Count_itemnumber) As "JUVENILE DELETED LM"
From (
    Select 
      branches.branchcode,
      branches.branchname,
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From branches,
      authorised_values
    Where branches.branchcode Like '%'
      And authorised_values.category = 'CCODE'
  ) branchtypes
  Left Join (
    Select 
      items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode) As ccode,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Group By items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode)
  ) itemss On itemss.homebranch = branchtypes.branchcode
  And itemss.ccode = branchtypes.authorised_value
  Left Join (
    Select 
      items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode) As ccode,
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
      If(items.ccode Is Null, "XXX", items.ccode)
  ) adultitems On adultitems.homebranch = branchtypes.branchcode
  And adultitems.ccode = branchtypes.authorised_value
  Left Join (
    Select 
      items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode) As ccode,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Where items.permanent_location Like "%JU%"
    Group By items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode)
  ) juvenileitems On juvenileitems.homebranch = branchtypes.branchcode
  And juvenileitems.ccode = branchtypes.authorised_value
  Left Join (
    Select 
      items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode) As ccode,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Where items.permanent_location Like "%YA%"
    Group By items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode)
  ) yaitems On yaitems.homebranch = branchtypes.branchcode
  And yaitems.ccode = branchtypes.authorised_value
  Left Join (
    Select 
      items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode) As ccode,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Where Month(items.dateaccessioned) = Month(Now() - Interval 1 Month)
      And Year(items.dateaccessioned) = Year(Now() - Interval 1 Month)
    Group By items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode)
  ) items_added On items_added.homebranch = branchtypes.branchcode
  And items_added.ccode = branchtypes.authorised_value
  Left Join (
    Select 
      items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode) As ccode,
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
      If(items.ccode Is Null, "XXX", items.ccode)
  ) adult_added On adult_added.homebranch = branchtypes.branchcode
  And adult_added.ccode = branchtypes.authorised_value
  Left Join (
    Select 
      items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode) As ccode,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Where Month(items.dateaccessioned) = Month(Now() - Interval 1 Month)
      And Year(items.dateaccessioned) = Year(Now() - Interval 1 Month)
      And items.permanent_location Like "%JU%"
    Group By items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode)
  ) juvenile_added On juvenile_added.homebranch = branchtypes.branchcode
  And juvenile_added.ccode = branchtypes.authorised_value
  Left Join (
    Select 
      items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode) As ccode,
      Count(items.itemnumber) As Count_itemnumber
    From items
    Where Month(items.dateaccessioned) = Month(Now() - Interval 1 Month)
      And Year(items.dateaccessioned) = Year(Now() - Interval 1 Month)
      And items.permanent_location Like "%YA%"
    Group By items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode)
  ) ya_added On ya_added.homebranch = branchtypes.branchcode
  And ya_added.ccode = branchtypes.authorised_value
  Left Join (
    Select 
      deleteditems.homebranch,
      If(
        deleteditems.ccode Is Null,
        "XXX",
        If(
          deleteditems.ccode = "",
          "XXX",
          deleteditems.ccode
        )
      ) As ccode,
      Count(deleteditems.itemnumber) As Count_itemnumber
    From deleteditems
    Where Month(deleteditems.timestamp) = Month(Now() - Interval 1 Month)
      And Year(deleteditems.timestamp) = Year(Now() - Interval 1 Month)
    Group By deleteditems.homebranch,
      If(
        deleteditems.ccode Is Null,
        "XXX",
        If(
          deleteditems.ccode = "",
          "XXX",
          deleteditems.ccode
        )
      )
  ) items_deleted On items_deleted.homebranch = branchtypes.branchcode
  And items_deleted.ccode = branchtypes.authorised_value
  Left Join (
    Select 
      deleteditems.homebranch,
      If(
        deleteditems.ccode Is Null,
        "XXX",
        If(
          deleteditems.ccode = "",
          "XXX",
          deleteditems.ccode
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
        deleteditems.ccode Is Null,
        "XXX",
        If(
          deleteditems.ccode = "",
          "XXX",
          deleteditems.ccode
        )
      )
  ) adult_deleted On adult_deleted.homebranch = branchtypes.branchcode
  And adult_deleted.ccode = branchtypes.authorised_value
  Left Join (
    Select  
      deleteditems.homebranch,
      If(
        deleteditems.ccode Is Null,
        "XXX",
        If(
          deleteditems.ccode = "",
          "XXX",
          deleteditems.ccode
        )
      ) As ccode,
      Count(deleteditems.itemnumber) As Count_itemnumber
    From deleteditems
    Where Month(deleteditems.dateaccessioned) = Month(Now() - Interval 1 Month)
      And Year(deleteditems.dateaccessioned) = Year(Now() - Interval 1 Month)
      And deleteditems.permanent_location Like "%JU%"
    Group By deleteditems.homebranch,
      If(
        deleteditems.ccode Is Null,
        "XXX",
        If(
          deleteditems.ccode = "",
          "XXX",
          deleteditems.ccode
        )
      )
  ) juvenile_deleted On juvenile_deleted.homebranch = branchtypes.branchcode
  And juvenile_deleted.ccode = branchtypes.authorised_value
  Left Join (
    Select 
      deleteditems.homebranch,
      If(
        deleteditems.ccode Is Null,
        "XXX",
        If(
          deleteditems.ccode = "",
          "XXX",
          deleteditems.ccode
        )
      ) As ccode,
      Count(deleteditems.itemnumber) As Count_itemnumber
    From deleteditems
    Where Month(deleteditems.dateaccessioned) = Month(Now() - Interval 1 Month)
      And Year(deleteditems.dateaccessioned) = Year(Now() - Interval 1 Month)
      And deleteditems.permanent_location Like "%YA%"
    Group By deleteditems.homebranch,
      If(
        deleteditems.ccode Is Null,
        "XXX",
        If(
          deleteditems.ccode = "",
          "XXX",
          deleteditems.ccode
        )
      )
  ) ya_deleted On ya_deleted.homebranch = branchtypes.branchcode
  And ya_deleted.ccode = branchtypes.authorised_value
Group By 
  branchtypes.branchname,
  branchtypes.lib
Order By 
  branchtypes.branchname

























