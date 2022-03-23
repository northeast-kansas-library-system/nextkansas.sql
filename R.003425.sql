/*
R.003425

----------

Name: GHW - Monthly statistics - E
Created by: George H Williams

----------

Group: Statistics
     End of month statistics

Created on: 2021-02-06 21:34:32
Modified on: 2021-02-06 21:57:18
Date last run: 2021-12-02 09:09:32

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column E</p>
<ul><li>Counts items added in the previous month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3425&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3425">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/



SELECT
  branches.branchcode AS BRANCH,
  Coalesce(Sum(DISTINCT ITEMS_ADDED.count), 0) AS ITEMS_ADD_L_M
FROM
  branches LEFT JOIN
  (SELECT
     items.homebranch,
     Count(*) AS count
   FROM
     items
   WHERE
     Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     items.homebranch
   UNION
   SELECT
     deleteditems.homebranch,
     Count(*) AS count
   FROM
     deleteditems
   WHERE
     Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     deleteditems.homebranch) ITEMS_ADDED ON branches.branchcode =
      ITEMS_ADDED.homebranch
GROUP BY
  branches.branchcode
LIMIT 1000

























