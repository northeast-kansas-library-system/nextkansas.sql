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

<div class="reportinfo noprint"> 
<p>Generates a list of unresolved debits</p>
<ul><li>Shows currently unresolved debits</li>
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
      accountlines.amountoutstanding > 0
    GROUP BY
      accountlines.borrowernumber) outstanding_debits ON
      outstanding_debits.borrowernumber = borrowers.borrowernumber INNER JOIN
  (SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches) branchess ON branchess.branchcode = borrowers.branchcode
WHERE
  borrowers.branchcode LIKE <>
GROUP BY
  borrowers.borrowernumber
ORDER BY
  branchess.branchname,
  borrowers.cardnumber

























