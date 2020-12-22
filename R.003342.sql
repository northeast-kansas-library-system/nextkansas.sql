/*
R.003342

----------

Name: GHW - Action logs - Item number lookup
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-08-13 14:10:41
Modified on: 2020-08-13 14:10:41
Date last run: 2020-12-18 14:13:05

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  action_logs.action_id,
  action_logs.timestamp,
  action_logs.user,
  action_logs.module,
  action_logs.action,
  action_logs.object,
  action_logs.info,
  action_logs.interface
FROM
  action_logs
WHERE
  action_logs.info LIKE Concat("%'itemnumber' => ", <<Enter item number>>, "%")



