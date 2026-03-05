/*
R.003239

----------

Name: GHW - Items declared lost by check out library and date
Created by: George Williams

----------

Group: -
     -

Created on: 2019-08-01 11:31:03
Modified on: 2024-01-17 12:08:37
Date last run: 2025-02-05 12:46:38

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of automatically created lost item fees and late fees that have been written off automatically&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows fees added or modified during the date range you specify&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped by issue id number and account offset id number&lt;/li&gt;
&lt;li&gt;sorted by item lost date, item barcode number, account offset type&lt;/li&gt;
&lt;li&gt;contains links to the patron's fee history&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Replaces report 888&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3239&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  old_issues.branchcode AS CHECK_OUT_BRANCH,
  Upper(items.barcode) AS ITEM_BC,
  items.itemlost_on AS LOST_ON_DATE,
  accountlines.description,
  account_offsets.type,
  Format(account_offsets.amount, 2) AS amount,
  Concat('Go to patron account') AS LINK
FROM
  old_issues
  JOIN items
    ON old_issues.itemnumber = items.itemnumber
  JOIN accountlines
    ON accountlines.issue_id = old_issues.issue_id
  JOIN account_offsets
    ON account_offsets.debit_id = accountlines.accountlines_id
WHERE
  old_issues.branchcode Like &lt;&gt; AND
  items.itemlost = 2 AND
  (items.itemlost_on BETWEEN &lt;&gt; AND (&lt;&gt; + interval 1 day))AND
  (account_offsets.type = 'Lost item' OR
    account_offsets.type = 'Forgiven')
GROUP BY
  old_issues.issue_id,
  account_offsets.id
ORDER BY
  items.itemlost_on DESC,
  barcode DESC,
  account_offsets.type DESC

























