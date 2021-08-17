/*
R.003434

----------

Name: GHW - Monthly statistics - N
Created by: George H Williams

----------

Group: Statistics
     End of month statistics

Created on: 2021-02-06 22:42:47
Modified on: 2021-02-07 21:37:03
Date last run: 2021-02-07 21:38:07

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column N</p>
<ul><li>Counts checkouts and renewals of adult materials last month</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3432&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3432">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(ADULT.count, 0) AS CR_ADULT_LM
FROM
  branches LEFT JOIN
  (SELECT
     statistics.branch,
     Count(*) AS count
   FROM
     statistics
   WHERE
     (statistics.type = 'issue' OR
         statistics.type = 'renew') AND
     Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
     Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
     (statistics.location LIKE "%ADULT%" AND
         statistics.location NOT LIKE "%YOUNG%" OR
         statistics.location IS NULL)
   GROUP BY
     statistics.branch) ADULT ON branches.branchcode = ADULT.branch
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode
LIMIT
  1000



