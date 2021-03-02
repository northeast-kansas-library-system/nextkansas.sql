/*
R.003239

----------

Name: GHW - Items declared lost by check out library and date
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-01 11:31:03
Modified on: 2020-02-22 20:06:38
Date last run: 2020-10-14 14:28:42

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of automatically created lost item fees and late fees that have been written off automatically</p>
<ul><li>Shows fees added or modified during the date range you specify</li>
<li>at the library you specify</li>
<li>grouped by issue id number and account offset id number</li>
<li>sorted by item lost date, item barcode number, account offset type</li>
<li>contains links to the patron's fee history</li>
</ul><br />
<p></p>
<p>Replaces report 888</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3239&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  old_issues.branchcode AS CHECK_OUT_BRANCH,
  Upper(items.barcode) AS ITEM_BC,
  items.itemlost_on AS LOST_ON_DATE,
  accountlines.description,
  account_offsets.type,
  Format(account_offsets.amount, 2) AS amount,
  Concat('<a href="/cgi-bin/koha/members/boraccount.pl?borrowernumber=', old_issues.borrowernumber, '" target="_blank">Go to patron account</a>') AS LINK
FROM
  old_issues
  JOIN items
    ON old_issues.itemnumber = items.itemnumber
  JOIN accountlines
    ON accountlines.issue_id = old_issues.issue_id
  JOIN account_offsets
    ON account_offsets.debit_id = accountlines.accountlines_id
WHERE
  old_issues.branchcode Like <<Choose your library|ZBRAN>> AND
  items.itemlost = 2 AND
  (items.itemlost_on BETWEEN <<Start date|date>> AND (<<End date|date>> + interval 1 day))AND
  (account_offsets.type = 'Lost item' OR
    account_offsets.type = 'Forgiven')
GROUP BY
  old_issues.issue_id,
  account_offsets.id
ORDER BY
  items.itemlost_on DESC,
  barcode DESC,
  account_offsets.type DESC



