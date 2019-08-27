/*
R.002908

----------

Name: GHW - messages
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-02-20 11:47:46
Modified on: 2017-02-20 11:53:59
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  message_queue.content
FROM
  message_queue
WHERE
  (message_queue.letter_code LIKE "PREDUEDGST") AND
  (message_queue.time_queued BETWEEN <<between the beginning of the day on "START DATE"|date>>  AND (<<and the end of the day on "END DATE"|date>>+ INTERVAL 1 DAY)) 
GROUP BY
  message_queue.time_queued, message_queue.content



