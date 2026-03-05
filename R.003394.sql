/*
R.003394

----------

Name: 0035 - 2024_99_c_circulation_collection_code monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2020-12-31 17:40:07
Modified on: 2025-04-30 10:23:25
Date last run: 2026-01-06 15:39:28

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Circulation by item details spreadsheet report - circulation by collection code&lt;/p&gt; 
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
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id= 3394"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt; 
&lt;p class= "notetags" style="display: none;"&gt;#monthly #statistics #item #details #ccode #circulation_by_item_details&lt;/p&gt; 
&lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
&lt;/div&gt; 

----------
*/



SELECT 
  'CHECK_OUT_LIBRARY' AS 'CHECK_OUT_LIBRARY',  
  'COLLECTION_CODE' AS 'COLLECTION_CODE',  
  'CKO_RENW_ALL' AS 'CKO_RENW_ALL',  
  'CKO_RENEW_ADULT' AS 'CKO_RENEW_ADULT',  
  'CKO_RENEW_YA' AS 'CKO_RENEW_YA',  
  'CKO_RENEW_CHILDRENS' AS 'CKO_RENEW_CHILDRENS',  
  'CKO_RENEW_OTHER' AS 'CKO_RENEW_OTHER'
UNION 
(Select 
  branchccodes.branchname As CHECK_OUT_LIBRARY,
  branchccodes.lib As COLLECTION_CODE,
  Coalesce(Sum(all_lm.CKO_RENEW), "0") As CKO_RENW_ALL,
  Coalesce(Sum(adult_lm.CKO_RENEW), "0") As CKO_RENEW_ADULT,
  Coalesce(Sum(ya_lm.CKO_RENEW), "0") As CKO_RENEW_YA,
  Coalesce(Sum(childrens_lm.CKO_RENEW), "0") As CKO_RENEW_CHILDRENS,
  Coalesce(Sum(other_lm.CKO_RENEW), "0") As CKO_RENEW_OTHER
From (
    Select branches.branchcode,
      authorised_values.authorised_value,
      authorised_values.lib,
      branches.branchname
    From branches,
      authorised_values
    Where authorised_values.category = 'CCODE'
      And branches.branchcode Like "%"
    Order By 
      branches.branchcode,
      authorised_values.lib
  ) branchccodes
  Left Join (
    Select 
      If(
        statistics.branch Is Null,
        "NEKLS",
        statistics.branch
      ) As branch,
      If(
        statistics.ccode Is Null,
        "XXX",
        statistics.ccode
      ) As CCODE,
      Count(&ast;) As CKO_RENEW
    From 
      statistics
    Where 
      Month(statistics.datetime) = Month(Now() - Interval 1 Month)
      And Year(statistics.datetime) = Year(Now() - Interval 1 Month)
      And (
        statistics.type = 'issue'
        Or statistics.type = 'renew'
      )
    Group By 
      If(
        statistics.branch Is Null,
        "NEKLS",
        statistics.branch
      ),
      If(
        statistics.ccode Is Null,
        "XXX",
        statistics.ccode
      )
  ) all_lm On all_lm.branch = branchccodes.branchcode
  And all_lm.CCODE = branchccodes.authorised_value
  Left Join (
    Select If(
        statistics.branch Is Null,
        "NEKLS",
        statistics.branch
      ) As branch,
      If(
        statistics.ccode Is Null,
        "XXX",
        statistics.ccode
      ) As CCODE,
      Count(&ast;) As CKO_RENEW
    From statistics
      Left Join items On items.itemnumber = statistics.itemnumber
    Where (
        statistics.type = 'issue'
        Or statistics.type = 'renew'
      )
      And Year(statistics.datetime) = Year(Now() - Interval 1 Month)
      And Month(statistics.datetime) = Month(Now() - Interval 1 Month)
      And If(
        Coalesce(statistics.location, "PROC") = "CART",
        Coalesce(items.permanent_location, "PROC"),
        Coalesce(statistics.location, "PROC")
      ) Like "%AD%"
    Group By If(
        statistics.branch Is Null,
        "NEKLS",
        statistics.branch
      ),
      If(
        statistics.ccode Is Null,
        "XXX",
        statistics.ccode
      )
  ) adult_lm On adult_lm.branch = branchccodes.branchcode
  And adult_lm.CCODE = branchccodes.authorised_value
  Left Join (
    Select 
      If(
        statistics.branch Is Null,
        "NEKLS",
        statistics.branch
      ) As branch,
      If(
        statistics.ccode Is Null,
        "XXX",
        statistics.ccode
      ) As CCODE,
      Count(&ast;) As CKO_RENEW
    From statistics
      Left Join items On items.itemnumber = statistics.itemnumber
    Where 
      (
        statistics.type = 'issue'
        Or statistics.type = 'renew'
      )
      And Year(statistics.datetime) = Year(Now() - Interval 1 Month)
      And Month(statistics.datetime) = Month(Now() - Interval 1 Month)
      And If(
        Coalesce(statistics.location, "PROC") = "CART",
        Coalesce(items.permanent_location, "PROC"),
        Coalesce(statistics.location, "PROC")
      ) Like "%YA%"
    Group By 
      If(
        statistics.branch Is Null,
        "NEKLS",
        statistics.branch
      ),
      If(
        statistics.ccode Is Null,
        "XXX",
        statistics.ccode
      )
  ) ya_lm On ya_lm.branch = branchccodes.branchcode
  And ya_lm.CCODE = branchccodes.authorised_value
  Left Join (
    Select 
      If(
        statistics.branch Is Null,
        "NEKLS",
        statistics.branch
      ) As branch,
      If(
        statistics.ccode Is Null,
        "XXX",
        statistics.ccode
      ) As CCODE,
      Count(&ast;) As CKO_RENEW
    From statistics
      Left Join items On items.itemnumber = statistics.itemnumber
    Where 
      (
        statistics.type = 'issue'
        Or statistics.type = 'renew'
      )
      And Year(statistics.datetime) = Year(Now() - Interval 1 Month)
      And Month(statistics.datetime) = Month(Now() - Interval 1 Month)
      And (
        If(
          Coalesce(statistics.location, "PROC") = "CART",
          Coalesce(items.permanent_location, "PROC"),
          Coalesce(statistics.location, "PROC")
        ) Like "%CHILD%"
        Or If(
          Coalesce(statistics.location, "PROC") = "CART",
          Coalesce(items.permanent_location, "PROC"),
          Coalesce(statistics.location, "PROC")
        ) Like "%JU%"
      )
    Group By If(
        statistics.branch Is Null,
        "NEKLS",
        statistics.branch
      ),
      If(
        statistics.ccode Is Null,
        "XXX",
        statistics.ccode
      )
  ) childrens_lm On childrens_lm.branch = branchccodes.branchcode
  And childrens_lm.CCODE = branchccodes.authorised_value
  Left Join (
    Select 
      If(
        statistics.branch Is Null,
        "NEKLS",
        statistics.branch
      ) As branch,
      If(
        statistics.ccode Is Null,
        "XXX",
        statistics.ccode
      ) As CCODE,
      Count(&ast;) As CKO_RENEW
    From statistics
      Left Join items On items.itemnumber = statistics.itemnumber
    Where 
      (
        statistics.type = 'issue'
        Or statistics.type = 'renew'
      )
      And Year(statistics.datetime) = Year(Now() - Interval 1 Month)
      And Month(statistics.datetime) = Month(Now() - Interval 1 Month)
      And If(
        Coalesce(statistics.location, "PROC") = "CART",
        Coalesce(items.permanent_location, "PROC"),
        Coalesce(statistics.location, "PROC")
      ) Not Like "%AD%"
      And If(
        Coalesce(statistics.location, "PROC") = "CART",
        Coalesce(items.permanent_location, "PROC"),
        Coalesce(statistics.location, "PROC")
      ) Not Like "%YA%"
      And If(
        Coalesce(statistics.location, "PROC") = "CART",
        Coalesce(items.permanent_location, "PROC"),
        Coalesce(statistics.location, "PROC")
      ) Not Like "%CHILD%"
      And If(
        Coalesce(statistics.location, "PROC") = "CART",
        Coalesce(items.permanent_location, "PROC"),
        Coalesce(statistics.location, "PROC")
      ) Not Like "%JU%"
    Group By 
      If(
        statistics.branch Is Null,
        "NEKLS",
        statistics.branch
      ),
      If(
        statistics.ccode Is Null,
        "XXX",
        statistics.ccode
      )
  ) other_lm On other_lm.branch = branchccodes.branchcode
  And other_lm.CCODE = branchccodes.authorised_value
Group By 
  branchccodes.branchname,
  branchccodes.lib
Order By 
  CHECK_OUT_LIBRARY,
  COLLECTION_CODE )

























