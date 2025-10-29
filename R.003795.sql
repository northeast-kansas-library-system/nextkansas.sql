/*
R.003795

----------

Name: OPAC Problem report hider
Created by: George Williams

----------

Group: -
     -

Created on: 2024-01-21 14:12:42
Modified on: 2025-03-18 15:03:31
Date last run: 2025-10-28 20:05:17

----------

Public: 0
Expiry: 30

----------



----------
*/



Select
  IF(
    branches.branchcode = 'NEKLS', 
    'next_hidden', 
    If(
      Count(opac_problem_reports.reportid) > 0, 
      'next_hidden', 
      '-'
    )
  ) As class
From
  branches Left Join
  (
    Select
      problem_reports.branchcode,
      problem_reports.reportid
    From
      problem_reports
    Where
      problem_reports.status <> 'closed'
  ) opac_problem_reports 
  On 
    opac_problem_reports.branchcode = branches.branchcode
Where
  branches.branchcode Like Concat(<>, '%')
Group By
  branches.branchcode

























