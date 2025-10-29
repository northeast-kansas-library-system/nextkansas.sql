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

<div class="reportinfo noprint"> 
<p>Generates a list of borrowers with unresolved credits and debits that generate a $0.00 balance</p>
<ul><li>Shows currently unresolved credits and debits</li>
<li>at the library you specify</li>
<li>grouped by borrower id number</li>
<li>sorted by library and borrower barcode number</li>
<li>links to the borrower's accounts tab</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p></p>
<p class= "notetags" style="display: none;">#tested #updated  #gk</p>
</div>

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

























