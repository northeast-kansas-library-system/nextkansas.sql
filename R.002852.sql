/*
R.002852

----------

Name: GHW - LEAVENWRTH Reset patrsons - includes information that might block their deletion
Created by: George Williams

----------

Group:  LEAVENWRTH
     -

Created on: 2016-12-12 16:53:41
Modified on: 2024-01-17 11:46:48
Date last run: 2025-02-05 12:44:23

----------

Public: 0
Expiry: 0

----------

 
Shows all "Reset" patrons with current checkout count (if any), current amount due (if any), guarantors (if any), and current guarantees (if any)
Shows patrons that still have a NExpress account
Only shows patrons with the word "reset" in the barcode number
grouped and sorted by card number, patron homebranch, expiration date, current checkout count, and amount owed
links to the patron's account

Notes:

Click here to run in a new window


----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.branchcode AS BORROWER_HOMEBRANCH,
  borrowers.dateexpiry,
  currentcheckouts.CKO_COUNT AS CURRENT_CHECKOUTS,
  format(feesowed.Sum_amountoutstanding, 2) AS OWES,
  borrowers1.cardnumber AS IS_GUARANTEED_BY,
  GROUP_CONCAT(guarantorstable.cardnumber SEPARATOR ", ") AS GUARANTOR
FROM
  borrowers LEFT JOIN
  (SELECT
    issues.borrowernumber,
    Count(issues.issue_id) AS CKO_COUNT
  FROM
    issues
  GROUP BY
    issues.borrowernumber) currentcheckouts
    ON borrowers.borrowernumber = currentcheckouts.borrowernumber LEFT JOIN
  (SELECT
    accountlines.borrowernumber,
    Sum(accountlines.amountoutstanding) AS Sum_amountoutstanding
  FROM
    accountlines
  GROUP BY
    accountlines.borrowernumber) feesowed
    ON borrowers.borrowernumber = feesowed.borrowernumber LEFT JOIN
  (SELECT
    borrowers.guarantorid,
    borrowers.cardnumber
  FROM
    borrowers) guarantorstable
    ON borrowers.borrowernumber = guarantorstable.guarantorid LEFT JOIN
  borrowers borrowers1
    ON borrowers.guarantorid = borrowers1.borrowernumber
WHERE
  borrowers.cardnumber LIKE "%RESET%"
GROUP BY
  borrowers.cardnumber,
  BORROWER_HOMEBRANCH,
  borrowers.dateexpiry,
  CURRENT_CHECKOUTS,
  OWES,
  IS_GUARANTEED_BY

























