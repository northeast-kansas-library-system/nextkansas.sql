/*
R.002780

----------

Name: Testing report for fee payments
Created by: George H Williams

----------

Group: Administrative Reports
     Reports Testing Ground

Created on: 2016-09-27 17:30:31
Modified on: 2016-09-29 09:20:01
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  accountlines.timestamp AS TRANSACTION_DATE,
  borrowers.cardnumber AS BORROWER_BARCODE,
  Concat(borrowers2.firstname, ' ', borrowers2.surname) AS STAFF_USERID,
  borrowers2.branchcode AS TRANSACTION_LOCATION,
  ROUND(Sum(accountlines.amount), 2) * -1 AS TOTAL_COLLECTED,
  If(accountlines.accounttype = 'pay', 'Payment', If(accountlines.accounttype =  'c', 'Credit', If(accountlines.accounttype = 'w', 'Write-off', 'X'))) AS  PAYMENT_TYPE,
  items.homebranch,
  items.barcode
FROM
  accountlines JOIN
  borrowers
    ON accountlines.borrowernumber = borrowers.borrowernumber JOIN
  borrowers borrowers2
    ON accountlines.manager_id = borrowers2.borrowernumber LEFT JOIN
  items
    ON accountlines.itemnumber = items.itemnumber
WHERE
  (accountlines.date BETWEEN  <<Start date in format yyyy-mm-dd|date>>  AND <<End date in format yyyy-mm-dd|date>>+ INTERVAL 1 DAY) AND
  borrowers2.branchcode LIKE <<Transaction location|LBRANCH>> AND
  accountlines.accounttype IN ('pay', 'W', 'C') AND
  accountlines.accounttype LIKE <<Payment type|LPAY>>
GROUP BY
  items.homebranch, items.barcode, accountlines.accountlines_id
ORDER BY
  TRANSACTION_DATE



