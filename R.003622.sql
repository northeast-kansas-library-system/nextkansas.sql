/*
R.003622

----------

Name: GHW - Pending checkout notes
Created by: George Williams

----------

Group: -
     -

Created on: 2021-11-09 00:57:48
Modified on: 2025-03-18 15:07:16
Date last run: 2026-08-25 23:46:04

----------

Public: 0
Expiry: 30

----------



----------
*/



Select
  IF(branches.branchcode = 'NEKLS',
    'next_hidden',  
    If(Count(issuess.noteseen) > 0, 'next_hidden', '-')
  ) As 'class',
  Concat(
    '<a href="/cgi-bin/koha/reports/guided_reports.pl?id=3623&param_name=Enter+branchcode&sql_params=', 
    branches.branchcode, 
    '&op=run&limit=1000',
    '" target="_blank">Notes for ', 
    branches.branchcode, '</a>'
  ) As link
From
  branches Left Join
  (
    Select
      issues.branchcode,
      issues.note,
      issues.notedate,
      issues.noteseen
    From
      issues
    Where
      issues.noteseen = 0
  ) issuess 
  On 
    issuess.branchcode = branches.branchcode
Where
  branches.branchcode Like Concat(<<Enter branchcode>>, '%')
Group By
  branches.branchcode

























