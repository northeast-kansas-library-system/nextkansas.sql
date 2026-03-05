/*
R.003393

----------

Name: 0040 - 2024_99_c_circulation_item_type monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2020-12-31 17:36:03
Modified on: 2025-04-03 17:24:26
Date last run: 2026-01-06 15:39:20

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Circulation by item details spreadsheet report - circulation by item type&lt;/p&gt; 
&lt;ul&gt;&lt;li&gt;Shows counts of check-outs and renewals in the previous calendar month&lt;/li&gt; 
&lt;li&gt;At all Next Search Catalog libraries&lt;/li&gt; 
&lt;li&gt;grouped and sorted by library name&lt;/li&gt; 
&lt;/ul&gt;&lt;br /&gt; 
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p&gt;SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."  If the shelving location is completely ambiguous, the circulation is counted in the CKO_RENEW_OTHER column.&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;ul&gt; 
  &lt;li&gt;CKO_RENEW_ADULT includes items with these shelving locations:&lt;/li&gt; 
  &lt;ul&gt; 
    &lt;li&gt;Adult&lt;/li&gt; 
    &lt;li&gt;~Display - BALDWIN - Adult&lt;/li&gt; 
    &lt;li&gt;~Display - LEAVENWRTH - Adult&lt;/li&gt; 
    &lt;li&gt;~Display - PAOLA - Adult&lt;/li&gt; 
    &lt;li&gt;Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Adult" locations&lt;/li&gt; 
  &lt;/ul&gt; 
  &lt;br /&gt; 
  &lt;li&gt;CKO_RENEW_YA includes items with these shelving locations:&lt;/li&gt; 
  &lt;ul&gt; 
    &lt;li&gt;Young adult&lt;/li&gt; 
    &lt;li&gt;~Display - BALDWIN - Young Adult&lt;/li&gt; 
    &lt;li&gt;~Display - LEAVENWRTH - Young adult&lt;/li&gt; 
    &lt;li&gt;~Display - PAOLA - Young adult&lt;/li&gt; 
    &lt;li&gt;Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Young adult" locations&lt;/li&gt; 
  &lt;/ul&gt; 
  &lt;br /&gt; 
  &lt;li&gt;CKO_RENEW_CHILDRENS includes items with these shelving locations:&lt;/li&gt; 
  &lt;ul&gt; 
    &lt;li&gt;Childrens&lt;/li&gt; 
    &lt;li&gt;~Display - BALDWIN - Childrens&lt;/li&gt; 
    &lt;li&gt;~Display - LEAVENWRTH - Children's&lt;/li&gt; 
    &lt;li&gt;~Display - PAOLA - Children's&lt;/li&gt; 
    &lt;li&gt;Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Childrens" locations&lt;/li&gt; 
  &lt;/ul&gt; 
  &lt;br /&gt; 
  &lt;li&gt;CKO_RENEW_OTHER includes items with these shelving locations:&lt;/li&gt; 
  &lt;ul&gt; 
    &lt;li&gt;Cataloging&lt;/li&gt; 
    &lt;li&gt;Processing Center&lt;/li&gt; 
    &lt;li&gt;Any other situation where the recorded shelving location is "Recently returned" but the item's permanent location is ambiguous&lt;/li&gt; 
    &lt;li&gt;Any items where the recorded shelving location is blank or unknown&lt;/li&gt; 
  &lt;/ul&gt; 
&lt;/ul&gt; 
  &lt;br /&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p class="updated"&gt;This report and these notes updated on 2022.03.10&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id= 3393"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt; 
&lt;p class= "notetags" style="display: none;"&gt;#monthly #statistics #item #details #itype #circulation_by_item_details&lt;/p&gt; 
&lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
&lt;/div&gt; 

----------
*/



SELECT 
  branch_itype.branchname AS CHECK_OUT_LIBRARY, 
  branch_itype.description AS ITEM_TYPE, 
  Coalesce(Sum(statistics_all.CKO_REN), 0) AS CKO_REN_ALL, 
  Coalesce(Sum(statistics_adult.CKO_REN), 0) AS CKO_REN_ADULT, 
  Coalesce(Sum(statistics_ya.CKO_REN), 0) AS CKO_REN_YA, 
  Coalesce(Sum(statistics_child.CKO_REN), 0) AS CKO_REN_CHILD, 
  Coalesce(Sum(statistics_other.CKO_REN), 0) AS CKO_REN_OTHER 
FROM 
  ( 
    SELECT 
    branches.branchname, 
      itemtypes.description, 
      branches.branchcode, 
      itemtypes.itemtype 
    FROM branches, 
      itemtypes 
    WHERE branches.branchcode LIKE '%' 
  ) branch_itype 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(statistics.branch, "NEKLS") AS branch, 
      Coalesce(statistics.itemtype, "BOOK") AS itemtype, 
      Count(&ast;) AS CKO_REN 
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
      Count(&ast;) AS CKO_REN 
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
      Count(&ast;) AS CKO_REN 
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
      Count(&ast;) AS CKO_REN 
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
      Count(&ast;) AS CKO_REN 
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
GROUP BY branch_itype.branchname, 
  branch_itype.description 

























