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
Date last run: 2025-10-02 00:35:02

----------

Public: 0
Expiry: 300

----------

 
Circulation by item details spreadsheet report - circulation by collection code 
Shows counts of check-outs and renewals in the previous calendar month 
At all Next Search Catalog libraries 
grouped and sorted by library name 
 
Notes: 
 
SHELVING_LOCATION is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."  If the shelving location is completely ambiguous, the circulation is counted in the CKO_RENEW_OTHER column. 
 
 
  CKO_RENEW_ADULT includes items with these shelving locations: 
   
    Adult 
    ~Display - BALDWIN - Adult 
    ~Display - LEAVENWRTH - Adult 
    ~Display - PAOLA - Adult 
    Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Adult" locations 
   
   
  CKO_RENEW_YA includes items with these shelving locations: 
   
    Young adult 
    ~Display - BALDWIN - Young Adult 
    ~Display - LEAVENWRTH - Young adult 
    ~Display - PAOLA - Young adult 
    Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Young adult" locations 
   
   
  CKO_RENEW_CHILDRENS includes items with these shelving locations: 
   
    Childrens 
    ~Display - BALDWIN - Childrens 
    ~Display - LEAVENWRTH - Children's 
    ~Display - PAOLA - Children's 
    Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Childrens" locations 
   
   
  CKO_RENEW_OTHER includes items with these shelving locations: 
   
    Cataloging 
    Processing Center 
    Any other situation where the recorded shelving location is "Recently returned" but the item's permanent location is ambiguous 
    Any items where the recorded shelving location is blank or unknown 
   
 
   
 
This report and these notes updated on 2022.03.10 
 
Click here to download as a csv file 
#monthly #statistics #item #details #ccode #circulation_by_item_details 
 
 

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
  COLLECTION_CODE )

























