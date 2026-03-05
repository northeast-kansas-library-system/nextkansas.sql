/*
R.003530

----------

Name: 0115 - 2024_99_f_item_count_item_type monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-07-26 11:25:35
Modified on: 2025-04-30 11:42:44
Date last run: 2026-01-01 01:15:03

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
 
  &lt;div&gt; 
 
    &lt;p&gt;Items and holdings statistics - item count by item type&lt;/p&gt; 
 
    &lt;ul&gt; 
      &lt;li&gt;Generates a count of items all items owned at the time the report is run plus items added and deleted in the previous calendar month&lt;/li&gt; 
      &lt;li&gt;columns are grouped by shelving locations&lt;/li&gt; 
      &lt;li&gt;at all system libraries&lt;/li&gt; 
      &lt;li&gt;grouped and sorted by item home library&lt;/li&gt; 
      &lt;li&gt;sorted by&lt;/li&gt; 
      &lt;li&gt;links&lt;/li&gt; 
    &lt;/ul&gt; 
 
    &lt;p&gt; 
      &lt;ins&gt;Notes:&lt;/ins&gt; 
    &lt;/p&gt; 
 
    &lt;p&gt; 
 
    &lt;/p&gt; 
 
    &lt;p&gt;Items with blank item types are counted as "(Unclassified)."&lt;/p&gt; 

    &lt;ul&gt; 
      &lt;li&gt;"ADULT" includes items with these permanent shelving locations:&lt;/li&gt; 

      &lt;ul&gt; 
        &lt;li&gt;Adult&lt;/li&gt; 
        &lt;li&gt;~Display - BALDWIN - Adult&lt;/li&gt; 
        &lt;li&gt;~Display - LEAVENWRTH - Adult&lt;/li&gt; 
        &lt;li&gt;~Display - PAOLA - Adult&lt;/li&gt; 
        &lt;li&gt;Cataloging&lt;/li&gt; 
        &lt;li&gt;Processing Center&lt;/li&gt; 
        &lt;li&gt;Any items where the permanent shelving location is blank or ambiguous&lt;/li&gt; 
      &lt;/ul&gt; 

      &lt;br /&gt; 

      &lt;li&gt;"YOUNG ADULT" includes items with these permanent shelving locations:&lt;/li&gt; 

      &lt;ul&gt; 
        &lt;li&gt;Young adult&lt;/li&gt; 
        &lt;li&gt;~Display - BALDWIN - Young Adult&lt;/li&gt; 
        &lt;li&gt;~Display - LEAVENWRTH - Young adult&lt;/li&gt; 
        &lt;li&gt;~Display - PAOLA - Young adult&lt;/li&gt; 
        &lt;li&gt;Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Young adult" locations&lt;/li&gt; 
      &lt;/ul&gt; 

      &lt;br /&gt; 

      &lt;li&gt;"JUVENILE" includes items with these permanent shelving locations:&lt;/li&gt;

      &lt;ul&gt; 
        &lt;li&gt;Childrens&lt;/li&gt; 
        &lt;li&gt;~Display - BALDWIN - Childrens&lt;/li&gt; 
        &lt;li&gt;~Display - LEAVENWRTH - Children's&lt;/li&gt; 
        &lt;li&gt;~Display - PAOLA - Children's&lt;/li&gt; 
        &lt;li&gt;Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Childrens" locations&lt;/li&gt; 
      &lt;/ul&gt; 

    &lt;/ul&gt; 
 
    &lt;p&gt; 
 
    &lt;/p&gt; 

    &lt;p class="updated"&gt;
      This report and these notes updated on 2022.03.10
    &lt;/p&gt; 

    &lt;p&gt;

    &lt;/p&gt;

    &lt;p&gt;
      This report cannot track changes made to existing records over time.  Therefore, if staff change the home library, location, or item type of an item, those changes will not be reflected in the additions or deletions columns.  This means that the numbers may look inconsistent from month to month if changes are made to item records.
    &lt;/p&gt; 
    
    &lt;p&gt;

    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;div id="reportInfoLinks"&gt; 
 
    &lt;p id="sql_quick_down"&gt; 
      &lt;a class= "btn btn-small" href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3530"&gt; 
        Download as a .csv file 
      &lt;/a&gt; 
    &lt;/p&gt; 
 
    &lt;p class="notetags" style="display: none;"&gt; 
      #statistics
      #monthlyStatistics 
      #itemCount 
      #itemType 
    &lt;/p&gt; 
 
    &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
 
  &lt;/div&gt;
 
&lt;/div&gt; 

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

























