/*
R.003441

----------

Name: GHW - Monthly statistics - V
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-07 21:18:39
Modified on: 2021-02-07 21:37:18
Date last run: 2021-02-07 21:38:18

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column V</p>
<ul><li>Counts borrowers deleted  last month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3441&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3441">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(BORROWESD.COUNT, 0) AS B_DELETED_LM
FROM
  branches LEFT JOIN
  (SELECT
     deletedborrowers.branchcode,
     Count(*) AS COUNT
   FROM
     action_logs JOIN
     deletedborrowers ON deletedborrowers.borrowernumber = action_logs.object
   WHERE
     action_logs.module = 'MEMBERS' AND
     Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
     action_logs.action LIKE 'DELET%'
   GROUP BY
     deletedborrowers.branchcode) BORROWESD ON branches.branchcode =
      BORROWESD.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode
LIMIT
  1000



