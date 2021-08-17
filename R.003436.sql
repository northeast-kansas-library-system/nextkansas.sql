/*
R.003436

----------

Name: GHW - Monthly statistics - P
Created by: George H Williams

----------

Group: Statistics
     End of month statistics

Created on: 2021-02-06 22:42:55
Modified on: 2021-02-07 21:37:07
Date last run: 2021-02-07 21:38:07

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates data for the monthly statistics report - column P</p>
<ul><li>Counts checkouts and renewals of 4 3/4 inch video discs (DVD/Blu-ray/HD DVD, etc)</li>
<li>At all Next Search Catalog libraries</li>
<li>grouped and sorted by branchcode</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3430&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3430">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">monthly statistics iko</p>
</div>

----------
*/

SELECT
  branches.branchcode,
  Coalesce(DVD_CIRC_RENEW_LM.count, 0) AS CR_VIDEO_DISC_LM
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
     statistics.itemtype LIKE "NVID%" AND
     (statistics.ccode LIKE "DVD" OR
         statistics.ccode LIKE "BLU-RAY" OR
         statistics.ccode LIKE "COMBO" OR
         statistics.ccode LIKE "TVSERIES")
   GROUP BY
     statistics.branch) DVD_CIRC_RENEW_LM ON DVD_CIRC_RENEW_LM.branch =
      branches.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchcode
LIMIT
  1000



