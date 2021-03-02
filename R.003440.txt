/*
R.003440

----------

Name: GHW - Monthly statistics - U
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-07 21:18:21
Modified on: 2021-02-07 21:37:16
Date last run: 2021-02-07 21:38:16

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column U</p>
<ul><li>Counts borrowers renewed  last month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3440&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3440">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(BORROWERSR.COUNT, 0) AS B_RENEWED_LM
FROM
  branches LEFT JOIN
  (SELECT
     borrowers.branchcode,
     Count(*) AS COUNT
   FROM
     borrowers
   WHERE
     Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     borrowers.branchcode) BORROWERSR ON branches.branchcode =
      BORROWERSR.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode
LIMIT
  1000



