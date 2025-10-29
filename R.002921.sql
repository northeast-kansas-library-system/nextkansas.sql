/*
R.002921

----------

Name: GHW - Count of checkins during a specified date range
Created by: George Williams

----------

Group: Circulation
     Circ Stats

Created on: 2017-03-08 08:40:06
Modified on: 2024-01-17 11:49:23
Date last run: 2024-08-27 14:16:41

----------

Public: 0
Expiry: 0

----------

<div class="reportinfo noprint"> 
<p>Counts the number of items returned at a specified branch during a specified date range (and can be limited to specified days of the week)</p>
<ul><li>Counts returns during the date range you specify (the statistics table only covers the previous 25 months)</li>
<li>Counts returns at the library you specify</li>
<li>grouped and sorted by the branch where the items were checked in and the date the items were returned</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2921&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  statistics.branch AS CHECK_IN_BRANCH,
  CAST(statistics.datetime AS DATE) AS DATE,
  Date_Format(statistics.datetime, '%a') AS DAY,
  COUNT(*) AS RETURN_COUNT
FROM
  statistics
WHERE
  statistics.type = 'return' AND
  statistics.branch LIKE <> AND
  (CAST(statistics.datetime AS DATE) BETWEEN <> AND <>) AND
  Date_Format(statistics.datetime, '%a') LIKE <>
GROUP BY
  CHECK_IN_BRANCH,
  DATE

























