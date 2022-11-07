/*
R.003530

----------

Name: GHW - F2 Items and holdings statistics - item count by item type - Next Search Catalog
Created by: George H Williams

----------

Group: Statistics
     2022 beginning of month statistics

Created on: 2021-07-26 11:25:35
Modified on: 2022-06-09 16:16:29
Date last run: 2022-11-01 01:05:01

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Items and holdings statistics - item count by item type</p> 
<ul><li>Generates a count of items all items owned at the time the report is run plus items added and deleted in the previous calendar month</li> 
<li>columns are grouped by shelving locations</li> 
<li>at all system libraries</li> 
<li>grouped and sorted by item home library</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
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
 <br /> 
<p class="updated">This report and these notes updated on 2022.03.10</p> 
<p></p> 
<p>This report cannot track changes made to existing records over time.  Therefore, if staff change the home library, location, or item type of an item, those changes will not be reflected in the additions or deletions columns.  This means that the numbers may look inconsistent from month to month if changes are made to item records.</p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3530">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #item #count #item type</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



SELECT 
  branchtypes.branchname, 
  branchtypes.description AS 'ITEM TYPE', 
  Sum(itemss.Count_itemnumber) AS 'TOTAL ITEMS', 
  Sum(adultitems.Count_itemnumber) AS 'ADULT ITEMS', 
  Sum(yaitems.Count_itemnumber) AS 'YOUNG ADULT ITEMS', 
  Sum(juvenileitems.Count_itemnumber) AS 'JUVENILE ITEMS', 
  Sum(items_added.Count_itemnumber) AS 'TOTAL ADDED LM', 
  Sum(adult_added.Count_itemnumber) AS 'ADULT ADDED LM', 
  Sum(ya_added.Count_itemnumber) AS 'YOUNG ADULT ADDED LM', 
  Sum(juvenile_added.Count_itemnumber) AS 'JUVENILE ADDED LM', 
  Sum(items_deleted.Count_itemnumber) AS 'TOTAL DELETED LM', 
  Sum(adult_deleted.Count_itemnumber) AS 'ADULT DELETED LM', 
  Sum(ya_deleted.Count_itemnumber) AS 'YOUNG ADULT DELETED LM', 
  Sum(juvenile_deleted.Count_itemnumber) AS 'JUVENILE DELETED LM' 
FROM 
    (SELECT 
      branches.branchcode, 
      branches.branchname, 
      itemtypes.itemtype, 
      itemtypes.description 
    FROM 
      itemtypes, 
      branches 
    WHERE 
      branches.branchcode LIKE '%' 
    ) branchtypes 
  LEFT JOIN 
    (SELECT 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) AS itype, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    GROUP BY 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) 
    ) itemss 
  ON itemss.homebranch = branchtypes.branchcode AND 
    itemss.itype = branchtypes.itemtype LEFT JOIN 
    (SELECT 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) AS itype, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    WHERE 
      (items.permanent_location LIKE '%ADULT%' OR 
        items.permanent_location = 'CART' OR 
        items.permanent_location = 'CATALOGING' OR 
        items.permanent_location = 'PROC' OR 
        items.permanent_location IS NULL) 
    GROUP BY 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) 
    ) adultitems 
  ON adultitems.homebranch = branchtypes.branchcode AND 
    adultitems.itype = branchtypes.itemtype LEFT JOIN 
    (SELECT 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) AS itype, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    WHERE 
      items.permanent_location LIKE '%CHILD%' 
    GROUP BY 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) 
    ) juvenileitems 
  ON juvenileitems.homebranch = branchtypes.branchcode AND 
    juvenileitems.itype = branchtypes.itemtype LEFT JOIN 
    (SELECT 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) AS itype, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    WHERE 
      items.permanent_location LIKE '%YA%' 
    GROUP BY 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) 
    ) yaitems 
  ON yaitems.homebranch = branchtypes.branchcode AND 
    yaitems.itype = branchtypes.itemtype LEFT JOIN 
    (SELECT 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) AS itype, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    WHERE 
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) 
    ) items_added 
  ON items_added.homebranch = branchtypes.branchcode AND 
    items_added.itype = branchtypes.itemtype LEFT JOIN 
    (SELECT 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) AS itype, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    WHERE 
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND 
      (items.permanent_location LIKE '%ADULT%' OR 
        items.permanent_location = 'CART' OR 
        items.permanent_location = 'CATALOGING' OR 
        items.permanent_location = 'PROC' OR 
        items.permanent_location IS NULL) 
    GROUP BY 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) 
    ) adult_added 
  ON adult_added.homebranch = branchtypes.branchcode AND 
    adult_added.itype = branchtypes.itemtype LEFT JOIN 
    (SELECT 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) AS itype, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    WHERE 
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND 
      items.permanent_location LIKE '%CHILD%' 
    GROUP BY 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) 
    ) juvenile_added 
  ON juvenile_added.homebranch = branchtypes.branchcode AND 
    juvenile_added.itype = branchtypes.itemtype LEFT JOIN 
    (SELECT 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) AS itype, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    WHERE 
      Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND 
      items.permanent_location LIKE '%YA%' 
    GROUP BY 
      items.homebranch, 
      If( 
        items.itype IS NULL, 
        'XXX', 
        items.itype 
      ) 
    ) ya_added 
  ON ya_added.homebranch = branchtypes.branchcode AND 
    ya_added.itype = branchtypes.itemtype LEFT JOIN 
    (SELECT 
      deleteditems.homebranch, 
      If( 
        deleteditems.itype IS NULL, 
        'XXX', 
        If( 
          deleteditems.itype = '', 
          'XXX', 
          deleteditems.itype 
        ) 
      ) AS ccode, 
      Count(deleteditems.itemnumber) AS Count_itemnumber 
    FROM 
      deleteditems 
    WHERE 
      Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      deleteditems.homebranch, 
      If( 
        deleteditems.itype IS NULL, 
        'XXX', 
        If( 
          deleteditems.itype = '', 
          'XXX', 
          deleteditems.itype 
        ) 
      ) 
    ) items_deleted 
  ON items_deleted.homebranch = branchtypes.branchcode AND 
    items_deleted.ccode = branchtypes.itemtype LEFT JOIN 
    (SELECT 
      deleteditems.homebranch, 
      If( 
        deleteditems.itype IS NULL, 
        'XXX', 
        If( 
          deleteditems.itype = '', 
          'XXX', 
          deleteditems.itype 
        ) 
      ) AS ccode, 
      Count(deleteditems.itemnumber) AS Count_itemnumber 
    FROM 
      deleteditems 
    WHERE 
      Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND 
      (deleteditems.permanent_location LIKE '%ADULT%' OR 
        deleteditems.permanent_location = 'CART' OR 
        deleteditems.permanent_location = 'CATALOGING' OR 
        deleteditems.permanent_location = 'PROC' OR 
        deleteditems.permanent_location IS NULL) 
    GROUP BY 
      deleteditems.homebranch, 
      If( 
        deleteditems.itype IS NULL, 
        'XXX', 
        If( 
          deleteditems.itype = '', 
          'XXX', 
          deleteditems.itype 
        ) 
      ) 
    ) adult_deleted 
  ON adult_deleted.homebranch = branchtypes.branchcode AND 
    adult_deleted.ccode = branchtypes.itemtype LEFT JOIN 
    (SELECT 
      deleteditems.homebranch, 
      If( 
        deleteditems.itype IS NULL, 
        'XXX', 
        If( 
          deleteditems.itype = '', 
          'XXX', 
          deleteditems.itype 
        ) 
      ) AS ccode, 
      Count(deleteditems.itemnumber) AS Count_itemnumber 
    FROM 
      deleteditems 
    WHERE 
      Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND 
      deleteditems.permanent_location LIKE '%CHILD%' 
    GROUP BY 
      deleteditems.homebranch, 
      If( 
        deleteditems.itype IS NULL, 
        'XXX', 
        If( 
          deleteditems.itype = '', 
          'XXX', 
          deleteditems.itype 
        ) 
      ) 
    ) juvenile_deleted 
  ON juvenile_deleted.homebranch = branchtypes.branchcode AND 
    juvenile_deleted.ccode = branchtypes.itemtype LEFT JOIN 
    (SELECT 
      deleteditems.homebranch, 
      If( 
        deleteditems.itype IS NULL, 
        'XXX', 
        If( 
          deleteditems.itype = '', 
          'XXX', 
          deleteditems.itype 
        ) 
      ) AS ccode, 
      Count(deleteditems.itemnumber) AS Count_itemnumber 
    FROM 
      deleteditems 
    WHERE 
      Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) AND 
      deleteditems.permanent_location LIKE '%YA%' 
    GROUP BY 
      deleteditems.homebranch, 
      If( 
        deleteditems.itype IS NULL, 
        'XXX', 
        If( 
          deleteditems.itype = '', 
          'XXX', 
          deleteditems.itype 
        ) 
      ) 
    ) ya_deleted 
  ON ya_deleted.homebranch = branchtypes.branchcode AND 
    ya_deleted.ccode = branchtypes.itemtype 
GROUP BY 
  branchtypes.branchname, 
  branchtypes.description 
ORDER BY 
  branchtypes.branchname, 
  'ITEM TYPE' 

























