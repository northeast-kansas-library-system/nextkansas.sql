/*
R.003836

----------

Name: invalid username attempts
Created by: George Williams

----------

Group: -
     -

Created on: 2024-05-31 17:30:12
Modified on: 2024-05-31 17:46:14
Date last run: 2024-06-05 15:18:04

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  action_logs.interface,
  Count(action_logs.action_id) AS Count_action_id
FROM
  action_logs
WHERE
  action_logs.module = 'AUTH' AND
  action_logs.action = 'FAILURE' AND
  action_logs.object = 0 AND
  Year(action_logs.timestamp) = 2024 AND
  Month(action_logs.timestamp) = 4
GROUP BY
  action_logs.interface

























