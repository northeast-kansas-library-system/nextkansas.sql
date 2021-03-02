/*
R.003442

----------

Name: GHW - Monthly statistics - W
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-07 21:30:57
Modified on: 2021-02-07 21:31:45
Date last run: 2021-02-07 21:34:30

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column W</p>
<ul><li>Counts Next ILLs loaned last month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3442&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3442">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(ILL_LOANED.count, 0) AS NX_ILL_LOANED_LM
FROM
  branches LEFT JOIN
  (SELECT
     items.homebranch,
     COUNT(*) AS count
   FROM
     branchtransfers LEFT JOIN
     items ON branchtransfers.itemnumber = items.itemnumber
   WHERE
     items.homebranch <> branchtransfers.tobranch AND
     Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH) AND
     Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH) AND
     branchtransfers.tobranch <> branchtransfers.frombranch AND
     branchtransfers.comments IS NULL
   GROUP BY
     items.homebranch) ILL_LOANED ON branches.branchcode = ILL_LOANED.homebranch
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode
LIMIT
  1000



