/*
R.003022

----------

Name: GHW - Paypal report - previous calendar month
Created by: George Williams

----------

Group: Fines/Fees
     -

Created on: 2017-12-22 16:12:49
Modified on: 2024-01-17 11:52:16
Date last run: 2024-07-16 15:48:41

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a report of payments made to libraries via Paypal in the previous calendar month&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows payments made in the previous calendar month&lt;/li&gt;
&lt;li&gt;At all libraries&lt;/li&gt;
&lt;li&gt;grouped by account offsets ID&lt;/li&gt;
&lt;li&gt;sorted by library owed the fee, payment date, and fee reference ID&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickopen"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3022&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;
&lt;p&gt;&lt;span style="color: yellow; background-color: red; font-size: 200%;"&gt;References accountlines.accounttype.  Needs to be updated after January 4, 2020&lt;/span&gt;&lt;/p&gt;

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
  ) AS COLLECTED_ON_BEHALF_OF /&ast; Test comment &ast;/,
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
  credits.note LIKE "%Paypal%" AND
  Month(credits.date) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(credits.date) = Year(Now() - INTERVAL 1 MONTH) AND
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

























