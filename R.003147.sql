/*
R.003147

----------

Name: GHW - Monthly action log count - ADMINREPORT
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2018-12-18 15:56:02
Modified on: 2019-02-05 15:11:44
Date last run: 2019-02-05 15:11:47

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Date(action_logs.timestamp) AS DATE,
  Count(action_logs.action_id) AS LOGGED_EVENTS
FROM
  action_logs
WHERE
  Year(action_logs.timestamp) = Year(Now() - INTERVAL 2 MONTH) AND
  Month(action_logs.timestamp) = Month(Now() - INTERVAL 2 MONTH)
GROUP BY
  Date(action_logs.timestamp)



