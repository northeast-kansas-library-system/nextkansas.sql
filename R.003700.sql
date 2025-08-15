/*
R.003700

----------

Name: GHW - Statistics - Local use by library and collection code
Created by: George Williams

----------

Group: Statistics
     -

Created on: 2023-02-01 12:28:31
Modified on: 2024-03-01 16:34:25
Date last run: 2024-12-05 10:01:53

----------

Public: 0
Expiry: 300

----------


 
   
 
    Counts "localuse" checkouts by item type 
 
     
      during the previous calendar month 
      at the library you specify 
      grouped and sorted by library and item type 
     
 
   
 
   

    
    Collecting local use data requires the use of a "Staff - statistical purposes" library card.
    
 
   
 
   
 
     
      #localuse
      #statistics
      #ccode
      #previous_month 
     
 
   

  

----------
*/



Select
    branchccodes.branchname As LIBRARY,
    branchccodes.lib As COLLECTION_CODE,
    Coalesce(Sum(all_lm.CKO_RENEW), "0") As LOCAL_USE_COUNT
From
    (Select
          branches.branchcode,
          authorised_values.authorised_value,
          authorised_values.lib,
          branches.branchname
      From
          branches,
          authorised_values
      Where
          authorised_values.category = 'CCODE' And
          branches.branchcode Like &lt;&gt;
      Order By
          branches.branchcode,
          authorised_values.lib) branchccodes Left Join
    (Select
          If(statistics.branch Is Null, "NEKLS", statistics.branch) As branch,
          If(statistics.ccode Is Null, "XXX", statistics.ccode) As CCODE,
          Count(*) As CKO_RENEW
      From
          statistics
      Where
          Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
          Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
          statistics.type = 'localuse'
      Group By
          If(statistics.branch Is Null, "NEKLS", statistics.branch),
          If(statistics.ccode Is Null, "XXX", statistics.ccode)) all_lm On all_lm.branch = branchccodes.branchcode And
            all_lm.CCODE = branchccodes.authorised_value
Group By
    branchccodes.branchname,
    branchccodes.lib
Order By
    LIBRARY,
    COLLECTION_CODE

























