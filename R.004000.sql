/*
R.004000

----------

Name: GHW - Action logs report - first draft
Created by: George Williams

----------

Group: -
     -

Created on: 2026-09-23 13:48:42
Modified on: 2026-09-23 15:00:20
Date last run: 2026-09-23 15:00:32

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
  action_logs.interface,
  action_logs.script,
  action_logs.trace,
  action_logs.diff,
  borrowers.cardnumber
FROM
  action_logs INNER JOIN
  borrowers ON borrowers.borrowernumber = action_logs.object
WHERE
  (action_logs.module = 'MEMBERS' OR
    action_logs.module = 'CIRCULATION' OR
    action_logs.module = 'HOLDS') AND
  borrowers.cardnumber = <<Enter borrowers's library card number>>
GROUP BY
  action_logs.action_id
ORDER BY
  action_logs.action_id DESC

























