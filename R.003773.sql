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



  Library card numbers with punctuation marks
  
    Shows current borrower accounts
    At the library you specify
    grouped and sorted by library name and card number
  
  Notes:
  
  Does not include SIP accounts, system accounts, inhouse accounts, or ILL accounts.
  
  #cardnumbers #troubleshooting
  


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

























