/*
R.003288

----------

Name: GHW - Batch deleting fees
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-12-26 09:46:35
Modified on: 2021-12-17 11:36:41
Date last run: 2022-10-07 10:05:23

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
  <li>It looks for all accountlines where the issue_id is still in the old_issues table (i.e. when the item with the fee was returned within the last 13 months) AND the issuing library matches the specified library.</li>
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
  branchess.branchname,
  fees.date AS FEE_CREATED_ON,
  fees.credit_type_code,
  fees.debit_type_code,
  fees.accountlines_id,
  fees.issue_id,
  Format(fees.amountoutstanding, 2) AS AMOUNT_OUTSTANDING,
  items.itype AS ITEM_TYPE,
  Concat('-', Trim(Replace(fees.note, '\r\n', '||')), '-') AS note,
  fees.timestamp FEE_UPDATED_ON
FROM
  (SELECT
      branches.branchname,
      branches.branchcode
    FROM
      branches
    UNION
    SELECT
      ' All branches' AS branchname,
      '--' AS branchcode) branchess JOIN
  (SELECT
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.borrowernumber,
      accountlines.date,
      accountlines.credit_type_code,
      accountlines.debit_type_code,
      accountlines.status,
      accountlines.amountoutstanding,
      accountlines.timestamp,
      accountlines.note,
      accountlines.manager_id,
      Coalesce(Coalesce(issues.branchcode, old_issues.branchcode),
      '--') AS branchcode,
      accountlines.itemnumber
    FROM
      accountlines LEFT JOIN
      issues ON issues.issue_id = accountlines.issue_id LEFT JOIN
      old_issues ON old_issues.issue_id = accountlines.issue_id
    WHERE
      accountlines.amountoutstanding > 0 AND
      accountlines.borrowernumber IS NOT NULL
    GROUP BY
      accountlines.accountlines_id,
      accountlines.credit_type_code,
      accountlines.note,
      accountlines.itemnumber
    UNION
    SELECT
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.borrowernumber,
      accountlines.date,
      accountlines.credit_type_code,
      accountlines.debit_type_code,
      accountlines.status,
      accountlines.amountoutstanding,
      accountlines.timestamp,
      accountlines.note,
      accountlines.manager_id,
      Coalesce(staff.branchcode, '--') AS branchcode,
      accountlines.itemnumber
    FROM
      accountlines LEFT JOIN
      issues ON issues.issue_id = accountlines.issue_id LEFT JOIN
      old_issues ON old_issues.issue_id = accountlines.issue_id LEFT JOIN
      borrowers staff ON staff.borrowernumber = accountlines.manager_id
    WHERE
      accountlines.amountoutstanding > 0 AND
      accountlines.manager_id IS NOT NULL AND
      accountlines.borrowernumber IS NOT NULL
    GROUP BY
      accountlines.accountlines_id,
      accountlines.credit_type_code,
      accountlines.note,
      accountlines.itemnumber
    UNION
    SELECT
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.borrowernumber,
      accountlines.date,
      accountlines.credit_type_code,
      accountlines.debit_type_code,
      accountlines.status,
      accountlines.amountoutstanding,
      accountlines.timestamp,
      accountlines.note,
      accountlines.manager_id,
      Coalesce(borrowers.branchcode, '--') AS branchcode1,
      accountlines.itemnumber
    FROM
      accountlines LEFT JOIN
      issues ON issues.issue_id = accountlines.issue_id LEFT JOIN
      old_issues ON old_issues.issue_id = accountlines.issue_id LEFT JOIN
      borrowers staff ON staff.borrowernumber = accountlines.manager_id
      LEFT JOIN
      borrowers ON borrowers.borrowernumber = accountlines.borrowernumber
    WHERE
      accountlines.amountoutstanding > 0 AND
      Coalesce(issues.branchcode, old_issues.branchcode) IS NULL AND
      staff.branchcode IS NULL AND
      accountlines.borrowernumber IS NOT NULL
    GROUP BY
      accountlines.accountlines_id,
      accountlines.credit_type_code,
      accountlines.note,
      accountlines.itemnumber) fees ON fees.branchcode = branchess.branchcode
  LEFT JOIN
  items ON items.itemnumber = fees.itemnumber
WHERE
  branchess.branchcode LIKE <<Choose your library|ZBRAN>> AND
  fees.debit_type_code LIKE <<Debit type|LDEBITTYPE>>
GROUP BY
  fees.accountlines_id
ORDER BY
  branchess.branchname

























