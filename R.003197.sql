/*
R.003197

----------

Name: GHW - Overdue notice delivery history
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-04-23 15:54:55
Modified on: 2019-04-23 17:38:24
Date last run: 2019-09-25 12:10:51

----------

Public: 0
Expiry: 300

----------

A work-in-progress<br />

ODUE1 - goes to most patrons XX days after an item is overdue - XX is set on a library-by-library basis<br />
ODUE2 - goes to most patron 35 days after an item is due - warns patrons that they will be billed for the cost of the item in 10 days<br />
ODUE3 - goes to most patrons 45 days after an item is due - warns them that they are being billed for the cost of the item<br />

ODUE1_ILL - goes to ILL partners XX days after an item is overdue - XX is set on a library-by-library basis<br />
ODUE2_ILL - goes to ILL partners 35 days after an item is overdue<br />
ODUE3_ILL - goes to ILL partners 45 days after an item is overdue<br />

ODUE1_SPEC - goes to non-billed patrons XX days after an item is overdue - XX is set on a library-by-library basis<br />
ODUE2_SPEC - goes to non-billed patrons 35 days after an item is overdue<br />
ODUE3_SPEC - goes to non-billed patrons 45 days after an item is overdue<br />

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
  message_queue.subject LIKE Concat("%", <<Choose your library|LBRNAME>>,"%") AND
  message_queue.letter_code LIKE "OD%" AND
  message_queue.message_transport_type LIKE <<Choose delivery type|ZTRANSPORT>> AND
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



