/*
R.003288

----------

Name: GHW - Batch deleting fees
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-12-26 09:46:35
Modified on: 2021-01-17 13:30:24
Date last run: 2021-01-17 14:33:38

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for batch deleting fees</p>
<ul><li>Shows current outstanding fees</li>
<li>at the library you specify</li>
<li>grouped by accountline ID number</li>
<li>sorted by library and fee date</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>When a library decides to remove all old late fees from all of their patron's accounts, run this report, determine which fees are for late fees, and send the list of accountline_id numbers to ByWater Solutions asking them to set the amount.outstanding to $0.00.</p>
<p></p>
<p>The process this report uses works along 4 pathways</p>
<ul>
  <li>It looks for all accountlines where the issue_id is still in the issues table (i.e. item with fee is still checked out to the patron) AND the issuing library matches the specified library.</li>
  <li>It looks for all accountlines where the issue_id is still in the old_issues table (i.e. when the item with the fee was returned within the last ) AND the issuing library matches the specified library.</li>
  <li>It looks for all accountlines that were created manually based on the home library of the account manually creating the fee.</li>
  <li>It looks for all accountlines where the patron's home library matches the specified library AND the issue_id is null (i.e. no data about where the item was checked out) AND where the manager's ID is also null.  These are generally fees that have gone unpaid for such a long time that there is no longer any way to determine where the item was checked out.</li>
</ul>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3288&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">tag goes here</p>
</div>

----------
*/

SELECT
  outstanding_fees.branchcode,
  outstanding_fees.date,
  outstanding_fees.credit_type_code,
  outstanding_fees.debit_type_code,
  outstanding_fees.accountlines_id,
  outstanding_fees.status,
  Format(outstanding_fees.amountoutstanding, 2) AS amountoutstanding,
  Concat('-', Trim(Replace(outstanding_fees.note, '\r\n', '||')), '-') AS note
FROM
  (SELECT
      issues.branchcode,
      accountlines.date,
      accountlines.accountlines_id,
      accountlines.credit_type_code,
      accountlines.debit_type_code,
      accountlines.status,
      accountlines.amountoutstanding,
      accountlines.note,
      accountlines.borrowernumber
    FROM
      accountlines JOIN
      issues ON issues.issue_id = accountlines.issue_id
    WHERE
      accountlines.amountoutstanding > 0
    GROUP BY
      accountlines.accountlines_id,
      accountlines.credit_type_code,
      accountlines.debit_type_code,
      accountlines.status
    UNION
    SELECT
      old_issues.branchcode,
      accountlines.date,
      accountlines.accountlines_id,
      accountlines.credit_type_code,
      accountlines.debit_type_code,
      accountlines.status,
      accountlines.amountoutstanding,
      accountlines.note,
      accountlines.borrowernumber
    FROM
      accountlines JOIN
      old_issues ON old_issues.issue_id = accountlines.issue_id
    WHERE
      accountlines.amountoutstanding > 0
    GROUP BY
      accountlines.accountlines_id,
      accountlines.status
    UNION
    SELECT
      borrowers.branchcode,
      accountlines.date,
      accountlines.accountlines_id,
      accountlines.credit_type_code,
      accountlines.debit_type_code,
      accountlines.status,
      accountlines.amountoutstanding,
      accountlines.note,
      accountlines.borrowernumber
    FROM
      accountlines JOIN
      borrowers ON borrowers.borrowernumber = accountlines.manager_id
    WHERE
      accountlines.amountoutstanding > 0
    GROUP BY
      accountlines.accountlines_id,
      accountlines.status
    UNION
    SELECT
      borrowers.branchcode,
      accountlines.date,
      accountlines.accountlines_id,
      accountlines.credit_type_code,
      accountlines.debit_type_code,
      accountlines.status,
      accountlines.amountoutstanding,
      accountlines.note,
      accountlines.borrowernumber
    FROM
      accountlines JOIN
      borrowers ON accountlines.borrowernumber = borrowers.borrowernumber
    WHERE
      accountlines.amountoutstanding > 0 AND
      (accountlines.issue_id IS NULL OR
          accountlines.issue_id = "" OR
          accountlines.issue_id = "0") AND
      (accountlines.manager_id IS NULL OR
          accountlines.manager_id = "" OR
          accountlines.manager_id = "0")
    GROUP BY
      accountlines.accountlines_id,
      accountlines.status) outstanding_fees
WHERE
  outstanding_fees.branchcode LIKE <<Choose your library|ZBRAN>> AND
  outstanding_fees.debit_type_code LIKE <<Debit type|LDEBITTYPE>>
GROUP BY
  outstanding_fees.credit_type_code,
  outstanding_fees.debit_type_code,
  outstanding_fees.accountlines_id
ORDER BY
  outstanding_fees.branchcode,
  outstanding_fees.date



