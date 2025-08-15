/*
R.003775

----------

Name: GHW - Quick count - Current holds queue count
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-16 21:59:34
Modified on: 2023-10-16 21:59:34
Date last run: 2024-08-28 08:32:53

----------

Public: 0
Expiry: 300

----------

 
  Gives a count for the requests queue at all Next Search Catalog libraries
  
    Shows counts for current holds queue
    at all Next libraries
    grouped and sorted by library with a total at the top of the column
  
  
  #quick_count
  


----------
*/



Select
  branches.branchcode AS LIBRARY,
  Coalesce(targets.COUNT, 0) As COUNT
From
  branches Left Join
  (
    Select
      hold_fill_targets.source_branchcode,
        Count(Distinct hold_fill_targets.itemnumber) As COUNT
      From
        hold_fill_targets
      Group By
        hold_fill_targets.source_branchcode
  ) targets On targets.source_branchcode = branches.branchcode
Group By
  branches.branchcode,
  Coalesce(targets.COUNT, 0)
Union
Select
  Concat(' Total') AS LIBRARY,
  Count(Distinct hold_fill_targets.itemnumber) As COUNT_TOTAL
From
  hold_fill_targets
Order By
  LIBRARY
LIMIT 100

























