/*
R.003110

----------

Name: GHW - Monthly F
Created by: George H Williams

----------

Group: Statistics
     Last calendar month

Created on: 2018-08-02 16:18:02
Modified on: 2018-09-25 10:54:29
Date last run: 2019-11-03 17:45:47

----------

Public: 0
Expiry: 300

----------

<div id="reportinfo">
<p>Generates monthly statistics for unique library accounts used at a library</p>
<ul><li>Shows unique library card useage counts for the previous calendar month (i.e. shows the number of unique library cards used last month)</li>
<li>At all Next Kansas libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Corresponds with column N on the monthly circulation spreadsheet for 2018.</p>
<p>This report is designed to run on Koha 17.11 and greater.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3110&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3110">Click here to download as a csv file</a></p>
</div>

----------
*/

SELECT
  Concat(Year(Now() - INTERVAL 1 MONTH), ".", LPad(Month(Now() - INTERVAL 1 MONTH), 2, 0)) AS YYYY_MM,
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
        Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
      GROUP BY
        statistics.branch) ACCT_USED ON branches.branchcode = ACCT_USED.branch
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode



