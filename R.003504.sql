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

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Counts borrowers by zip code&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current data&lt;/li&gt;
&lt;li&gt;with the home library you specify&lt;/li&gt;
&lt;li&gt;grouped and sorted by borrower home library and zip code&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3504&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;tag goes here&lt;/p&gt;
&lt;/div&gt;

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

























