/*
R.003080

----------

Name: Systempreferences sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-06-04 21:38:37
Modified on: 2019-04-23 15:53:15
Date last run: 2019-04-23 15:53:24

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Date_Format(message_queue.time_queued, "%Y.%m.%d - %W") AS DAY_SENT,
  message_queue.subject,
  message_queue.letter_code AS NOTICE_CODE,
  message_queue.message_transport_type AS DELIVERY_TYPE,
  Count(message_queue.message_id) AS COUNT
FROM
  message_queue
WHERE
  message_queue.subject LIKE Concat("%", <<Choose your library|ZBRAN>>,"%") AND
  message_queue.letter_code LIKE "OD%" AND
  message_queue.status = 'sent'
GROUP BY
  Date_Format(message_queue.time_queued, "%Y.%m.%d - %W"),
  message_queue.subject,
  message_queue.letter_code,
  message_queue.message_transport_type
ORDER BY
  DAY_SENT DESC,
  message_queue.subject,
  DELIVERY_TYPE



