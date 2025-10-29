/*
R.003698

----------

Name: GHW - Library card numbers with punctuation marks
Created by: George Williams

----------

Group: -
     -

Created on: 2023-01-26 13:47:47
Modified on: 2023-10-16 21:54:48
Date last run: 2023-03-22 16:31:29

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
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
        borrowers.cardnumber Like "%&lt;%" Or
        borrowers.cardnumber Like "%.%" Or
        borrowers.cardnumber Like "%&gt;%" Or
        borrowers.cardnumber Like "%/%" Or
        borrowers.cardnumber Like "%?%" Or
        borrowers.cardnumber Like "%|%" Or
        borrowers.cardnumber Like "%\\%") And
    branches.branchcode Like &lt;&gt; And
    categories.categorycode &lt;&gt; 'S_SIP' And
    categories.categorycode &lt;&gt; 'STATISTIC' And
    categories.categorycode &lt;&gt; 'ILL' And
    categories.categorycode &lt;&gt; 'INHOUSE' And
    categories.categorycode &lt;&gt; 'STAFF'
Group By
    borrowers.borrowernumber,
    branches.branchname,
    categories.description,
    categories.categorycode
Order By
    branches.branchname,
    borrowers.cardnumber

























