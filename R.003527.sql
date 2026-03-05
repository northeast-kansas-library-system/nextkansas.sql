/*
R.003527

----------

Name: GHW - Borrowers with unresolved debits
Created by: George Williams

----------

Group: -
     -

Created on: 2021-07-15 17:13:25
Modified on: 2024-01-17 11:32:28
Date last run: 2021-07-15 17:13:31

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of unresolved debits&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows currently unresolved debits&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped by borrower id number&lt;/li&gt;
&lt;li&gt;sorted by library and borrower barcode number&lt;/li&gt;
&lt;li&gt;links to the borrower's accounts tab&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;#tested #updated  #gk&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  branchess.branchname,
  borrowers.cardnumber,
  Format(outstanding_debits.Sum_amountoutstanding, 2) AS TOTAL_UNRESOLVED_DEBITS,
  Concat(
    'patron fine records'
  ) AS LINK
FROM
  borrowers JOIN
  (SELECT
      accountlines.borrowernumber,
      Sum(accountlines.amountoutstanding) AS Sum_amountoutstanding
    FROM
      accountlines
    WHERE
      accountlines.amountoutstanding &gt; 0
    GROUP BY
      accountlines.borrowernumber) outstanding_debits ON
      outstanding_debits.borrowernumber = borrowers.borrowernumber INNER JOIN
  (SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches) branchess ON branchess.branchcode = borrowers.branchcode
WHERE
  borrowers.branchcode LIKE &lt;&gt;
GROUP BY
  borrowers.borrowernumber
ORDER BY
  branchess.branchname,
  borrowers.cardnumber

























