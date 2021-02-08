/*
R.003435

----------

Name: GHW - Monthly statistics - K
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-06 22:42:51
Modified on: 2021-02-06 22:52:46
Date last run: 2021-02-06 22:53:31

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column K</p>
<ul><li>Counts checkouts only last month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3435&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3435">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(CKO_LM.count, 0) AS CHECKOUT_LM
FROM
  branches LEFT JOIN
  (SELECT
     statistics.branch,
     Count(*) AS count
   FROM
     statistics
   WHERE
     statistics.type = 'issue' AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     statistics.branch) CKO_LM ON CKO_LM.branch = branches.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode
LIMIT
  1000



