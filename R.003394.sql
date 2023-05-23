/*
R.003394

----------

Name: C1 Circulation by item details - collection code
Created by: George H Williams

----------

Group: Statistics
     2023 beginning of month statistics

Created on: 2020-12-31 17:40:07
Modified on: 2023-02-10 14:09:51
Date last run: 2023-05-01 00:40:01

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Circulation by item details spreadsheet report - circulation by collection code</p> 
<ul><li>Shows counts of check-outs and renewals in the previous calendar month</li> 
<li>At all Next Search Catalog libraries</li> 
<li>grouped and sorted by library name</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<p>SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."  If the shelving location is completely ambiguous, the circulation is counted in the CKO_RENEW_OTHER column.</p> 
<p></p> 
<ul> 
  <li>CKO_RENEW_ADULT includes items with these shelving locations:</li> 
  <ul> 
    <li>Adult</li> 
    <li>~Display - BALDWIN - Adult</li> 
    <li>~Display - LEAVENWRTH - Adult</li> 
    <li>~Display - PAOLA - Adult</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Adult" locations</li> 
  </ul> 
  <br /> 
  <li>CKO_RENEW_YA includes items with these shelving locations:</li> 
  <ul> 
    <li>Young adult</li> 
    <li>~Display - BALDWIN - Young Adult</li> 
    <li>~Display - LEAVENWRTH - Young adult</li> 
    <li>~Display - PAOLA - Young adult</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Young adult" locations</li> 
  </ul> 
  <br /> 
  <li>CKO_RENEW_CHILDRENS includes items with these shelving locations:</li> 
  <ul> 
    <li>Childrens</li> 
    <li>~Display - BALDWIN - Childrens</li> 
    <li>~Display - LEAVENWRTH - Children's</li> 
    <li>~Display - PAOLA - Children's</li> 
    <li>Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Childrens" locations</li> 
  </ul> 
  <br /> 
  <li>CKO_RENEW_OTHER includes items with these shelving locations:</li> 
  <ul> 
    <li>Cataloging</li> 
    <li>Processing Center</li> 
    <li>Any other situation where the recorded shelving location is "Recently returned" but the item's permanent location is ambiguous</li> 
    <li>Any items where the recorded shelving location is blank or unknown</li> 
  </ul> 
</ul> 
  <br /> 
<p></p> 
<p class="updated">This report and these notes updated on 2022.03.10</p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id= 3394">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #item #details #ccode #circulation_by_item_details</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



Select 
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
      Count(*) As CKO_RENEW
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
      Count(*) As CKO_RENEW
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
      Count(*) As CKO_RENEW
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
      Count(*) As CKO_RENEW
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
      Count(*) As CKO_RENEW
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
  COLLECTION_CODE

























