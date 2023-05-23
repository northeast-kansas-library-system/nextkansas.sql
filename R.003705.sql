/*
R.003705

----------

Name: GHW - Item count by item home library and collection code
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-02-10 17:17:17
Modified on: 2023-02-10 17:22:31
Date last run: 2023-05-05 09:56:58

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Gives a count of how many items are at the selected library based on collection code and Adult/Juvenile/YA permanent shelving locations.</p>
<ul><li>Shows count at the time the report is run</li>
<li>for libraries with the home library you specify</li>
<li>grouped and sorted by item home library and collection code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Non-standard shelving locations are counted as "Adult" locations.</p>
<p>Items with blank collection codes are counted as "(Unclassified)."</p>
<p></p>
<p>This report cannot track changes made to existing records over time.  Therefore, if staff change the home library, location, or collection code of an item, those changes will not be reflected in the additions or deletions columns.  This means that the numbers may look inconsistent from month to month if changes are made to existing item records.</p>
</div>

----------
*/



Select 
  branchtypes.branchname AS 'Home library',
  branchtypes.lib As 'Collection code',
  Sum(itemss.Count_itemnumber) As 'Total items',
  Sum(adultitems.Count_itemnumber) As 'Total adult items',
  Sum(yaitems.Count_itemnumber) As 'Total YA items',
  Sum(juvenileitems.Count_itemnumber) As 'Total juvenile items',
  Sum(items_added.Count_itemnumber) As 'Total items added',
  Sum(adult_added.Count_itemnumber) As 'Adult items added',
  Sum(ya_added.Count_itemnumber) As 'YA items added',
  Sum(juvenile_added.Count_itemnumber) As 'Juvenile items added',
  Sum(items_deleted.Count_itemnumber) As 'Total items deleted',
  Sum(adult_deleted.Count_itemnumber) As 'Adult items deleted',
  Sum(ya_deleted.Count_itemnumber) As 'YA items deleted',
  Sum(juvenile_deleted.Count_itemnumber) As 'Juvenile items added'
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
    Where branches.branchcode Like <<Choose your library|ZBRAN>>
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
      And (deleteditems.permanent_location Like "%JU%" 
      OR deleteditems.permanent_location Like "%CHILD%")
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
  branchtypes.branchname, 
  branchtypes.lib

























