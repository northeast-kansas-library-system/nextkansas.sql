/*
R.003133

----------

Name: GHW - Unique borrowers by date range
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-10-29 16:17:17
Modified on: 2018-10-29 22:53:48
Date last run: 2021-03-09 17:35:22

----------

Public: 0
Expiry: 300

----------

<div id="reportinfo">
<p>Generates statistics for unique library accounts used at a library</p>
<ul><li>Shows unique library card useage counts during the date range specified (up to the previous 25 months)</li>
<li>At all Next Kansas libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Corresponds with column N on the monthly circulation spreadsheet for 2018.</p>
<p>This report is designed to run on Koha 17.11 and greater.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3133&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(ACCT_USED.count, 0) AS PATRON_LM
FROM
  branches
  LEFT JOIN (SELECT
        statistics.branch,
        Count(DISTINCT statistics.borrowernumber) AS count
      FROM
        statistics
      WHERE
        (statistics.type = 'issue' OR
          statistics.type = 'renew' OR
          statistics.type = 'localuse') AND
          (statistics.datetime BETWEEN <<Between start date|date>> AND (<<end date|date>> + interval 1 day))
      GROUP BY
        statistics.branch) ACCT_USED ON branches.branchcode = ACCT_USED.branch
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode



