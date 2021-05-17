/*
R.003351

----------

Name: GHW - Checkout Counts by Patron
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-08-28 17:31:11
Modified on: 2020-08-28 18:01:18
Date last run: 2021-05-05 13:51:06

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Item counts by patron where the patron has more than 1 item checked out - includes counts by checkout library</p>
<ul><li>Shows items currently checked out</li>
<li>At the library you specified</li>
<li>grouped by patron barcode number</li>
<li>sorted by highest total checkout count to lowest checkout count</li>
<li>links</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Does not include INHOUSE or ILL patron categories</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3351&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">tag goes here</p>
</div>

----------
*/

Select
    Concat('<a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', borrowers.borrowernumber, '" target="_blank">', borrowers.cardnumber, '</a>') AS LINK,
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
    borrowers.categorycode <> 'INHOUSE' And
    borrowers.categorycode <> 'ILL' And
    borrowers.branchcode Like <<Choose patron's home library|LBRANCH>>
Group By
    borrowers.cardnumber,
    borrowers.branchcode,
    borrowers.categorycode,
    issues.borrowernumber
Having
    Count(Distinct issues.issue_id) > 1
Order By
    CKO_FROM_ALL_LIBRARIES Desc



