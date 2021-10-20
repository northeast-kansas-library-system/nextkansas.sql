/*
R.003429

----------

Name: GHW - Monthly statistics - I
Created by: George H Williams

----------

Group: Statistics
     End of month statistics

Created on: 2021-02-06 21:35:20
Modified on: 2021-02-06 21:55:00
Date last run: 2021-02-06 21:55:57

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column I</p>
<ul><li>Counts bibliographic records deleted in the previous month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3429&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3429">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/



SELECT
  branches.branchcode AS BRANCH,
  Coalesce(HOLDINGS_DELETED.count, 0) AS HOLD_DEL_L_M
FROM
  branches LEFT JOIN
  (SELECT
     deleteditems.homebranch,
     Count(DISTINCT deleteditems.biblionumber) AS count
   FROM
     deleteditems JOIN
     deletedbiblio ON deletedbiblio.biblionumber = deleteditems.biblionumber
   WHERE
     Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     deleteditems.homebranch) HOLDINGS_DELETED ON branches.branchcode =
      HOLDINGS_DELETED.homebranch
GROUP BY
  branches.branchcode
LIMIT 1000

























