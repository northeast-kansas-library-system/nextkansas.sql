/*
R.002904

----------

Name: GHW - ACCTLINES Test
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2017-02-13 16:04:51
Modified on: 2017-02-13 17:11:36
Date last run: 2020-04-30 11:33:08

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  staff.branchcode AS STAFF_BRANCH,
  pay_created.timestamp AS PAYMENT_DATE_TIME,
  accountlines.amount AS AMT,
  borrowers.cardnumber,
  accountlines.date AS DATE_OF_FEE,
  items.barcode,
  items.homebranch AS ITEM_HOME_BRANCH,
  accountlines.amountoutstanding
FROM
  (SELECT
    action_logs.user AS STAFF_ID,
    action_logs.object AS PATRON_ID,
    Replace((Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), ',', ',')), '\n', '')), "'", "") AS ACCTLINE,
    action_logs.info,
    action_logs.timestamp
  FROM
    action_logs
  WHERE
    action_logs.module = 'FINES' AND
    action_logs.action LIKE 'CREAT%' AND
    action_logs.info LIKE '%create_payment%' AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  ORDER BY
    action_logs.timestamp DESC) pay_created INNER JOIN
  accountlines
    ON accountlines.borrowernumber = pay_created.PATRON_ID LEFT JOIN
  borrowers staff
    ON pay_created.STAFF_ID = staff.borrowernumber INNER JOIN
  borrowers
    ON accountlines.borrowernumber = borrowers.borrowernumber LEFT JOIN
  items
    ON accountlines.itemnumber = items.itemnumber
WHERE
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 1) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 2) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 3) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 4) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 5) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 6) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 7) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 8) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 9) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 10) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 11) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 12) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 13) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 14) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 15) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 16) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 17) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 18) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 19) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 20) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 21) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 22) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 23) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 24) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 25) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 26) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 27) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 28) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 29) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 30) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 31) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 32) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 33) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 34) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 35) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 36) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 37) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 38) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 39) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 40) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 41) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 42) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 43) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 44) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 45) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 46) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 47) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 48) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 49) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 50) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 51) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 52) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 53) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 54) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 55) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 56) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 57) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 58) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 59) OR
  (Find_In_Set(accountlines.accountlines_id, pay_created.ACCTLINE) = 60)
HAVING
  STAFF_BRANCH <> ITEM_HOME_BRANCH AND
  AMT > 3
ORDER BY
  STAFF_BRANCH,
  ITEM_HOME_BRANCH,
  PAYMENT_DATE_TIME



