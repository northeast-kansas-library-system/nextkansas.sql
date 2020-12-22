/*
R.003105

----------

Name: GHW - Monthly A
Created by: George H Williams

----------

Group: Statistics
     Last calendar month

Created on: 2018-08-02 15:27:16
Modified on: 2018-09-25 10:53:53
Date last run: 2020-11-23 09:02:45

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates monthly statistics for combined checkouts and renewals</p>
<ul><li>Shows checkout and renewal counts for the previous calendar month</li>
<li>At all Next Kansas libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Corresponds with column J on the monthly circulation spreadsheet for 2018.</p>
<p>This report is designed to run on Koha 17.11 and greater.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3105&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3105">Click here to download as a csv file</a></p>
</div>

----------
*/

SELECT
  Concat(Year(Now() - INTERVAL 1 MONTH), ".", LPad(Month(Now() - INTERVAL 1 MONTH), 2, 0)) AS YYYY_MM,
  branches.branchcode,
  Coalesce(CIR_RENEW_LM.count, 0) AS CHECKOUT_RENEW_LM
FROM
  branches
  LEFT JOIN (SELECT
        statistics.branch,
        Count(*) AS count
      FROM
        statistics
      WHERE
        (statistics.type = 'issue' OR
          statistics.type = 'renew') AND
        Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
        Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
      GROUP BY
        statistics.branch) CIR_RENEW_LM ON branches.branchcode = CIR_RENEW_LM.branch
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode



