/*
R.003437

----------

Name: GHW - Monthly statistics - R
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-07 21:17:16
Modified on: 2021-02-07 21:37:10
Date last run: 2021-04-02 16:02:41

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column R</p>
<ul><li>Counts borrower accounts used to checkout items last month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3437&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3437">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(ACCT_USED.count, 0) AS BORROWER_ACCT_USED_LM
FROM
  branches LEFT JOIN
  (SELECT
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
     statistics.branch) ACCT_USED ON ACCT_USED.branch = branches.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode
LIMIT
  1000



