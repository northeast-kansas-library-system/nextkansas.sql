/*
R.003040

----------

Name: GHW - Request action logs by request ID
Created by: George Williams

----------

Group: -
     -

Created on: 2018-01-16 22:16:46
Modified on: 2024-01-17 11:58:32
Date last run: 2025-08-06 16:53:40

----------

Public: 0
Expiry: 300

----------

 
Shows action log entries for specific requests from the last 60 days
Shows actions that happened within the last 60 days
on the request you specify
grouped and sorted by action log ID

Notes:

Data from the action logs is purged once it is 60 days old.  This report cannot show you information about request modifications if those modifications happened more than 60 days ago.

Click here to run in a new window


----------
*/



SELECT
  action_logs.action_id,
  action_logs.timestamp,
  action_logs.user,
  action_logs.module,
  action_logs.action,
  action_logs.object,
  REPLACE(action_logs.info, ",", ",") AS DESCRIPTION,
  action_logs.interface,
  CONCAT("See who created/modified/cancelled the request") AS LINK
FROM
  action_logs
WHERE
  action_logs.module = 'HOLDS' AND
  action_logs.object LIKE Concat("%", &lt;&gt;, "%")
GROUP BY
  action_logs.action_id
ORDER BY
  action_logs.action_id
  DESC

























