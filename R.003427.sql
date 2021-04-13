/*
R.003427

----------

Name: GHW - Monthly statistics - G
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-06 21:35:12
Modified on: 2021-02-06 21:55:05
Date last run: 2021-03-08 14:43:06

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column G</p>
<ul><li>Counts total bibliographic records held by a library on the final day of the previous month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3427&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3427">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode AS BRANCH,
  Coalesce(Sum(DISTINCT TOTAL_HOLDINGS.count), 0) AS TOTAL_HOLDINGS
FROM
  branches LEFT JOIN
  (SELECT
     items.homebranch,
     Count(DISTINCT items.biblionumber) AS count
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
     Count(DISTINCT deleteditems.biblionumber) AS count
   FROM
     deleteditems
   WHERE
     deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1
     MONTH)), 1) AND
     deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 1
     MONTH)), 1)
   GROUP BY
     deleteditems.homebranch) TOTAL_HOLDINGS ON branches.branchcode =
      TOTAL_HOLDINGS.homebranch
GROUP BY
  branches.branchcode
LIMIT 1000



