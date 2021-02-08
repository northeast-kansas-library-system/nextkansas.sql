/*
R.003433

----------

Name: GHW - Monthly statistics - M
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-06 22:42:45
Modified on: 2021-02-06 22:52:50
Date last run: 2021-02-06 22:53:39

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column M</p>
<ul><li>Counts returns last month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3433&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3433">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(RETURN_LM.count, 0) AS RETURN_LM
FROM
  branches LEFT JOIN
  (SELECT
     statistics.branch,
     Count(*) AS count
   FROM
     statistics
   WHERE
     statistics.type = 'return' AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     statistics.branch) RETURN_LM ON RETURN_LM.branch = branches.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode
LIMIT
  1000



