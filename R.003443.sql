/*
R.003443

----------

Name: GHW - Monthly statistics - X
Created by: George H Williams

----------

Group: Statistics
     End of month statistics

Created on: 2021-02-07 21:31:02
Modified on: 2021-02-07 21:32:00
Date last run: 2021-02-07 21:34:35

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column X</p>
<ul><li>Counts Next ILLs borrowed last month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3443&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3443">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/



SELECT
  branches.branchcode,
  Coalesce(ILL_BORROWED.count, 0) AS NX_ILL_BORROWED_LM
FROM
  branches LEFT JOIN
  (SELECT
     branchtransfers.tobranch,
     COUNT(*) AS count
   FROM
     branchtransfers LEFT JOIN
     items ON branchtransfers.itemnumber = items.itemnumber
   WHERE
     branchtransfers.tobranch <> items.homebranch AND
     Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH) AND
     branchtransfers.frombranch <> branchtransfers.tobranch AND
     branchtransfers.comments IS NULL
   GROUP BY
     branchtransfers.tobranch) ILL_BORROWED ON branches.branchcode =
      ILL_BORROWED.tobranch
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode
LIMIT
  1000

























