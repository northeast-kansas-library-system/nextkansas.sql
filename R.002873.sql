/*
R.002873

----------

Name: GHW - Payments, Credits, and Writeoffs - Last Month
Created by: George Williams

----------

Group: Fines/Fees
     -

Created on: 2017-01-04 11:48:38
Modified on: 2024-01-17 11:46:33
Date last run: 2025-10-15 14:01:09

----------

Public: 0
Expiry: 0

----------

 
Reports on fee payment/credit/writeoff activity at a library
Shows activity in the previous calendar month
Shows all fees collected/processed at a specified library
grouped by accountlines_id
sorted by payment locttion, payment type, payment timestamp
links to the payment accountline details page

Notes:

Updated may 5, 2021.

Click here to run in a new window


----------
*/



SELECT
  staff.branchcode AS PAYMENT_BRANCH,
  accountlines.accountlines_id AS PAYMENT_ID,
  accountlines.timestamp,
  staff.cardnumber AS STAFF_LOGIN,
  Format(accountlines.amount, 2) AS AMOUNT,
  patrons.cardnumber AS BORROWER,
  Trim(Replace(accountlines.note, '\r\n', ' ')) AS NOTE,
  If(
    accountlines.status IS NULL,
    accountlines.credit_type_code,
    Concat(accountlines.credit_type_code, ' / ', accountlines.status)
  ) AS PAYMENT_TYPE,
  CONCAT(
    'Go to transaction'
  ) AS LINK_TO_PAYMENT
FROM
  accountlines LEFT JOIN
  borrowers staff ON staff.borrowernumber = accountlines.manager_id LEFT JOIN
  borrowers patrons ON accountlines.borrowernumber = patrons.borrowernumber
WHERE
  staff.branchcode LIKE &lt;&gt; AND
  staff.categorycode = 'STAFF' AND
  accountlines.credit_type_code IS NOT NULL AND
  Year(accountlines.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
  Month(accountlines.timestamp) = Month(Now() - INTERVAL 1 MONTH)
GROUP BY
  accountlines.accountlines_id
ORDER BY
  PAYMENT_BRANCH,
  accountlines.timestamp,
  accountlines.accountlines_id

























