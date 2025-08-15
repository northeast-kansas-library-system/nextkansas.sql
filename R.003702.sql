/*
R.003702

----------

Name: GHW - Circulation by library and collection code
Created by: George Williams

----------

Group: -
     -

Created on: 2023-02-10 16:39:32
Modified on: 2023-10-16 21:54:35
Date last run: 2025-08-11 17:35:41

----------

Public: 0
Expiry: 300

----------

 
Circulation by item details spreadsheet report - circulation by collection code 
Shows counts of check-outs and renewals in the previous calendar month 
At all the library you specify 
grouped and sorted by library name and collection code 
 
Notes: 
 
An item's "shelving location" is based on the shelving location of the item at the time it was checked out *Unless the item had a "Recently returned" shelving location.*  This report falls back to the items' "Permanent shelving location" whenever the statistics data shows that the item's shelving location was "Recently returned."  If the shelving location is completely ambiguous, the circulation is counted in the 'Other items' column. 
 
 
  'Adult items' includes items with these shelving locations: 
   
    Adult 
    ~Display - BALDWIN - Adult 
    ~Display - LEAVENWRTH - Adult 
    ~Display - PAOLA - Adult 
    Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Adult" locations 
   
   
  'YA items' includes items with these shelving locations: 
   
    Young adult 
    ~Display - BALDWIN - Young Adult 
    ~Display - LEAVENWRTH - Young adult 
    ~Display - PAOLA - Young adult 
    Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Young adult" locations 
   
   
  'Juvenile items' includes items with these shelving locations: 
   
    Childrens 
    ~Display - BALDWIN - Childrens 
    ~Display - LEAVENWRTH - Children's 
    ~Display - PAOLA - Children's 
    Any situation where the location is recorded as "Recently returned" but the item's permanent location is one of these "Childrens" locations 
   
   
  'Other items' includes items with these shelving locations: 
   
    Cataloging 
    Processing Center 
    Any other situation where the recorded shelving location is "Recently returned" but the item's permanent location is ambiguous 
    Any items where the recorded shelving location is blank or unknown 
   
 
   
 
This report and these notes updated on 2023.02.10 
 
#monthly #statistics #item #details #ccode #circulation_by_item_details 
 
 

----------
*/



Select 
  branchccodes.branchname As 'Check out library', 
  branchccodes.lib As 'Collection code', 
  Coalesce(Sum(all_lm.CKO_RENEW), "0") As 'Checkouts and renewals - all items', 
  Coalesce(Sum(adult_lm.CKO_RENEW), "0") As 'Adult items', 
  Coalesce(Sum(ya_lm.CKO_RENEW), "0") As 'YA items', 
  Coalesce(Sum(childrens_lm.CKO_RENEW), "0") As 'Juvenile items', 
  Coalesce(Sum(other_lm.CKO_RENEW), "0") As 'Other items' 
From ( 
    Select branches.branchcode, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      branches.branchname 
    From branches, 
      authorised_values 
    Where authorised_values.category = 'CCODE' 
      And branches.branchcode Like &lt;&gt; 
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
  'Check out library', 
  'Collection code' 

























