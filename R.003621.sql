/*
R.003621

----------

Name: GHW - Pending borrower updates
Created by: George Williams

----------

Group: -
     -

Created on: 2021-11-09 00:22:51
Modified on: 2025-03-18 15:06:36
Date last run: 2025-08-15 13:47:17

----------

Public: 0
Expiry: 30

----------



----------
*/



Select
  If(branches.branchcode = 'NEKLS',
    'next_hidden',
    IF(Coalesce(counts.Count_borrowernumber, 0) &gt; 0, 'next_hidden', '-')
  ) As class
From
  branches Left Join
  (
    Select
      borrowers.branchcode,
      Count(borrower_modifications.borrowernumber) As Count_borrowernumber
    From
      borrower_modifications Join
      borrowers On borrowers.borrowernumber = borrower_modifications.borrowernumber
    Group By
      borrowers.branchcode
  ) counts 
  On 
    counts.branchcode = branches.branchcode
Where
  branches.branchcode Like Concat(&lt;&gt;, '%')
Group By
  branches.branchcode

























