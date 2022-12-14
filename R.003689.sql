/*
R.003689

----------

Name: ADMINREPORT holds count
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-12-12 21:46:37
Modified on: 2022-12-12 21:53:06
Date last run: 2022-12-13 15:46:45

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  branches.branchcode,
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
  Concat('Total'),
  Count(Distinct hold_fill_targets.itemnumber) As COUNT_TOTAL
From
  hold_fill_targets
Order By
  COUNT Desc

























