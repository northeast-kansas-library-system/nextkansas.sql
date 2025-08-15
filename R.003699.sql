/*
R.003699

----------

Name: GHW - Statistics - Local use by library and item type
Created by: George Williams

----------

Group: Statistics
     -

Created on: 2023-02-01 10:38:58
Modified on: 2024-03-01 16:34:46
Date last run: 2024-12-10 16:37:46

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
      #itype
      #previous_month 
     
 
   

  

----------
*/



Select
    branch_itype.branchname AS LIBRARY,
    branch_itype.description AS ITEM_TYPE,
    Coalesce(Sum(statistics_all.CKO_REN), 0) As LOCAL_USE_COUNT
From
    (Select
          branches.branchname,
          itemtypes.description,
          branches.branchcode,
          itemtypes.itemtype
      From
          branches,
          itemtypes
      Where
          branches.branchcode Like &lt;&gt;) branch_itype Left Join
    (Select
          Coalesce(statistics.branch, "NEKLS") As branch,
          Coalesce(statistics.itemtype, "BOOK") As itemtype,
          Count(*) As CKO_REN
      From
          statistics
      Where
          statistics.type = 'localuse' And
          Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
          Month(statistics.datetime) = Month(Now() - Interval 1 Month)
      Group By
          Coalesce(statistics.branch, "NEKLS"),
          Coalesce(statistics.itemtype, "BOOK")
      Order By
          branch,
          itemtype) statistics_all On statistics_all.branch = branch_itype.branchcode And
            statistics_all.itemtype = branch_itype.itemtype
Group By
    branch_itype.branchname,
    branch_itype.description 
ORDER BY
    LIBRARY,
    ITEM_TYPE

























