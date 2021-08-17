/*
R.002854

----------

Name: GHW - Hiawatha Sample
Created by: George H Williams

----------

Group:  HIAWATHA
     -

Created on: 2016-12-15 08:49:55
Modified on: 2021-08-16 20:39:36
Date last run: 2021-07-23 12:11:25

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
  (message_queue.letter_code = 'OVERDUE' OR
    message_queue.letter_code = 'FREEZE') AND
  message_queue.message_transport_type = 'email' AND
  message_queue.time_queued LIKE CONCAT(<<Enter date|date>>, '%') AND
  message_queue.from_address LIKE '%hiawathalibrary.org%'



