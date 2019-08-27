/*
R.003064

----------

Name: GHW - Request action logs by borrower number/user ID and date range
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-03-15 15:05:04
Modified on: 2018-03-15 15:21:12
Date last run: 2018-08-08 09:28:50

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
  Replace(action_logs.info, ",", ",<br />") AS DESCRIPTION,
  action_logs.interface,
  Concat("<a href='/cgi-bin/koha/circ/circulation.pl?borrowernumber=", action_logs.user, "' target='_blank'>See who created/modified/cancelled the request</a>") AS LINK
FROM
  action_logs
WHERE
  action_logs.module = 'HOLDS' AND
  action_logs.user = <<Enter borrower number / user ID>> AND
  action_logs.timestamp BETWEEN <<Between this date|date>> AND (<<this date|date>> + interval 1 day)
GROUP BY
  action_logs.action_id
HAVING
  DESCRIPTION like "%225558%"
ORDER BY
  action_logs.action_id DESC



