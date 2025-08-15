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
Date last run: 2025-08-15 13:47:17

----------

Public: 0
Expiry: 30

----------



----------
*/



Select
  IF(branches.branchcode = 'NEKLS',
    'next_hidden',  
    If(Count(issuess.noteseen) &gt; 0, 'next_hidden', '-')
  ) As 'class',
  Concat(
    'Notes for ', 
    branches.branchcode, ''
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
  branches.branchcode Like Concat(&lt;&gt;, '%')
Group By
  branches.branchcode

























