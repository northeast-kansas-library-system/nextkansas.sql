/*
R.002853

----------

Name: GHW - Action Logs - previous 2 calendar months
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2016-12-14 08:35:31
Modified on: 2019-11-11 22:08:21
Date last run: 2020-01-14 08:28:29

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo class=noprint>
<p>Outputs any changes to system preferences in the last 10 days to a csv file</p>
<p><ins>Notes:</ins></p>
<p></p>
<p>Best to run via the link in this window.</p>
<p></p>
<p>Run monthly and store offsite</p>
<p></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=2853">Click here to download as a csv file</a></p>
</div>

----------
*/

SELECT
  action_logs.action_id,
  action_logs.timestamp,
  action_logs.user,
  action_logs.module,
  action_logs.action,
  action_logs.object,
  Replace(Replace(SUBSTRING(action_logs.info, 1, 40000), Char(13), '|Z|'), Char(10), '|Y|') AS INFO_ONE,
  Replace(Replace(SUBSTRING(action_logs.info, 40001, 40000), Char(13), '|Z|'), Char(10), '|Y|') AS INFO_TWO
FROM
  action_logs
WHERE
  action_logs.timestamp > AddDate(Last_Day(SubDate(Now(), INTERVAL 3 MONTH)), 1) AND
  action_logs.module = 'SYSTEMPREFERENCE'



