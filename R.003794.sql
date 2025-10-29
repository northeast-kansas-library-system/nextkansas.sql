/*
R.003794

----------

Name: filler 3794
Created by: George Williams

----------

Group: -
     -

Created on: 2024-01-21 14:12:18
Modified on: 2024-01-21 14:12:18
Date last run: -

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

























