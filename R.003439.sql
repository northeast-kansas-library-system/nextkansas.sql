/*
R.003439

----------

Name: GHW - Monthly statistics - T
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-07 21:17:55
Modified on: 2021-02-07 21:37:14
Date last run: 2021-04-05 08:40:30

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column T</p>
<ul><li>Counts Borrowers added last month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3439&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3439">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(BORROWERSA.COUNT, 0) AS B_ADDED_LM
FROM
  branches LEFT JOIN
  (SELECT
     borrowers.branchcode,
     Count(*) AS COUNT
   FROM
     borrowers
   WHERE
     Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     borrowers.branchcode) BORROWERSA ON branches.branchcode =
      BORROWERSA.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode
LIMIT
  1000



