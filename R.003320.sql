/*
R.003320

----------

Name: ghw -Self-reg email
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-04-16 17:59:30
Modified on: 2020-04-16 18:04:03
Date last run: 2020-06-03 17:29:53

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  message_queue.message_id,
  message_queue.borrowernumber,
  message_queue.subject,
  message_queue.content,
  message_queue.metadata,
  message_queue.letter_code,
  message_queue.message_transport_type,
  message_queue.status,
  message_queue.time_queued,
  message_queue.to_address,
  message_queue.from_address,
  message_queue.content_type
FROM
  message_queue
WHERE
  message_queue.subject = 'Verify Your Account'
ORDER BY
  message_queue.message_id DESC



