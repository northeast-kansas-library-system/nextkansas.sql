/*
R.003620

----------

Name: GHW - Pending suggestion alerts
Created by: George Williams

----------

Group: -
     -

Created on: 2021-11-09 00:16:43
Modified on: 2025-03-18 15:05:51
Date last run: 2025-10-27 14:08:50

----------

Public: 0
Expiry: 30

----------



----------
*/



Select
  IF(branchcode_asked.branchcode = 'NEKLS',
    'hidden',
    If(Count(suggestionss.suggestionid) &gt; 0, 'next_hidden', '-')
  ) As class
From
  (
    Select
      branches.branchcode,
      'asked' As asked
    From
      branches
  ) branchcode_asked 
  Left Join
  (
    Select
      *
    From
      suggestions
  ) suggestionss 
  On 
    suggestionss.branchcode = branchcode_asked.branchcode And
    suggestionss.STATUS = branchcode_asked.asked
Where
  branchcode_asked.branchcode LIKE Concat(&lt;&gt;, '%')
Group By
  branchcode_asked.asked

























