/*
R.003438

----------

Name: GHW - Monthly statistics - S
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-07 21:17:31
Modified on: 2021-02-07 21:37:12
Date last run: 2021-04-02 16:02:44

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column S</p>
<ul><li>Counts total borrowers at end of last month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3438&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3438">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(BORROWERS1.COUNT, 0) AS TOTAL_BORROWERS
FROM
  branches LEFT JOIN
  (SELECT
     borrowers.branchcode,
     Count(*) AS COUNT
   FROM
     borrowers
   WHERE
     borrowers.dateenrolled < AddDate(Last_Day(SubDate(Now(), INTERVAL
     1 MONTH)), 1)
   GROUP BY
     borrowers.branchcode) BORROWERS1 ON branches.branchcode =
      BORROWERS1.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode
LIMIT
  1000



