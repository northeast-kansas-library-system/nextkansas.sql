/*
R.003687

----------

Name: GHW - Holds queue count for jQuery enhancement
Created by: George Williams

----------

Group: -
     -

Created on: 2022-12-11 21:57:00
Modified on: 2024-01-17 11:29:54
Date last run: 2023-09-12 15:57:27

----------

Public: 0
Expiry: 300

----------

 
  Creates the holds queue button on the home page in the staff client
  
    Creates button to take staff to the current holds queue
    for the library you're logged in at
    grouped by holds queue branchcode
    button links to report 3084
  
  Notes:
  
  Relies on jQuery to work properly
  
  #jquery_enhancement
  


----------
*/



Select
  CONCAT(
    ' ',
    ' Holds queue (',
    Count(Distinct request_counts.itemnumber),
    ' items)'
  ) As COUNT
From
  branches Left Join
  (
    Select
      hold_fill_targets.source_branchcode,
      hold_fill_targets.itemnumber
    From
      hold_fill_targets
    Group By
      hold_fill_targets.source_branchcode,
      hold_fill_targets.itemnumber
  ) request_counts On request_counts.source_branchcode = branches.branchcode
Where
    branches.branchcode = &lt;&gt;
Group By
    branches.branchcode

























