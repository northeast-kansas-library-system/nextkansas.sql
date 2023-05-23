/*
R.003703

----------

Name: GHW - Circulation by library and item type
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-02-10 16:55:02
Modified on: 2023-02-10 16:55:02
Date last run: 2023-05-09 14:35:30

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Circulation by item details spreadsheet report - circulation by item type</p> 
<ul><li>Shows counts of check-outs and renewals in the previous calendar month</li> 
<li>At all the library you specify</li> 
<li>grouped and sorted by library name and item type</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<p>An item's "shelving location" is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."  If the shelving location is completely ambiguous, the circulation is counted in the 'Other items' column.</p> 
<p></p> 
<ul> 
  <li>'Adult items' includes items with these shelving locations:</li> 
  <ul> 
    <li>Adult</li> 
    <li>~Display - BALDWIN - Adult</li> 
    <li>~Display - LEAVENWRTH - Adult</li> 
    <li>~Display - PAOLA - Adult</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Adult" locations</li> 
  </ul> 
  <br /> 
  <li>'YA items' includes items with these shelving locations:</li> 
  <ul> 
    <li>Young adult</li> 
    <li>~Display - BALDWIN - Young Adult</li> 
    <li>~Display - LEAVENWRTH - Young adult</li> 
    <li>~Display - PAOLA - Young adult</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Young adult" locations</li> 
  </ul> 
  <br /> 
  <li>'Juvenile items' includes items with these shelving locations:</li> 
  <ul> 
    <li>Childrens</li> 
    <li>~Display - BALDWIN - Childrens</li> 
    <li>~Display - LEAVENWRTH - Children's</li> 
    <li>~Display - PAOLA - Children's</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Childrens" locations</li> 
  </ul> 
  <br /> 
  <li>'Other items' includes items with these shelving locations:</li> 
  <ul> 
    <li>Cataloging</li> 
    <li>Processing Center</li> 
    <li>Any other situation where the recorded shelving location is "Recently returned" but the item's permanent location is ambiguous</li> 
    <li>Any items where the recorded shelving location is blank or unknown</li> 
  </ul> 
</ul> 
  <br /> 
<p></p> 
<p class="updated">This report and these notes updated on 2023.02.10</p> 
<p></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #item #details #itype #circulation_by_item_details</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



SELECT 
  branch_itype.branchname AS 'Check out library', 
  branch_itype.description AS 'Item type', 
  Coalesce(Sum(statistics_all.CKO_REN), 0) AS 'Checkouts and renewals - all items', 
  Coalesce(Sum(statistics_adult.CKO_REN), 0) AS 'Adult items', 
  Coalesce(Sum(statistics_ya.CKO_REN), 0) AS 'YA items', 
  Coalesce(Sum(statistics_child.CKO_REN), 0) AS 'Juvenile items', 
  Coalesce(Sum(statistics_other.CKO_REN), 0) AS 'Other items' 
FROM 
  ( 
    SELECT 
    branches.branchname, 
      itemtypes.description, 
      branches.branchcode, 
      itemtypes.itemtype 
    FROM branches, 
      itemtypes 
    WHERE branches.branchcode LIKE <<Choose your library|ZBRAN>> 
  ) branch_itype 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM statistics 
    WHERE ( 
        statistics.type = 'issue' 
        OR statistics.type = 'renew' 
      ) 
      AND Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
      AND Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
    ORDER BY branch, 
      itemtype 
  ) statistics_all ON statistics_all.branch = branch_itype.branchcode 
  AND statistics_all.itemtype = branch_itype.itemtype 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM statistics 
      LEFT JOIN items ON items.itemnumber = statistics.itemnumber 
    WHERE ( 
        statistics.type = 'issue' 
        OR statistics.type = 'renew' 
      ) 
      AND Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
      AND Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) 
      AND ( 
        If( 
          Coalesce(statistics.location, "PROC") = "CART", 
          Coalesce(items.permanent_location, "PROC"), 
          Coalesce(statistics.location, "PROC") 
        ) LIKE "%AD%" 
        OR 
        If( 
          Coalesce(statistics.location, "PROC") = "CART", 
          Coalesce(items.permanent_location, "PROC"), 
          Coalesce(statistics.location, "PROC") 
        ) LIKE "%ADULT%" 
      ) 
    GROUP BY Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
  ) statistics_adult 
  ON statistics_adult.branch = branch_itype.branchcode 
  AND statistics_adult.itemtype = branch_itype.itemtype 
  LEFT JOIN 
  ( 
    SELECT Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM statistics 
      LEFT JOIN items ON items.itemnumber = statistics.itemnumber 
    WHERE ( 
        statistics.type = 'issue' 
        OR statistics.type = 'renew' 
      ) 
      AND Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
      AND Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) 
      AND If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) LIKE "%YA%" 
    GROUP BY Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
  ) statistics_ya ON statistics_ya.branch = branch_itype.branchcode 
  AND statistics_ya.itemtype = branch_itype.itemtype 
  LEFT JOIN 
  ( 
    SELECT 
    Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM statistics 
      LEFT JOIN items ON items.itemnumber = statistics.itemnumber 
    WHERE ( 
        statistics.type = 'issue' 
        OR statistics.type = 'renew' 
      ) 
      AND Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
      AND Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) 
      AND ( 
        If( 
          Coalesce(statistics.location, "PROC") = "CART", 
          Coalesce(items.permanent_location, "PROC"), 
          Coalesce(statistics.location, "PROC") 
        ) LIKE "%JU%" 
        OR If( 
          Coalesce(statistics.location, "PROC") = "CART", 
          Coalesce(items.permanent_location, "PROC"), 
          Coalesce(statistics.location, "PROC") 
        ) LIKE "%CHILD%" 
      ) 
    GROUP BY Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
  ) statistics_child 
  ON statistics_child.branch = branch_itype.branchcode 
  AND statistics_child.itemtype = branch_itype.itemtype 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(*) AS CKO_REN 
    FROM statistics 
      LEFT JOIN items ON items.itemnumber = statistics.itemnumber 
    WHERE ( 
        statistics.type = 'issue' 
        OR statistics.type = 'renew' 
      ) 
      AND Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
      AND Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) 
      AND If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%AD%" 
      AND If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%ADULT%" 
      AND If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%YA%" 
      AND If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%JU%" 
      AND If( 
        Coalesce(statistics.location, "PROC") = "CART", 
        Coalesce(items.permanent_location, "PROC"), 
        Coalesce(statistics.location, "PROC") 
      ) NOT LIKE "%CHILD%" 
    GROUP BY Coalesce(statistics.branch, "NEKLS"), 
      Coalesce(statistics.itemtype, "BOOK") 
  ) statistics_other 
  ON statistics_other.branch = branch_itype.branchcode 
  AND statistics_other.itemtype = branch_itype.itemtype 
GROUP BY 
  branch_itype.branchname, 
  branch_itype.description 
ORDER BY 
  branch_itype.branchname, 
  branch_itype.description 

























