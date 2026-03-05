/*
R.003278

----------

Name: GHW - message push ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2019-10-10 08:58:10
Modified on: 2019-10-10 08:59:36
Date last run: 2019-10-10 09:10:02

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  reserves.branchcode,
  Concat('Open in new window') AS LINK,
  Count(reserves.reserve_id) AS Count_reserve_id,
  reserves.suspend_until,
  messagess.message
FROM
  reserves
  LEFT JOIN (
    SELECT
      messages.message_id,
      messages.borrowernumber,
      messages.branchcode,
      messages.message_type,
      messages.message,
      messages.message_date,
      messages.manager_id
    FROM
      messages
    WHERE
      messages.manager_id = 224610
  ) messagess
    ON messagess.borrowernumber = reserves.borrowernumber
WHERE
  reserves.branchcode LIKE &lt;&gt; AND
  reserves.found IS NULL AND
  reserves.suspend_until = &lt;&gt;
GROUP BY
  reserves.branchcode,
  reserves.suspend_until,
  messagess.message,
  reserves.borrowernumber,
  reserves.found,
  reserves.suspend
ORDER BY
  reserves.borrowernumber

























