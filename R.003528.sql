/*
R.003528

----------

Name: GHW - Borrowers with unresolved credits, unresolved debits, and a 0.00 balance
Created by: George Williams

----------

Group: Fines/Fees
     -

Created on: 2021-07-15 17:20:32
Modified on: 2024-01-17 11:32:26
Date last run: 2025-08-08 11:25:21

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of borrowers with unresolved credits and debits that generate a $0.00 balance&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows currently unresolved credits and debits&lt;/li&gt;
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
  Format(outstanding_credits.Sum_amountoutstanding, 2) AS TOTAL_UNRESOLVED_CREDITS,
  Format(outstanding_debits.Sum_amountoutstanding, 2) AS TOTAL_UNRESOLVED_DEBITS,
  Format((outstanding_credits.Sum_amountoutstanding + outstanding_debits.Sum_amountoutstanding), 2) AS BALANCE,
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
      branches) branchess ON branchess.branchcode = borrowers.branchcode JOIN
  (SELECT
      accountlines.borrowernumber,
      Sum(accountlines.amountoutstanding) AS Sum_amountoutstanding
    FROM
      accountlines
    WHERE
      accountlines.amountoutstanding &lt; 0
    GROUP BY
      accountlines.borrowernumber) outstanding_credits ON
      outstanding_credits.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  Format((outstanding_credits.Sum_amountoutstanding + outstanding_debits.Sum_amountoutstanding), 2) = 0
GROUP BY
  borrowers.borrowernumber
ORDER BY
  branchess.branchname,
  borrowers.cardnumber

























