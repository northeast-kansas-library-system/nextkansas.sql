/*
R.003045

----------

Name: GHW - Deleted reports - last 60 days
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2018-01-23 10:00:34
Modified on: 2019-03-28 10:56:34
Date last run: 2022-08-11 11:14:30

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  action_logs.action_id,
  action_logs.timestamp,
  borrowers.userid,
  action_logs.module,
  action_logs.action,
  action_logs.object,
  action_logs.info,
  action_logs.interface
FROM
  action_logs
  LEFT JOIN borrowers
    ON borrowers.borrowernumber = action_logs.user
WHERE
  action_logs.module = 'REPORTS' AND
  action_logs.action LIKE 'DELE%'
GROUP BY
  action_logs.action_id,
  borrowers.userid

























