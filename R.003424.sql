/*
R.003424

----------

Name: GHW - Monthly statistics - D
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-06 21:34:21
Modified on: 2021-02-06 21:57:14
Date last run: 2021-02-06 21:57:23

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column D</p>
<ul><li>Counts items in the collection on the last day of last month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3424&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3424">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode AS BRANCH,
  Coalesce(Sum(DISTINCT END_ITEMS.count), 0) AS END_I
FROM
  branches LEFT JOIN
  (SELECT
     items.homebranch,
     Count(*) AS count
   FROM
     items
   WHERE
     items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)),
     1)
   GROUP BY
     items.homebranch
   UNION
   SELECT
     deleteditems.homebranch,
     Count(*) AS count
   FROM
     deleteditems
   WHERE
     deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1
     MONTH)), 1) AND
     deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 1
     MONTH)), 1)
   GROUP BY
     deleteditems.homebranch) END_ITEMS ON branches.branchcode =
      END_ITEMS.homebranch
GROUP BY
  branches.branchcode
LIMIT 1000



