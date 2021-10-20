/*
R.003023

----------

Name: GHW - Cronjob count
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-12-27 10:35:28
Modified on: 2018-04-16 11:13:30
Date last run: 2018-01-24 14:25:53

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Counts the number of times a specified cronjob has run in the previous 60 days</p>
<ul><li>Counts cronjobs run in the previuos 60 days</li>
<li>system-wide</li>
<li>grouped by date and cronjob name</li>
<li>sorted by date - newest to oldest</li>
<li>Contains links to report 3024 which allows you to see the specific times the cronjob ran on that date</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3023&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Date_Format(action_logs.timestamp, "%Y-%m-%d") AS DATE,
  action_logs.info,
  Count(action_logs.action_id) AS COUNT,
  Concat("<a href='/cgi-bin/koha/reports/guided_reports.pl?reports=3024&phase=Run+this+report&sql_params=", action_logs.info, "%25&sql_params=", Date_Format(action_logs.timestamp, '%m'), "%2F", Date_Format(action_logs.timestamp, '%d'), "%2F", Date_Format(action_logs.timestamp, '%Y'), "&sql_params=", Date_Format(action_logs.timestamp, '%m'), "%2F", Date_Format(action_logs.timestamp, '%d'), "%2F", Date_Format(action_logs.timestamp, '%Y'), "' target='_blank'>See when this cronjob ran on this date</a>") AS LINK
FROM
  action_logs
WHERE
  action_logs.module = 'CRONJOBS' AND
  action_logs.info LIKE <<Choose a cronjob|LCRONJOBS>>
GROUP BY
  Date_Format(action_logs.timestamp, "%Y.%m.%d"),
  action_logs.info
ORDER BY
  DATE DESC, action_logs.info ASC

























