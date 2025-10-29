/*
R.003837

----------

Name: In progress report for login failures
Created by: George Williams

----------

Group: -
     -

Created on: 2024-05-31 17:46:39
Modified on: 2024-06-05 15:13:25
Date last run: 2024-06-05 15:18:07

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  action_logs.interface,
  borrowers.branchcode,
  borrowers.userid,
  Count(DISTINCT action_logs.object) AS ACCOUNT_COUNT,
  Count(DISTINCT action_logs.action_id) AS ATTEMPT_COUNT
FROM
  action_logs LEFT JOIN
  borrowers ON borrowers.borrowernumber = action_logs.user
WHERE
  action_logs.module = 'AUTH' AND
  action_logs.action = 'FAILURE' AND
  Year(action_logs.timestamp) = 2024 AND
  Month(action_logs.timestamp) = 5 AND
  action_logs.object <> 0
GROUP BY
  action_logs.interface,
  borrowers.branchcode,
  borrowers.userid
ORDER BY
  borrowers.branchcode,
  borrowers.userid

























