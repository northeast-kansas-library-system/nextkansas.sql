/*
R.003797

----------

Name: GHW - e-mails sent domain count
Created by: George Williams

----------

Group: -
     -

Created on: 2024-01-31 13:51:20
Modified on: 2024-02-02 13:48:55
Date last run: 2024-02-23 16:12:40

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Date_Format(message_queue.updated_on, '%Y-%m-%d') AS DATE_SENT,
  Coalesce(SubString_Index(message_queue.to_address, '@', -1), '') AS SENT_TO,
  Count(DISTINCT message_queue.message_id) AS COUNT_OF_MESSAGES_SENT
FROM
  message_queue
WHERE
  message_queue.updated_on BETWEEN <> AND (<> + INTERVAL 1
  DAY)
GROUP BY
  Date_Format(message_queue.updated_on, '%Y-%m-%d'),
  Coalesce(SubString_Index(message_queue.to_address, '@', -1), '')
ORDER BY
  DATE_SENT DESC,
  SENT_TO

























