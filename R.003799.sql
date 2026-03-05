/*
R.003799

----------

Name: Borrower count percentages
Created by: George Williams

----------

Group: -
     -

Created on: 2024-02-14 23:16:19
Modified on: 2024-02-15 15:09:56
Date last run: 2024-03-01 15:03:41

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  branches_categories.branchname,
  branches_categories.description,
  Count(Distinct borrowers.borrowernumber) As Count_borrowernumber,
  Concat(
    Format(
      Count(Distinct borrowers.borrowernumber) / borrower_percentage.Count_borrowernumber * 100, 4),
      '%'
  ) As Percentage_of_total_account_holders,
  Group_Concat(Distinct Left(Trim(Coalesce(borrowers.zipcode, '-')), 5) SEPARATOR '<br />') As BORROWER_ZIPCODES
From
  (Select
      branches.branchname,
      branches.branchcode,
      categories.description,
      categories.categorycode
    From
      branches,
      categories
    Where
      branches.branchcode Like Concat('%', <<Choose your branch|branches>>, '%')
  ) branches_categories Left Join
  borrowers On borrowers.branchcode = branches_categories.branchcode And
      borrowers.categorycode = branches_categories.categorycode Left Join
  (Select
      borrowers.branchcode,
      Count(borrowers.borrowernumber) As Count_borrowernumber
    From
      borrowers
    Group By
      borrowers.branchcode) borrower_percentage On borrower_percentage.branchcode = branches_categories.branchcode
Group By
  branches_categories.branchname,
  branches_categories.description,
  borrower_percentage.Count_borrowernumber
Order By
  branches_categories.branchname,
  branches_categories.description

























