/*
R.003339

----------

Name: GHW - Borrowers with unresolved credits on their accounts
Created by: George Williams

----------

Group: -
     -

Created on: 2020-07-10 15:06:56
Modified on: 2024-01-17 12:04:36
Date last run: 2025-08-05 19:59:07

----------

Public: 0
Expiry: 300

----------

 
Shows a list of borrowers with unresolved credits on their accounts
Shows borrowers with currently unresolved credits
shows patrons at the home library you specify
grouped by borrowernumber
sorted by formula that generates row numbers
links to the borrower's fine payment tab

Notes:  

replaces report 831
replaces report 3526
Click here to run in a new window


----------
*/



SELECT
  (@row_number:=@row_number + 1) AS num, 
  Concat('Link to patron') AS
  LINK,
  borrowers.branchcode,
  borrowers.cardnumber AS LIBRARYCARD,
  borrowers.categorycode,
  Sum(accountlineslesszero.amountoutstanding) AS Sum_amountoutstanding
FROM
  borrowers JOIN
  (SELECT
      accountlines.borrowernumber,
      accountlines.amountoutstanding
    FROM
      accountlines
    WHERE
      accountlines.amountoutstanding &lt; 0) accountlineslesszero ON
      accountlineslesszero.borrowernumber = borrowers.borrowernumber,
    (SELECT @row_number:=0) AS t
WHERE
  borrowers.branchcode LIKE &lt;&gt;
GROUP BY
  borrowers.borrowernumber
ORDER BY
  num

























