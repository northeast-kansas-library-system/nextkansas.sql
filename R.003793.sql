/*
R.003793

----------

Name: filler 2
Created by: George Williams

----------

Group: -
     -

Created on: 2024-01-21 14:11:54
Modified on: 2024-01-21 14:11:54
Date last run: 2024-01-21 14:12:01

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  IF(
    opac_problem_reports.branchcode = 'NEKLS', 
    'hidden', 
    If(
      Count(opac_problem_reports.reportid) > 0, 
      'hidden', 
      '-'
    )
  ) As HIDDEN
From
  branches Left Join
  (
    Select
      problem_reports.branchcode,
      problem_reports.reportid
    From
      problem_reports
  ) opac_problem_reports 
  On 
    opac_problem_reports.branchcode = branches.branchcode
Where
  branches.branchcode Like <>
Group By
  branches.branchcode

























