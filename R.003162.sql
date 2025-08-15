/*
R.003162

----------

Name: GHW - Paypal report - date range
Created by: George Williams

----------

Group: -
     -

Created on: 2019-01-28 12:16:43
Modified on: 2024-01-17 11:55:32
Date last run: 2023-06-12 16:43:21

----------

Public: 0
Expiry: 300

----------

 
Generates a report of payments made to libraries via Paypal in a date range
Shows payments made in the date range you specify
At all libraries
grouped by account offsets ID
sorted by library owed the fee, payment date, and fee reference ID

Notes:

Due to changes in the database during the upgrade in July of 2018, this report will not work for any fees collected before July 8, 2018

Click here to run in a new window


References accountlines.accounttype.  Needs to be updated after January 4, 2020

----------
*/



SELECT
  borrowerinfo.branchcode AS COLLECTED_AT,
  If(
    debits.accounttype = 'F',
    Coalesce(old_issues.branchcode, borrowerinfo.branchcode),
    If(
      debits.accounttype = 'M',
      Coalesce(manualinvoiceinfo.branchcode, borrowerinfo.branchcode),
      If(
        debits.accounttype = 'L',
        Coalesce(items.homebranch, Coalesce(manualinvoiceinfo.branchcode, borrowerinfo.branchcode)),
        borrowerinfo.branchcode
      )
    )
  ) AS COLLECTED_ON_BEHALF_OF,
  Format(ABS(credits.amount), 2) AS AMT_COLLECTED,
  borrowerinfo.cardnumber AS FROM_PATRON,
  credits.note AS PAYMENT_NOTES,
  credits.date AS PAYMENT_DATE,
  Concat_Ws("-", credits.accountlines_id, credits.accountno) AS PAYMENT_REFERENCE,
  If(items.barcode IS NULL, "DELETED", Upper(items.barcode)) AS FOR_ITEM,
  If(items.homebranch IS NULL, "DELETED", items.homebranch) AS OWNED_BY,
  debits.date AS FEE_DATE,
  Format(ABS(account_offsets.amount), 2) AS FEE_AMOUNT,
  If(
    Format((debits.amount + account_offsets.amount), 2) = 0,
    "-", Format((debits.amount + account_offsets.amount), 2)
  ) AS PREVIOUS_PAYMENTS,
  Format(debits.amountoutstanding, 2) AS FEE_STILL_OWED,
  debits.description AS FEE_DESCRIPTION,
  debits.note AS FEE_NOTE,
  Concat_Ws("-", debits.accountlines_id, debits.accountno) AS FEE_REFERENCE
FROM
  accountlines credits
  JOIN account_offsets ON account_offsets.credit_id = credits.accountlines_id
  JOIN accountlines debits ON account_offsets.debit_id = debits.accountlines_id
  LEFT JOIN old_issues ON debits.issue_id = old_issues.issue_id
  LEFT JOIN items ON debits.itemnumber = items.itemnumber
  JOIN borrowers borrowerinfo ON borrowerinfo.borrowernumber = credits.borrowernumber
  LEFT JOIN borrowers manualinvoiceinfo ON manualinvoiceinfo.borrowernumber = debits.manager_id
WHERE
  (credits.note LIKE "%Paypal%" AND
  credits.date BETWEEN &lt;&gt; AND (&lt;&gt; + interval 1 day)) AND
  If(
    debits.accounttype = 'F',
    Coalesce(old_issues.branchcode, borrowerinfo.branchcode),
    If(
      debits.accounttype = 'M',
      Coalesce(manualinvoiceinfo.branchcode, borrowerinfo.branchcode),
      If(
        debits.accounttype = 'L',
        Coalesce(items.homebranch, Coalesce(manualinvoiceinfo.branchcode, borrowerinfo.branchcode)),
        borrowerinfo.branchcode
      )
    )
  ) LIKE &lt;&gt;
GROUP BY
  account_offsets.id
ORDER BY
  COLLECTED_ON_BEHALF_OF,
  PAYMENT_DATE,
  FEE_REFERENCE

























