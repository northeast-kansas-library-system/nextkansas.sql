/*
R.003698

----------

Name: GHW - Library card numbers with punctuation marks
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-01-26 13:47:47
Modified on: 2023-01-26 13:51:54
Date last run: 2023-01-26 14:50:21

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
  <p>Library card numbers with punctuation marks</p>
  <ul>
    <li>Shows current borrower accounts</li>
    <li>At the library you specify</li>
    <li>grouped and sorted by library name and card number</li>
  </ul><br />
  <p><ins>Notes:</ins></p>
  <p></p>
  <p>Does not include SIP accounts, system accounts, inhouse accounts, or ILL accounts.</p>
  <p></p>
  <p class= "notetags" style="display: none;">#cardnumbers #troubleshooting</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

----------
*/



Select
    borrowers.borrowernumber,
    branches.branchname,
    borrowers.cardnumber,
    borrowers.dateexpiry,
    categories.description,
    categories.categorycode
From
    borrowers Join
    branches On borrowers.branchcode = branches.branchcode Inner Join
    categories On borrowers.categorycode = categories.categorycode
Where
    (borrowers.cardnumber Like "%~%" Or
        borrowers.cardnumber Like "%`%" Or
        borrowers.cardnumber Like "%!%" Or
        borrowers.cardnumber Like "%@%" Or
        borrowers.cardnumber Like "%#%" Or
        borrowers.cardnumber Like "%$%" Or
        borrowers.cardnumber Like "%\%%" Or
        borrowers.cardnumber Like "%^%" Or
        borrowers.cardnumber Like "%&%" Or
        borrowers.cardnumber Like "%*%" Or
        borrowers.cardnumber Like "%(%" Or
        borrowers.cardnumber Like "%)%" Or
        borrowers.cardnumber Like "%-%" Or
        borrowers.cardnumber Like "%\_%" Or
        borrowers.cardnumber Like "%+%" Or
        borrowers.cardnumber Like "%=%" Or
        borrowers.cardnumber Like "%{%" Or
        borrowers.cardnumber Like "%}%" Or
        borrowers.cardnumber Like "%{%" Or
        borrowers.cardnumber Like "%}%" Or
        borrowers.cardnumber Like "%;%" Or
        borrowers.cardnumber Like "%:%" Or
        borrowers.cardnumber Like "%\'%" Or
        borrowers.cardnumber Like "%\"%" Or
        borrowers.cardnumber Like "%,%" Or
        borrowers.cardnumber Like "%<%" Or
        borrowers.cardnumber Like "%.%" Or
        borrowers.cardnumber Like "%>%" Or
        borrowers.cardnumber Like "%/%" Or
        borrowers.cardnumber Like "%?%" Or
        borrowers.cardnumber Like "%|%" Or
        borrowers.cardnumber Like "%\\%") And
    branches.branchcode Like <<Choose your library|ZBRAN>> And
    categories.categorycode <> 'S_SIP' And
    categories.categorycode <> 'STATISTIC' And
    categories.categorycode <> 'ILL' And
    categories.categorycode <> 'INHOUSE' And
    categories.categorycode <> 'STAFF'
Group By
    borrowers.borrowernumber,
    branches.branchname,
    categories.description,
    categories.categorycode
Order By
    branches.branchname,
    borrowers.cardnumber

























