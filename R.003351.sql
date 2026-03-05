/*
R.003351

----------

Name: GHW - Checkout Counts by Patron
Created by: George Williams

----------

Group: -
     -

Created on: 2020-08-28 17:31:11
Modified on: 2024-01-17 12:04:29
Date last run: 2021-05-05 13:51:06

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Item counts by patron where the patron has more than 1 item checked out - includes counts by checkout library&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows items currently checked out&lt;/li&gt;
&lt;li&gt;At the library you specified&lt;/li&gt;
&lt;li&gt;grouped by patron barcode number&lt;/li&gt;
&lt;li&gt;sorted by highest total checkout count to lowest checkout count&lt;/li&gt;
&lt;li&gt;links&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Does not include INHOUSE or ILL patron categories&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3351&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;tag goes here&lt;/p&gt;
&lt;/div&gt;

----------
*/



Select
    Concat('', borrowers.cardnumber, '') AS LINK,
    borrowers.branchcode AS PATRON_HOME_LIBRARY,
    borrowers.categorycode AS PATRON_CATEGORYCODE,
    Count(Distinct issues.issue_id) As CKO_FROM_ALL_LIBRARIES,
    Group_Concat(Distinct bcounts.BCOUNT Order By bcounts.BCOUNT Separator " - ") As CKO_PER_LIBRARY
From
    issues Join
    (Select
         issues.borrowernumber,
         Concat(issues.branchcode, ' - ', Count(issues.itemnumber)) As BCOUNT
     From
         issues
     Group By
         issues.borrowernumber,
         issues.branchcode) bcounts On bcounts.borrowernumber = issues.borrowernumber Join
    borrowers On issues.borrowernumber = borrowers.borrowernumber
Where
    borrowers.categorycode &lt;&gt; 'INHOUSE' And
    borrowers.categorycode &lt;&gt; 'ILL' And
    borrowers.branchcode Like &lt;&gt;
Group By
    borrowers.cardnumber,
    borrowers.branchcode,
    borrowers.categorycode,
    issues.borrowernumber
Having
    Count(Distinct issues.issue_id) &gt; 1
Order By
    CKO_FROM_ALL_LIBRARIES Desc

























