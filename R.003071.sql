/*
R.003071

----------

Name: GHW - Restrictions no longer needed
Created by: George Williams

----------

Group: -
     -

Created on: 2018-04-13 16:53:35
Modified on: 2024-01-17 11:58:19
Date last run: 2025-02-05 12:45:35

----------

Public: 0
Expiry: 300

----------

 
Reports on patrons who have had a restriction added to their account due to an overdue item but the item has been returned and their fees are less than $10.00
Shows patrons who currently have restrictions created by the overdues process, no overdues, and less than $10.00 in fees
at all Next libraries
grouped by borrowernumber
sorted by borrower home branch, borrowers last name, borrowers first name
links directly to the restriction page of the borrower

Notes:

Click here to run in a new window


----------
*/



SELECT
  Concat("Go to patron") AS LINK_TO_BORROWER,
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.debarred,
  borrowers.debarredcomment,
  fees.SUM
FROM
  borrowers
  LEFT JOIN (
    SELECT
      issues.borrowernumber,
      issues.itemnumber,
      issues.date_due
    FROM
      issues
    WHERE
      issues.date_due &lt; Now()
    GROUP BY
      issues.borrowernumber,
      issues.itemnumber,
      issues.date_due
  ) overdues
    ON borrowers.borrowernumber = overdues.borrowernumber
  LEFT JOIN (
    SELECT
      accountlines.borrowernumber,
      Group_Concat(accountlines.accounttype) AS Group_Concat_accounttype,
      Sum(accountlines.amountoutstanding) AS SUM
    FROM
      accountlines
    WHERE
      accountlines.amountoutstanding &gt; 0
    GROUP BY
      accountlines.borrowernumber
  ) fees
    ON borrowers.borrowernumber = fees.borrowernumber
WHERE
  borrowers.debarred IS NOT NULL AND
  (borrowers.debarredcomment IS NULL OR
    (borrowers.debarredcomment LIKE "%overdue%" AND
      borrowers.debarredcomment LIKE "%process%")) AND
  fees.Group_Concat_accounttype NOT LIKE "L%" AND
  fees.Group_Concat_accounttype NOT LIKE "D%" AND
  fees.Group_Concat_accounttype NOT LIKE "A%" AND
  fees.Group_Concat_accounttype NOT LIKE "P%" AND
  fees.Group_Concat_accounttype NOT LIKE "M%" AND
  fees.Group_Concat_accounttype NOT LIKE "C%" AND
  (Char_Length(borrowers.debarredcomment) = 33 OR
    Char_Length(borrowers.debarredcomment) = 54 OR
    (borrowers.debarredcomment IS NULL)) AND
  Coalesce(borrowers.gonenoaddress, 0) &lt; 1 AND
  Coalesce(borrowers.lost, 0) &lt; 1 AND
  fees.SUM &lt;= 10
GROUP BY
  borrowers.borrowernumber
HAVING
  Count(DISTINCT overdues.itemnumber) = 0
ORDER BY
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname

























