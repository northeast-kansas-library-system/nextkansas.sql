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

<div class="reportinfo noprint"> 
<p>Counts borrowers by zip code</p>
<ul><li>Shows current data</li>
<li>with the home library you specify</li>
<li>grouped and sorted by borrower home library and zip code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3504&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">tag goes here</p>
</div>

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
      '<a class="btn btn-default noprint" ', 
      'href=\"https://www.unitedstateszipcodes.org/', 
      LPAD(Cast(Left(Trim(Coalesce(If(borrowers.zipcode = '', Null, borrowers.zipcode), '0')), 5) As Decimal), 5, 0),
      '/ \" target="_blank">Map this zipcode</a>' 
    )
  ) AS MAP
From
  borrowers Join branches 
    On borrowers.branchcode = branches.branchcode
Where
  borrowers.branchcode Like <<Choose a library|LBRANCH>>
Group By
  borrowers.branchcode,
  Cast(Left(Trim(Coalesce(If(borrowers.zipcode = '', Null, borrowers.zipcode), '0')), 5) As Decimal)
Order By
  branches.branchname,
  zipcode

























