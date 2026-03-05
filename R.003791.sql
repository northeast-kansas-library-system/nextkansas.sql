/*
R.003791

----------

Name: opac problem report cout
Created by: George Williams

----------

Group: -
     -

Created on: 2024-01-21 14:06:11
Modified on: 2024-01-21 14:09:06
Date last run: 2024-01-21 14:09:10

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
  branches.branchcode Like <<Enter branchcode>>
Group By
  branches.branchcode

























