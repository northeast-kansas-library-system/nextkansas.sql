/*
R.003434

----------

Name: GHW - Monthly statistics - L
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-06 22:42:47
Modified on: 2021-02-06 22:52:48
Date last run: 2021-02-06 22:53:34

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column L</p>
<ul><li>Counts renewals only last month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3434&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3434">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(RENEW_LM.count, 0) AS RENEW_LM
FROM
  branches LEFT JOIN
  (SELECT
     statistics.branch,
     Count(*) AS count
   FROM
     statistics
   WHERE
     statistics.type = 'renew' AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     statistics.branch) RENEW_LM ON RENEW_LM.branch = branches.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode
LIMIT
  1000



