/*
R.003504

----------

Name: GHW - Borrower count by zipcode
Created by: George Williams

----------

Group: -
     -

Created on: 2021-05-12 16:55:32
Modified on: 2025-03-06 10:42:48
Date last run: 2025-03-06 10:42:51

----------

Public: 0
Expiry: 300

----------

 
Counts borrowers by zip code
Shows current data
with the home library you specify
grouped and sorted by borrower home library and zip code

Notes:


Click here to run in a new window
tag goes here


----------
*/



Select
  branches.branchname,
  Cast(Left(Trim(Coalesce(If(borrowers.zipcode = '', Null, borrowers.zipcode), '0')), 5) As Decimal) As zipcode,
  Count(borrowers.borrowernumber) As Count_borrowernumber,
  If(
    Cast(Left(Trim(Coalesce(If(borrowers.zipcode = '', Null, borrowers.zipcode), '0')), 5) As Decimal) = 0,
    '',
    Concat_ws('', 
      'Map this zipcode' 
    )
  ) AS MAP
From
  borrowers Join branches 
    On borrowers.branchcode = branches.branchcode
Where
  borrowers.branchcode Like &lt;&gt;
Group By
  borrowers.branchcode,
  Cast(Left(Trim(Coalesce(If(borrowers.zipcode = '', Null, borrowers.zipcode), '0')), 5) As Decimal)
Order By
  branches.branchname,
  zipcode

























