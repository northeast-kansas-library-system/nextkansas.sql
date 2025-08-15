/*
R.002853

----------

Name: GHW - Action Logs - previous 2 calendar months
Created by: George Williams

----------

Group: -
     -

Created on: 2016-12-14 08:35:31
Modified on: 2024-01-17 11:46:45
Date last run: 2023-02-22 22:18:55

----------

Public: 0
Expiry: 0

----------

 
Outputs any changes to system preferences in the last 10 days to a csv file
Notes:

Best to run via the link in this window.

Run monthly and store offsite

Click here to download as a csv file


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
  action_logs.timestamp &gt; AddDate(Last_Day(SubDate(Now(), INTERVAL 3 MONTH)), 1) AND
  action_logs.module = 'reports' AND 
  action_logs.object = "2946"

























