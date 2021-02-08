/*
R.003428

----------

Name: GHW - Monthly statistics - H
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2021-02-06 21:35:15
Modified on: 2021-02-06 21:55:03
Date last run: 2021-02-06 21:55:55

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column H</p>
<ul><li>Counts bibliographic records added in the previous month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3428&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3428">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode AS BRANCH,
  Coalesce(HOLDINGS_ADDED.count, 0) AS HOLD_ADD_L_M
FROM
  branches LEFT JOIN
  (SELECT
     items.homebranch,
     Count(DISTINCT items.biblionumber) AS count
   FROM
     biblio JOIN
     items ON items.biblionumber = biblio.biblionumber
   WHERE
     Month(biblio.datecreated) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(biblio.datecreated) = Year(Now() - INTERVAL 1 MONTH)
   GROUP BY
     items.homebranch) HOLDINGS_ADDED ON branches.branchcode =
      HOLDINGS_ADDED.homebranch
GROUP BY
  branches.branchcode
LIMIT 1000



