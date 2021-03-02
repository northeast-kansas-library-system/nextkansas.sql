/*
R.002874

----------

Name: GHW - Payments, Credits, and Writeoffs - Date Range
Created by: George H Williams

----------

Group: Fines/Fees
     -

Created on: 2017-01-04 12:34:28
Modified on: 2019-12-26 11:46:32
Date last run: 2020-06-11 13:58:03

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
<li>links</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2874&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

<p><span style="color: yellow; background-color: red; font-size: 200%;">References accountlines.accounttype.  Needs to be updated after January 4, 2020</span></p>

----------
*/

SELECT
  staff.branchcode AS PAYMENT_BRANCH,
  accountlines.timestamp,
  staff.cardnumber AS STAFF_LOGIN,
  Format(accountlines.amount, 2) AS AMOUNT,
  patrons.cardnumber AS PATRON,
  If(accountlines.accounttype = "Pay", "Payment", If(accountlines.accounttype = "C", "Credit", If(accountlines.accounttype = "W", "Writeoff", "-"))) AS PAYMENT_TYPE,
  Trim(Replace(accountlines.note, '\r\n', ' ')) AS NOTE
FROM
  accountlines LEFT JOIN
  borrowers staff
    ON staff.borrowernumber = accountlines.manager_id LEFT JOIN
  borrowers patrons
    ON accountlines.borrowernumber = patrons.borrowernumber
WHERE
  (accountlines.accounttype = "Pay" OR
    accountlines.accounttype = "C" OR
    accountlines.accounttype = "W") AND
  (accountlines.timestamp BETWEEN <<Between the beginning of the day on START DATE|date>>  AND (<<and the end of the day on END DATE|date>>+ INTERVAL 1 DAY)) AND
  staff.branchcode LIKE <<Choose branch|ZBRAN>> AND
  accountlines.accounttype LIKE <<Payment type|ZPAYTYPE>>
GROUP BY
  accountlines.accountlines_id
ORDER BY
  staff.branchcode,
  PAYMENT_TYPE,
  accountlines.timestamp



