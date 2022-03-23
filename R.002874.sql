/*
R.002874

----------

Name: GHW - Payments, Credits, and Writeoffs - Date Range
Created by: George H Williams

----------

Group: Fines/Fees
     -

Created on: 2017-01-04 12:34:28
Modified on: 2021-05-07 09:30:17
Date last run: 2022-02-08 10:54:31

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Reports on fee payment/credit/writeoff activity at a library</p>
<ul><li>Shows activity during a specified date range (between the beginning of the day on the specified "START DATE" to the end of the day on the specified "END DATE")</li>
<li>Shows all fees collected/processed at a specified library</li>
<li>grouped by accountlines_id</li>
<li>sorted by payment locttion, payment type, payment timestamp</li>
<li>links to the payment accountline details page</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Updated may 5, 2021.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2874&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

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
    '<a href="https://staff.nextkansas.org/cgi-bin/koha/members/accountline-details.pl?accountlines_id=', 
    accountlines.accountlines_id, 
    '" target="_blank">Go to transaction</a>'
  ) AS LINK_TO_PAYMENT
FROM
  accountlines LEFT JOIN
  borrowers staff ON staff.borrowernumber = accountlines.manager_id LEFT JOIN
  borrowers patrons ON accountlines.borrowernumber = patrons.borrowernumber
WHERE
  staff.branchcode LIKE <<Choose your library|LBRANCH>> AND
  staff.categorycode = 'STAFF' AND
  accountlines.credit_type_code IS NOT NULL AND
  accountlines.timestamp BETWEEN <<Between the beginning of the day on START DATE|date>> AND <<and the end of the day on END DATE|date>> + INTERVAL 1 DAY
GROUP BY
  accountlines.accountlines_id
ORDER BY
  PAYMENT_BRANCH,
  accountlines.timestamp,
  accountlines.accountlines_id

























