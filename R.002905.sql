/*
R.002905

----------

Name: GHW - Soft Offsets
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-02-14 11:06:06
Modified on: 2020-03-03 10:13:50
Date last run: 2018-06-21 11:24:25

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  staff.branchcode AS STAFF_AT,
  payments.amount AS COLLECTED,
  patron.cardnumber AS FROM_PATRON,
  Replace(payments.note, "\r\n", "") AS PAYMENT_NOTES,
  payments.date AS PAYMENT_DATE,
  Concat_Ws("-", payments.accountlines_id, payments.accountno) AS
  PAYMENT_REFERENCE,
  items.barcode AS FOR_ITEM,
  items.homebranch AS OWNED_BY,
  paid.date AS FEE_DATE,
  paid.amount AS FEE_AMOUNT,
  payments.amountoutstanding AS FEE_STILL_OWED,
  paid.description AS FEE_DESCRIPTION,
  Replace(paid.note, "\r\n", "") AS FEE_NOTES,
  Concat_Ws("-", paid.accountlines_id, paid.accountno) AS FEE_REFERENCE
FROM
  (SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 1), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 2), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 3), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 4), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 5), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 6), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 7), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 8), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 9), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 10), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 11), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 12), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 13), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 14), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 15), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 16), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 17), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 18), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 19), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 20), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 21), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 22), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 23), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 24), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 25), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 26), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 27), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 28), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 29), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 30), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 31), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 32), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 33), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 34), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 35), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 36), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 37), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 38), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 39), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 40), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 41), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 42), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 43), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 44), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 45), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 46), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 47), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 48), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 49), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 50), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 51), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 52), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 53), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 54), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 55), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 56), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 57), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 58), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 59), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)
  UNION
  SELECT
    SubString_Index(SubString_Index(Replace((Replace((Replace((SubString_Index(SubString_Index(action_logs.info, "'accountlines_paid' => [", -1), "]", 1)), " ", "")), '\n', '')), "'", ""), ",", 60), ",", -1) AS ACCTLINE,
    action_logs.info,
    accountlines.accountlines_id
  FROM
    action_logs JOIN
    accountlines
      ON action_logs.timestamp = accountlines.timestamp AND action_logs.user =
      accountlines.manager_id AND
      action_logs.object = accountlines.borrowernumber
  WHERE
    accountlines.accountno = SubString_Index(SubString_Index(action_logs.info,
    "'accountno' => '", -1), "'", 1) AND
    action_logs.module = 'FINES' AND
    action_logs.action Like '%CREAT%' AND
    action_logs.info LIKE "%accountlines_paid%" AND
    action_logs.info NOT LIKE "%create_writeoff%" AND
    Month(action_logs.timestamp) = Month(CurDate() - INTERVAL 1 MONTH) AND
    Year(action_logs.timestamp) = Year(CurDate() - INTERVAL 1 MONTH)) offsets
  JOIN
  accountlines payments
    ON payments.accountlines_id = offsets.accountlines_id JOIN
  accountlines paid
    ON offsets.ACCTLINE = paid.accountlines_id JOIN
  borrowers staff
    ON payments.manager_id = staff.borrowernumber JOIN
  borrowers patron
    ON payments.borrowernumber = patron.borrowernumber LEFT JOIN
  items
    ON paid.itemnumber = items.itemnumber
GROUP BY
  staff.branchcode, payments.amount, patron.cardnumber, Replace(payments.note,
  "\r\n", ""), payments.date, Concat_Ws("-", payments.accountlines_id,
  payments.accountno), items.barcode, items.homebranch, paid.date, paid.amount,
  payments.amountoutstanding, paid.description, Replace(paid.note, "\r\n", ""),
  Concat_Ws("-", paid.accountlines_id, paid.accountno)


