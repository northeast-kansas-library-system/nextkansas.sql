/*
R.003435

----------

Name: GHW - Monthly statistics - O
Created by: George H Williams

----------

Group: Statistics
     End of month statistics

Created on: 2021-02-06 22:42:51
Modified on: 2021-02-07 21:37:05
Date last run: 2021-02-07 21:38:07

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column O</p>
<ul><li>Counts checkouts and renewals of children's materials last month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3431&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3431">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/



SELECT
  branches.branchcode,
  Coalesce(YOUTH.count, 0) AS CR_YOUTH_LM
FROM
  branches LEFT JOIN
  (SELECT
     statistics.branch,
     Count(*) AS count
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
     statistics.location NOT LIKE "ADULT" AND
     statistics.location NOT LIKE "BALDADULT" AND
     statistics.location NOT LIKE "LVPLADULT" AND
     statistics.location NOT LIKE "PAOLAADULT"
   GROUP BY
     statistics.branch) YOUTH ON branches.branchcode = YOUTH.branch
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode
LIMIT
  1000

























