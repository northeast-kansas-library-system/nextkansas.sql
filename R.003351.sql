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

 
Item counts by patron where the patron has more than 1 item checked out - includes counts by checkout library
Shows items currently checked out
At the library you specified
grouped by patron barcode number
sorted by highest total checkout count to lowest checkout count
links

Notes:

Does not include INHOUSE or ILL patron categories

Click here to run in a new window
tag goes here


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

























