/*
R.003773

----------

Name: GHW - Library card numbers with punctuation marks
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-16 21:54:16
Modified on: 2023-10-16 21:54:16
Date last run: 2023-12-19 09:53:19

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt;

  &lt;p&gt;Library card numbers with punctuation marks&lt;/p&gt;
  &lt;ul&gt;
    &lt;li&gt;Shows current borrower accounts&lt;/li&gt;
    &lt;li&gt;At the library you specify&lt;/li&gt;
    &lt;li&gt;grouped and sorted by library name and card number&lt;/li&gt;
  &lt;/ul&gt;&lt;br /&gt;
  &lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
  &lt;p&gt;&lt;/p&gt;
  &lt;p&gt;Does not include SIP accounts, system accounts, inhouse accounts, or ILL accounts.&lt;/p&gt;
  &lt;p&gt;&lt;/p&gt;
  &lt;p class= "notetags" style="display: none;"&gt;#cardnumbers #troubleshooting&lt;/p&gt;
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt;
&lt;/div&gt;

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
        borrowers.cardnumber Like "%&ast;%" Or
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

























