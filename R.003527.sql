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

 
Generates a list of unresolved debits
Shows currently unresolved debits
at the library you specify
grouped by borrower id number
sorted by library and borrower barcode number
links to the borrower's accounts tab

Notes:


#tested #updated  #gk


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

























