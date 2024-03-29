/*
R.003024

----------

Name: GHW - Cronjobs by name and date range
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-12-27 10:45:27
Modified on: 2018-04-16 11:13:34
Date last run: 2021-07-01 13:32:14

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Shows the time a cronjob ran on the date specified within the previous 60 days</p>
<ul><li>Shows cronojb run times during the date range you specify</li>
<li>shows runtimes for cronjobs system wide</li>
<li>grouped by the actionlog ID for the cronjob</li>
<li>sorted by the date and time the cronjob ran - newest dates to oldest dates</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3024&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Date_Format(action_logs.timestamp, "%Y-%m-%d") AS DATE,
  action_logs.info,
  action_logs.action_id,
  DATE_FORMAT(action_logs.timestamp, '%T') as TIME_OF_DAY
FROM
  action_logs
WHERE
  action_logs.module = 'CRONJOBS' AND
  action_logs.info LIKE <<Choose a cronjob|LCRONJOBS>> AND
  action_logs.timestamp BETWEEN <<Between start date|date>> AND (<<end date|date>> + interval 1 day)
GROUP BY
  action_logs.action_id
ORDER BY
  action_logs.timestamp DESC

























